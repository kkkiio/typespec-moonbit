///|
priv enum RouteSegment {
  Lit(String)
  Param(String)
}

///|
priv struct RouteSpec {
  segments : Array[RouteSegment]
  meth_ctor : String
  route_id_ctor : String
  path_param_vars : Array[String]
}

///|
priv struct RouteTree {
  operations : Array[(String, RouteSpec)]
  bind : (Array[String], RouteTree)?
  edges : Array[(String, RouteTree)]
}

///|
fn push_unique(xs : Array[String], s : String) -> Unit {
  for x in xs {
    if x == s {
      return
    }
  }
  xs.push(s)
}

///|
fn sanitize_path_param_var(name : String) -> String {
  sanitize_identifier(@case.snake_case(name))
}

///|
fn string_common_prefix(a : String, b : String) -> String {
  let av = a.view()
  let bv = b.view()
  let mut i = 0
  while i < av.length() && i < bv.length() && av[i] == bv[i] {
    i += 1
  }
  av.view(end_offset=i).to_string()
}

///|
fn string_view_index_of(view : StringView, ch : UInt16) -> Int {
  let mut i = 0
  while i < view.length() {
    if view[i] == ch {
      return i
    }
    i += 1
  }
  -1
}

///|
fn parse_route_segments(template : String) -> Array[RouteSegment] raise {
  let mut remaining = template
  let segments : Array[RouteSegment] = Array::new()
  while remaining.length() > 0 {
    let view = remaining.view()
    let open = string_view_index_of(view, '{')
    if open == -1 {
      segments.push(Lit(remaining))
      break
    }
    if open > 0 {
      segments.push(Lit(view.view(end_offset=open).to_string()))
    }
    let close = {
      let mut i = open + 1
      while i < view.length() && view[i] != '}' {
        i += 1
      }
      if i >= view.length() {
        fail("invalid route template (missing `}`): \{template}")
      }
      i
    }
    let pname = view.view(start_offset=open + 1, end_offset=close).to_string()
    segments.push(Param(pname))
    remaining = view.view(start_offset=close + 1).to_string()
  }
  segments
}

///|
fn route_with_segments(
  r : RouteSpec,
  segments : Array[RouteSegment],
) -> RouteSpec {
  {
    segments,
    meth_ctor: r.meth_ctor,
    route_id_ctor: r.route_id_ctor,
    path_param_vars: r.path_param_vars,
  }
}

///|
fn into_route_tree(routes : Array[RouteSpec]) -> RouteTree raise {
  let operations : Array[(String, RouteSpec)] = Array::new()
  let rest : Array[RouteSpec] = Array::new()
  for r in routes {
    if r.segments.length() == 0 {
      for entry in operations {
        if entry.0 == r.meth_ctor {
          fail(
            "shared route is not supported yet: duplicate \{r.meth_ctor} route on the same path",
          )
        }
      }
      operations.push((r.meth_ctor, r))
    } else {
      rest.push(r)
    }
  }
  let literal : Array[RouteSpec] = Array::new()
  let parameterized : Array[RouteSpec] = Array::new()
  for r in rest {
    match r.segments[0] {
      Lit(_) => literal.push(r)
      Param(_) => parameterized.push(r)
    }
  }
  let mut edge_map : Array[(String, Array[RouteSpec])] = Array::new()
  for r in literal {
    match r.segments[0] {
      Lit(segment) => {
        let mut grouped = false
        for i in 0..<edge_map.length() {
          let edge = edge_map[i].0
          let prefix = string_common_prefix(segment, edge)
          if prefix.length() == 0 {
            continue
          }
          grouped = true
          let existing_routes = edge_map[i].1
          let new_edge_map : Array[(String, Array[RouteSpec])] = Array::new()
          for j in 0..<edge_map.length() {
            if j != i {
              new_edge_map.push(edge_map[j])
            }
          }
          edge_map = new_edge_map
          let mut merged = false
          for j in 0..<edge_map.length() {
            if edge_map[j].0 == prefix {
              let routes2 = edge_map[j].1
              for x in existing_routes {
                routes2.push(x)
              }
              routes2.push(r)
              edge_map[j] = (prefix, routes2)
              merged = true
              break
            }
          }
          if !merged {
            let routes2 : Array[RouteSpec] = Array::new()
            for x in existing_routes {
              routes2.push(x)
            }
            routes2.push(r)
            edge_map.push((prefix, routes2))
          }
          break
        }
        if !grouped {
          edge_map.push((segment, [r]))
        }
      }
      _ => fail("literal route expected")
    }
  }
  let edges : Array[(String, RouteTree)] = Array::new()
  for entry in edge_map {
    let edge = entry.0
    let rs = entry.1
    let next_routes : Array[RouteSpec] = Array::new()
    let edge_len = edge.length()
    for r in rs {
      match r.segments {
        [Lit(prefix), .. rest2] =>
          if prefix == edge {
            let segs : Array[RouteSegment] = Array::new()
            for seg in rest2 {
              segs.push(seg)
            }
            next_routes.push(route_with_segments(r, segs))
          } else {
            let left = prefix.view().view(start_offset=edge_len).to_string()
            guard left.length() > 0 else {
              fail("internal: empty literal after prefix removal")
            }
            let segs : Array[RouteSegment] = Array::new()
            segs.push(Lit(left))
            for seg in rest2 {
              segs.push(seg)
            }
            next_routes.push(route_with_segments(r, segs))
          }
        _ => fail("edge route prefix invariant broken")
      }
    }
    edges.push((edge, into_route_tree(next_routes)))
  }
  let bind : (Array[String], RouteTree)? = if parameterized.length() == 0 {
    None
  } else {
    let params : Array[String] = Array::new()
    let next_routes : Array[RouteSpec] = Array::new()
    for r in parameterized {
      match r.segments {
        [Param(pname), .. rest2] => {
          push_unique(params, pname)
          let segs : Array[RouteSegment] = Array::new()
          for seg in rest2 {
            segs.push(seg)
          }
          next_routes.push(route_with_segments(r, segs))
        }
        _ => fail("parameterized route expected")
      }
    }
    Some((params, into_route_tree(next_routes)))
  }
  { operations, bind, edges }
}

