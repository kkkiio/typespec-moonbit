///|
/// Nullable helper used for `T | null`.
pub(all) struct Nullable[T] {
  value : T?
} derive(Show, Default)

///|
pub fn[T] Nullable::some(v : T) -> Nullable[T] {
  { value: Some(v) }
}

///|
pub fn[T] Nullable::none() -> Nullable[T] {
  { value: None }
}

///|
pub impl[T : ToJson] ToJson for Nullable[T] with to_json(self : Nullable[T]) -> Json {
  match self.value {
    Some(v) => v.to_json()
    None => Json::null()
  }
}

///|
pub impl[T : @json.FromJson] @json.FromJson for Nullable[T] with from_json(
  j : Json,
  path : @json.JsonPath,
) -> Nullable[T] raise @json.JsonDecodeError {
  if j == Json::null() {
    { value: None }
  } else {
    { value: Some(@json.from_json(j, path~)) }
  }
}

///|
/// Model InnerModel
pub(all) struct InnerModel {
  property : String
  children : Map[String, InnerModel]?
} derive(Show, Default, @json.FromJson(rename_fields="camelCase"))

///|
pub impl ToJson for InnerModel with to_json(self : InnerModel) -> Json {
  let m : Map[String, Json] = Map::new()
  m.set("property", self.property.to_json())
  match self.children {
    Some(v) => m.set("children", v.to_json())
    None => ()
  }
  Json::object(m)
}

///|
/// Traits for operation handlers
pub(open) trait Int32ValueHandler {
  async get(Self) -> Map[String, Int]
  async put(Self, body : Map[String, Int]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait Int64ValueHandler {
  async get(Self) -> Map[String, Int64]
  async put(Self, body : Map[String, Int64]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait ModelValueHandler {
  async get(Self) -> Map[String, InnerModel]
  async put(Self, body : Map[String, InnerModel]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait StringValueHandler {
  async get(Self) -> Map[String, String]
  async put(Self, body : Map[String, String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait BooleanValueHandler {
  async get(Self) -> Map[String, Bool]
  async put(Self, body : Map[String, Bool]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait Float32ValueHandler {
  async get(Self) -> Map[String, Double]
  async put(Self, body : Map[String, Double]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait UnknownValueHandler {
  async get(Self) -> Map[String, Json]
  async put(Self, body : Map[String, Json]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait DatetimeValueHandler {
  async get(Self) -> Map[String, String]
  async put(Self, body : Map[String, String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait DurationValueHandler {
  async get(Self) -> Map[String, String]
  async put(Self, body : Map[String, String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableFloatValueHandler {
  async get(Self) -> Map[String, Nullable[Double]]
  async put(Self, body : Map[String, Nullable[Double]]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait RecursiveModelValueHandler {
  async get(Self) -> Map[String, InnerModel]
  async put(Self, body : Map[String, InnerModel]) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[
  H0 : Int32ValueHandler,
  H1 : Int64ValueHandler,
  H2 : ModelValueHandler,
  H3 : StringValueHandler,
  H4 : BooleanValueHandler,
  H5 : Float32ValueHandler,
  H6 : UnknownValueHandler,
  H7 : DatetimeValueHandler,
  H8 : DurationValueHandler,
  H9 : NullableFloatValueHandler,
  H10 : RecursiveModelValueHandler,
] create_router(
  h0 : H0,
  h1 : H1,
  h2 : H2,
  h3 : H3,
  h4 : H4,
  h5 : H5,
  h6 : H6,
  h7 : H7,
  h8 : H8,
  h9 : H9,
  h10 : H10,
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let path = strip_request_query(req.path)
    if false {
      ()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/int32", path) {
      ignore(body_stream)
      let resp_body = h0.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/int32", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_2_body : Map[String, Int] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      h0.put(p_2_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/int64", path) {
      ignore(body_stream)
      let resp_body = h1.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/int64", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_4_body : Map[String, Int64] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      h1.put(p_4_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/model", path) {
      ignore(body_stream)
      let resp_body = h2.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/model", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_6_body : Map[String, InnerModel] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      h2.put(p_6_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/string", path) {
      ignore(body_stream)
      let resp_body = h3.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/string", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_8_body : Map[String, String] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      h3.put(p_8_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/boolean", path) {
      ignore(body_stream)
      let resp_body = h4.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/boolean", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_10_body : Map[String, Bool] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      h4.put(p_10_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/float32", path) {
      ignore(body_stream)
      let resp_body = h5.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/float32", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_12_body : Map[String, Double] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      h5.put(p_12_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/unknown", path) {
      ignore(body_stream)
      let resp_body = h6.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/unknown", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_14_body : Map[String, Json] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      h6.put(p_14_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/datetime", path) {
      ignore(body_stream)
      let resp_body = h7.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/datetime", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_16_body : Map[String, String] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      h7.put(p_16_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/duration", path) {
      ignore(body_stream)
      let resp_body = h8.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/duration", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_18_body : Map[String, String] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      h8.put(p_18_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/nullable-float", path) {
      ignore(body_stream)
      let resp_body = h9.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/nullable-float", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_20_body : Map[String, Nullable[Double]] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      h9.put(p_20_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/model/recursive", path) {
      ignore(body_stream)
      let resp_body = h10.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/model/recursive", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_22_body : Map[String, InnerModel] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      h10.put(p_22_body)
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
