///|
/// Traits for operation handlers
pub(open) trait NotDiscriminatedHandler {
  async post_valid(Self, body : Siamese) -> Unit
  async get_valid(Self) -> Siamese
  async put_valid(Self, body : Siamese) -> Siamese
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : NotDiscriminatedHandler] create_router(
  not_discriminated_handler~ : H0,
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if false {
      ()
    } else if req.meth == @http.Post &&
      match_path_template(
        "/type/model/inheritance/not-discriminated/valid", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_1_body : Siamese = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      not_discriminated_handler.post_valid(p_1_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template(
        "/type/model/inheritance/not-discriminated/valid", path,
      ) {
      ignore(body_stream)
      let resp_body = not_discriminated_handler.get_valid()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template(
        "/type/model/inheritance/not-discriminated/valid", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_3_body : Siamese = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      let resp_body = not_discriminated_handler.put_valid(p_3_body)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
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
