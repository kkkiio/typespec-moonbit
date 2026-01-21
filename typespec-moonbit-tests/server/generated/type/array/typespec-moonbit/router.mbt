///|
/// Model Array
pub(all) struct Array {} derive (
  Show,
  Default,
  ToJson,
  @json.FromJson(rename_fields="camelCase"),
)

///|
/// Traits for operation handlers
pub(open) trait Int32ValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait Int64ValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait ModelValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait StringValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait BooleanValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait Float32ValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait UnknownValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait DatetimeValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait DurationValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableFloatValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableInt32ValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableModelValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableStringValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableBooleanValueHandler {
  async get(Self) -> Unit
  async put(Self, body : Array) -> Unit
}

///|
pub struct Router {
  dispatch : async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit
}

///|
pub async fn Router::dispatch(
  self : Router,
  request : @http.Request,
  body : &@io.Reader,
  conn : @http.ServerConnection,
) -> Unit {
  (self.dispatch)(request, body, conn)
}

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
  H10 : NullableInt32ValueHandler,
  H11 : NullableModelValueHandler,
  H12 : NullableStringValueHandler,
  H13 : NullableBooleanValueHandler,
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
  h11 : H11,
  h12 : H12,
  h13 : H13,
) -> Router {
  Router::{
    dispatch: async fn(req, body_stream, conn) {
      let path = strip_request_query(req.path)
      if false {
        ()
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/int32", path) {
        ignore(body_stream)
        h0.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/int32", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_2_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h0.put(p_2_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/int64", path) {
        ignore(body_stream)
        h1.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/int64", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_4_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h1.put(p_4_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/model", path) {
        ignore(body_stream)
        h2.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/model", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_6_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h2.put(p_6_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/string", path) {
        ignore(body_stream)
        h3.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/string", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_8_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h3.put(p_8_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/boolean", path) {
        ignore(body_stream)
        h4.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/boolean", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_10_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h4.put(p_10_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/float32", path) {
        ignore(body_stream)
        h5.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/float32", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_12_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h5.put(p_12_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/unknown", path) {
        ignore(body_stream)
        h6.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/unknown", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_14_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h6.put(p_14_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/datetime", path) {
        ignore(body_stream)
        h7.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/datetime", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_16_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h7.put(p_16_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/duration", path) {
        ignore(body_stream)
        h8.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/duration", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_18_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h8.put(p_18_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/nullable-float", path) {
        ignore(body_stream)
        h9.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/nullable-float", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_20_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h9.put(p_20_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/nullable-int32", path) {
        ignore(body_stream)
        h10.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/nullable-int32", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_22_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h10.put(p_22_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/nullable-model", path) {
        ignore(body_stream)
        h11.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/nullable-model", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_24_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h11.put(p_24_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/nullable-string", path) {
        ignore(body_stream)
        h12.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/nullable-string", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_26_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h12.put(p_26_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/array/nullable-boolean", path) {
        ignore(body_stream)
        h13.get()
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/type/array/nullable-boolean", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_28_body : Array = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h13.put(p_28_body)
        conn.send_response(204, "No Content")
      } else {
        conn.send_response(404, "NotFound")
        conn.write("not found")
      }
    },
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
