///|
/// Traits for operation handlers
pub(open) trait StringHandler {
  async get_known_value(Self) -> String
  async get_unknown_value(Self) -> String
  async put_known_value(Self, content_type : String, body : String) -> Unit
  async put_unknown_value(Self, content_type : String, body : String) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : StringHandler] create_router(h0 : H0) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if false {
      ()
    } else if req.meth == @http.Get &&
      match_path_template("/type/enum/extensible/string/known-value", path) {
      ignore(body_stream)
      let resp_body = h0.get_known_value()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/enum/extensible/string/unknown-value", path) {
      ignore(body_stream)
      let resp_body = h0.get_unknown_value()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/enum/extensible/string/known-value", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_3_content_type = get_header(req.headers, "Content-Type")
      let p_3_body = body_str
      h0.put_known_value(p_3_content_type, p_3_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/enum/extensible/string/unknown-value", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_4_content_type = get_header(req.headers, "Content-Type")
      let p_4_body = body_str
      h0.put_unknown_value(p_4_content_type, p_4_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else {
      conn.send_response(404, "NotFound")
      conn.write("not found")
      conn.end_response()
    }
  }
}

///|
fn strip_request_query(path : String) -> String {
  let parts = path.split("?").to_array()
  if parts.length() == 0 {
    path
  } else {
    parts[0].to_string()
  }
}

///|
fn match_path_template(template : String, path : String) -> Bool {
  let tlen = template.length()
  let plen = path.length()
  let mut ti = 0
  let mut pi = 0
  while ti < tlen && pi < plen {
    if template.code_unit_at(ti) == '{' {
      // find matching `}` in template
      let mut close = ti + 1
      while close < tlen && template.code_unit_at(close) != '}' {
        close += 1
      }
      if close >= tlen {
        return false
      }
      // match a non-empty path segment
      let seg_start = pi
      while pi < plen && path.code_unit_at(pi) != '/' {
        pi += 1
      }
      if pi == seg_start {
        return false
      }
      ti = close + 1
    } else {
      if template.code_unit_at(ti) != path.code_unit_at(pi) {
        return false
      }
      ti += 1
      pi += 1
    }
  }
  ti == tlen && pi == plen
}

///|
fn get_path_param(template : String, path : String, name : String) -> String {
  let tlen = template.length()
  let plen = path.length()
  let mut ti = 0
  let mut pi = 0
  while ti < tlen && pi < plen {
    if template.code_unit_at(ti) == '{' {
      let mut close = ti + 1
      while close < tlen && template.code_unit_at(close) != '}' {
        close += 1
      }
      if close >= tlen {
        return ""
      }
      let key_sb = StringBuilder::new(size_hint=close - (ti + 1))
      for k in (ti + 1)..<close {
        key_sb.write_char(template.code_unit_at(k).to_int().unsafe_to_char())
      }
      let key = key_sb.to_string()
      let seg_start = pi
      while pi < plen && path.code_unit_at(pi) != '/' {
        pi += 1
      }
      if key == name {
        let seg_sb = StringBuilder::new(size_hint=pi - seg_start)
        for k in seg_start..<pi {
          seg_sb.write_char(path.code_unit_at(k).to_int().unsafe_to_char())
        }
        return seg_sb.to_string()
      }
      ti = close + 1
    } else {
      if template.code_unit_at(ti) != path.code_unit_at(pi) {
        return ""
      }
      ti += 1
      pi += 1
    }
  }
  ""
}

///|
fn get_header(headers : Map[String, String], name : String) -> String {
  match headers.get(name.to_lower().to_string()) {
    Some(v) => v
    None => ""
  }
}

///|
fn get_query_param(full_path : String, name : String) -> String {
  let parts = full_path.split("?").to_array()
  if parts.length() < 2 {
    return ""
  }
  let query = parts[1].to_string()
  for pair in query.split("&") {
    let kv = pair.split("=").to_array()
    if kv.length() >= 2 {
      if kv[0].to_string() == name {
        return kv[1].to_string()
      }
    }
  }
  ""
}
