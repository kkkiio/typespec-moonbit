///|
/// Model BodyModel
pub(all) struct BodyModel {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model AnonymousModel1
pub(all) struct AnonymousModel1 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Traits for operation handlers
pub(open) trait BodyOptionalityHandler {
  async required_explicit(Self, body : BodyModel) -> Unit
  async required_implicit(Self, body : AnonymousModel1) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait OptionalExplicitHandler {
  async set(Self, body : BodyModel) -> Unit
  async omit(Self, body : BodyModel) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : BodyOptionalityHandler, H1 : OptionalExplicitHandler] create_router(
  h0 : H0,
  h1 : H1,
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let path = strip_request_query(req.path)
    if false {
      ()
    } else if req.meth == @http.Post &&
      match_path_template(
        "/parameters/body-optionality/required-explicit", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_1_body : BodyModel = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      h0.required_explicit(p_1_body)
      conn.send_response(204, "No Content")
    } else if req.meth == @http.Post &&
      match_path_template(
        "/parameters/body-optionality/required-implicit", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_2_body : AnonymousModel1 = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      h0.required_implicit(p_2_body)
      conn.send_response(204, "No Content")
    } else if req.meth == @http.Post &&
      match_path_template(
        "/parameters/body-optionality/optional-explicit/set", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_3_body : BodyModel = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      h1.set(p_3_body)
      conn.send_response(204, "No Content")
    } else if req.meth == @http.Post &&
      match_path_template(
        "/parameters/body-optionality/optional-explicit/omit", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_4_body : BodyModel = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      h1.omit(p_4_body)
      conn.send_response(204, "No Content")
    } else {
      conn.send_response(404, "NotFound")
      conn.write("not found")
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
  let t = template.trim(char_set="/")
  let p = path.trim(char_set="/")
  let t_segs = if t == "" { [] } else { t.split("/").to_array() }
  let p_segs = if p == "" { [] } else { p.split("/").to_array() }
  if t_segs.length() != p_segs.length() {
    return false
  }
  for i in 0..<t_segs.length() {
    let ts = t_segs[i].to_string()
    let ps = p_segs[i].to_string()
    if ts.length() >= 2 && ts.has_prefix("{") && ts.has_suffix("}") {
      if ps == "" {
        return false
      }
    } else if ts != ps {
      return false
    }
  }
  true
}