///|
fn wln_i(sb : StringBuilder, indent : Int, s : String) -> Unit {
  for _ in 0..<indent {
    sb.write_string("  ")
  }
  sb.write_string(s)
  sb.write_char('\n')
}

///|
fn emit_match_route_leaf_dispatch(
  sb : StringBuilder,
  indent : Int,
  operations : Array[(String, RouteSpec)],
) -> Unit {
  if operations.length() == 0 {
    wln_i(sb, indent, "return MatchRouteResult::NotMatched")
    return
  }
  wln_i(sb, indent, "match meth {")
  for entry in operations {
    let meth_ctor = entry.0
    let r = entry.1
    if r.path_param_vars.length() == 0 {
      wln_i(
        sb,
        indent + 1,
        "\{meth_ctor} => return MatchRouteResult::Matched(RouteId::\{r.route_id_ctor})",
      )
    } else {
      let args = StringBuilder::new()
      args.write_string("[")
      for i in 0..<r.path_param_vars.length() {
        if i > 0 {
          args.write_string(", ")
        }
        let v = r.path_param_vars[i]
        args.write_string("\{v}.to_string()")
      }
      args.write_string("]")
      wln_i(
        sb,
        indent + 1,
        "\{meth_ctor} => return MatchRouteResult::Matched(RouteId::\{r.route_id_ctor}(\{args.to_string()}))",
      )
    }
  }
  wln_i(sb, indent + 1, "_ => return MatchRouteResult::MethodNotAllowed")
  wln_i(sb, indent, "}")
}

///|
fn route_tree_uses_param_var(tree : RouteTree, param_var : String) -> Bool {
  for entry in tree.operations {
    let r = entry.1
    for v in r.path_param_vars {
      if v == param_var {
        return true
      }
    }
  }
  for edge_entry in tree.edges {
    if route_tree_uses_param_var(edge_entry.1, param_var) {
      return true
    }
  }
  match tree.bind {
    None => ()
    Some((_, next_tree)) =>
      if route_tree_uses_param_var(next_tree, param_var) {
        return true
      }
  }
  false
}

///|
fn emit_match_route_bind_param(
  sb : StringBuilder,
  indent : Int,
  param_names : Array[String],
  next_tree : RouteTree,
) -> Unit raise {
  let needed_param_names : Array[String] = Array::new()
  for p in param_names {
    let v = sanitize_path_param_var(p)
    if route_tree_uses_param_var(next_tree, v) {
      needed_param_names.push(p)
    }
  }
  let base_name = if needed_param_names.length() == 1 {
    sanitize_path_param_var(needed_param_names[0])
  } else if needed_param_names.length() > 1 {
    "param"
  } else {
    "_"
  }
  let idx_name = if base_name == "_" {
    "__param_idx"
  } else {
    "__\{base_name}_idx"
  }
  wln_i(sb, indent, "let mut \{idx_name} = @runtime.index_of_slash(path)")
  wln_i(
    sb,
    indent,
    "\{idx_name} = if \{idx_name} == -1 { path.length() } else { \{idx_name} }",
  )
  if base_name != "_" {
    wln_i(sb, indent, "let \{base_name} = path.view(end_offset=\{idx_name})")
  }
  wln_i(sb, indent, "let path = path.view(start_offset=\{idx_name})")
  if needed_param_names.length() > 1 {
    for p in needed_param_names {
      let v = sanitize_path_param_var(p)
      wln_i(sb, indent, "let \{v} = \{base_name}")
    }
  }
  emit_match_route_handler(sb, indent, next_tree)
}

///|
fn emit_match_route_handler(
  sb : StringBuilder,
  indent : Int,
  tree : RouteTree,
) -> Unit raise {
  wln_i(sb, indent, "if path.length() == 0 {")
  emit_match_route_leaf_dispatch(sb, indent + 1, tree.operations)
  wln_i(sb, indent, "}")
  if tree.edges.length() == 0 && tree.bind is None {
    wln_i(sb, indent, "return MatchRouteResult::NotMatched")
    return
  }
  if tree.edges.length() == 0 {
    match tree.bind {
      None => fail("internal: route tree termination invariant broken")
      Some((param_names, next_tree)) => {
        emit_match_route_bind_param(sb, indent, param_names, next_tree)
        return
      }
    }
  }
  wln_i(sb, indent, "match path {")
  for edge_entry in tree.edges {
    let edge = edge_entry.0
    let next_tree = edge_entry.1
    for _ in 0..<(indent + 1) {
      sb.write_string("  ")
    }
    sb.write_string("[..\"")
    write_escaped_string_literal(sb, edge)
    sb.write_string("\", ..path] => {\n")
    emit_match_route_handler(sb, indent + 2, next_tree)
    wln_i(sb, indent + 1, "}")
  }
  match tree.bind {
    None => wln_i(sb, indent + 1, "_ => return MatchRouteResult::NotMatched")
    Some((param_names, next_tree)) => {
      wln_i(sb, indent + 1, "_ => {")
      emit_match_route_bind_param(sb, indent + 2, param_names, next_tree)
      wln_i(sb, indent + 1, "}")
    }
  }
  wln_i(sb, indent, "}")
}
