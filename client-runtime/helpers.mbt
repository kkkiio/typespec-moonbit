///|
/// 将 path 字符串按 WHATWG URL Standard 的 path percent-encode set 做编码（类似 Rust `url::Url::set_path`）。
///
/// - 保留 `/` 作为路径分隔符（不会被编码为 `%2F`）
/// - 对空格等不安全字符编码为 `%XX`
/// - 如果已经存在合法的 `%XX`，不会 double-encode
pub fn encode_path(path : String) -> String {
  let bytes = @encoding/utf8.encode(path)
  let out = StringBuilder::new(size_hint=bytes.length() * 3)
  let mut i = 0
  while i < bytes.length() {
    let b = bytes[i]
    // keep %XX
    if b.to_int() == 0x25 &&
      i + 2 < bytes.length() &&
      is_hex_digit(bytes[i + 1]) &&
      is_hex_digit(bytes[i + 2]) {
      out.write_char('%')
      out.write_char(bytes[i + 1].to_int().unsafe_to_char())
      out.write_char(bytes[i + 2].to_int().unsafe_to_char())
      i += 3
      continue
    }
    // '/' as separator
    if b.to_int() == 0x2F {
      out.write_char('/')
      i += 1
      continue
    }
    // for special URLs, backslash is treated as separator
    if b.to_int() == 0x5C {
      out.write_char('/')
      i += 1
      continue
    }
    if should_encode_path_byte(b) {
      out.write_char('%')
      out.write_string(hex2(b))
    } else {
      out.write_char(b.to_int().unsafe_to_char())
    }
    i += 1
  }
  out.to_string()
}

///|
/// 将 request target 编码为可用于 HTTP 请求的路径字符串。
///
/// - 仅对 `?` 或 `#` 之前的 path 部分做 `encode_path` 等价处理
/// - `?query` 与 `#fragment` 部分保持原样（至少保证 `?` 不会被编码为 `%3F`）
pub fn encode_request_target(target : String) -> String {
  let bytes = @encoding/utf8.encode(target)
  let out = StringBuilder::new(size_hint=bytes.length() * 3)
  let mut i = 0
  while i < bytes.length() {
    let b = bytes[i]
    // query/fragment separator: keep as-is, and keep the tail as-is
    if b.to_int() == 0x3F || b.to_int() == 0x23 {
      out.write_char(b.to_int().unsafe_to_char())
      i += 1
      while i < bytes.length() {
        let bb = bytes[i]
        // keep %XX
        if bb.to_int() == 0x25 &&
          i + 2 < bytes.length() &&
          is_hex_digit(bytes[i + 1]) &&
          is_hex_digit(bytes[i + 2]) {
          out.write_char('%')
          out.write_char(bytes[i + 1].to_int().unsafe_to_char())
          out.write_char(bytes[i + 2].to_int().unsafe_to_char())
          i += 3
          continue
        }
        // keep ASCII bytes as-is, percent-encode others
        let x = bb.to_int()
        if x <= 0x1F || x == 0x7F || x >= 0x80 {
          out.write_char('%')
          out.write_string(hex2(bb))
        } else {
          out.write_char(x.unsafe_to_char())
        }
        i += 1
      }
      break
    }
    // keep %XX
    if b.to_int() == 0x25 &&
      i + 2 < bytes.length() &&
      is_hex_digit(bytes[i + 1]) &&
      is_hex_digit(bytes[i + 2]) {
      out.write_char('%')
      out.write_char(bytes[i + 1].to_int().unsafe_to_char())
      out.write_char(bytes[i + 2].to_int().unsafe_to_char())
      i += 3
      continue
    }
    // '/' as separator
    if b.to_int() == 0x2F {
      out.write_char('/')
      i += 1
      continue
    }
    // for special URLs, backslash is treated as separator
    if b.to_int() == 0x5C {
      out.write_char('/')
      i += 1
      continue
    }
    if should_encode_path_byte(b) {
      out.write_char('%')
      out.write_string(hex2(b))
    } else {
      out.write_char(b.to_int().unsafe_to_char())
    }
    i += 1
  }
  out.to_string()
}

///|
fn is_hex_digit(b : Byte) -> Bool {
  match b.to_int() {
    0x30..=0x39 => true // 0-9
    0x41..=0x46 => true // A-F
    0x61..=0x66 => true // a-f
    _ => false
  }
}

///|
fn hex2(byte : Byte) -> String {
  let mut s = byte.to_int().to_string(radix=16).to_upper()
  if s.length() == 1 {
    s = "0" + s
  }
  s
}

///|
fn should_encode_path_byte(b : Byte) -> Bool {
  // WHATWG URL Standard: path percent-encode set:
  // controls + space + " < > ` + # ? { }
  let x = b.to_int()
  match x {
    0x00..=0x1F => true
    0x7F => true
    0x20 => true // space
    0x22 => true // "
    0x3C => true // <
    0x3E => true // >
    0x60 => true // `
    0x23 => true // #
    0x3F => true // ?
    0x7B => true // {
    0x7D => true // }
    0x25 => true // %
    // for simplicity: encode non-ascii bytes
    0x80..=0xFF => true
    _ => false
  }
}

///|
pub fn join(xs : Array[String], sep : String) -> String {
  let sb = StringBuilder::new(size_hint=32)
  for i in 0..<xs.length() {
    if i > 0 {
      sb.write_string(sep)
    }
    sb.write_string(xs[i])
  }
  sb.to_string()
}

///|
/// RFC6570 的最小实现：用于生成的 URI template 展开（目前只覆盖 string / array / record 三类）。
pub fn expand_string(
  op : String,
  name : String,
  _explode : Bool,
  value : String,
) -> String {
  match op {
    "?" => "?" + name + "=" + value
    "&" => "&" + name + "=" + value
    "/" => "/" + value
    "." => "." + value
    ";" => ";" + name + "=" + value
    _ => value
  }
}

///|
pub fn expand_array(
  op : String,
  name : String,
  explode : Bool,
  value : Array[String],
) -> String {
  match op {
    "?" =>
      if explode {
        let parts = Array::new(capacity=value.length())
        for x in value {
          parts.push(name + "=" + x)
        }
        "?" + join(parts, "&")
      } else {
        "?" + name + "=" + join(value, ",")
      }
    "&" =>
      if explode {
        let parts = Array::new(capacity=value.length())
        for x in value {
          parts.push("&" + name + "=" + x)
        }
        join(parts, "")
      } else {
        "&" + name + "=" + join(value, ",")
      }
    "/" => "/" + join(value, if explode { "/" } else { "," })
    "." => "." + join(value, if explode { "." } else { "," })
    ";" =>
      if explode {
        let parts = Array::new(capacity=value.length())
        for x in value {
          parts.push(";" + name + "=" + x)
        }
        join(parts, "")
      } else {
        ";" + name + "=" + join(value, ",")
      }
    _ => join(value, ",")
  }
}

///|
pub fn expand_record(
  op : String,
  name : String,
  explode : Bool,
  value : Map[String, Int],
) -> String {
  let pairs = value.to_array()
  // Keep output stable by sorting by key.
  pairs.sort_by_key(p => p.0)
  match op {
    "?" =>
      if explode {
        "?" + expand_record_inner(pairs, true, "&")
      } else {
        "?" + name + "=" + expand_record_inner(pairs, false, ",")
      }
    "&" =>
      if explode {
        let parts = Array::new()
        for kv in pairs {
          let k = kv.0
          let v = kv.1
          parts.push("&" + k + "=" + v.to_string())
        }
        join(parts, "")
      } else {
        "&" + name + "=" + expand_record_inner(pairs, false, ",")
      }
    "/" =>
      "/" + expand_record_inner(pairs, explode, if explode { "/" } else { "," })
    "." =>
      "." + expand_record_inner(pairs, explode, if explode { "." } else { "," })
    ";" =>
      if explode {
        let parts = Array::new()
        for kv in pairs {
          let k = kv.0
          let v = kv.1
          parts.push(";" + k + "=" + v.to_string())
        }
        join(parts, "")
      } else {
        ";" + name + "=" + expand_record_inner(pairs, false, ",")
      }
    _ => expand_record_inner(pairs, explode, ",")
  }
}

///|
fn expand_record_inner(
  pairs : Array[(String, Int)],
  explode : Bool,
  sep : String,
) -> String {
  let parts = Array::new()
  if explode {
    for kv in pairs {
      let k = kv.0
      let v = kv.1
      parts.push(k + "=" + v.to_string())
    }
    join(parts, sep)
  } else {
    for kv in pairs {
      let k = kv.0
      let v = kv.1
      parts.push(k)
      parts.push(v.to_string())
    }
    join(parts, ",")
  }
}

///|
/// Query 编码辅助（percent-encode query component）。
///
/// - 保留已经是 `%XX` 的序列（避免 double-encode）
/// - 仅保留 RFC3986 unreserved: ALPHA / DIGIT / "-" / "." / "_" / "~"
/// - 其它 byte 一律 `%XX`（例如空格 -> `%20`，`|` -> `%7C`）
pub fn encode_query_component(s : String) -> String {
  let bytes = @encoding/utf8.encode(s)
  let out = StringBuilder::new(size_hint=bytes.length() * 3)
  let mut i = 0
  while i < bytes.length() {
    let b = bytes[i]
    // keep %XX
    if b.to_int() == 0x25 &&
      i + 2 < bytes.length() &&
      is_hex_digit(bytes[i + 1]) &&
      is_hex_digit(bytes[i + 2]) {
      out.write_char('%')
      out.write_char(bytes[i + 1].to_int().unsafe_to_char())
      out.write_char(bytes[i + 2].to_int().unsafe_to_char())
      i += 3
      continue
    }
    if should_encode_query_byte(b) {
      out.write_char('%')
      out.write_string(hex2(b))
    } else {
      out.write_char(b.to_int().unsafe_to_char())
    }
    i += 1
  }
  out.to_string()
}

///|
fn should_encode_query_byte(b : Byte) -> Bool {
  let x = b.to_int()
  // unreserved = ALPHA / DIGIT / "-" / "." / "_" / "~"
  if (x >= 0x30 && x <= 0x39) || // 0-9
    (x >= 0x41 && x <= 0x5A) || // A-Z
    (x >= 0x61 && x <= 0x7A) || // a-z
    x == 0x2D || // -
    x == 0x2E || // .
    x == 0x5F || // _
    x == 0x7E { // ~
    false
  } else {
    true
  }
}

///|
pub fn expect_status_code(
  response : @http.Response,
  expected : Int,
) -> Unit raise {
  if response.code != expected {
    fail(
      "unexpected status code: expected \{expected.to_string()}, got \{response.code.to_string()}",
    )
  }
}

///|
pub fn expect_status_range(
  response : @http.Response,
  start : Int,
  end_ : Int,
) -> Unit raise {
  if response.code < start || response.code > end_ {
    fail(
      "unexpected status code: expected \{start.to_string()}..\{end_.to_string()}, got \{response.code.to_string()}",
    )
  }
}

///|
pub fn has_json_content_type(response : @http.Response) -> Bool {
  let target = "content-type"
  let mut content_type : String? = None
  for k, v in response.headers {
    if k.to_lower() == target {
      content_type = Some(v)
      break
    }
  }
  match content_type {
    Some(v) => v.to_lower().contains("application/json")
    None => false
  }
}

///|
pub fn expect_json_content_type(response : @http.Response) -> Unit raise {
  if !has_json_content_type(response) {
    fail(
      "unexpected content-type: expected application/json, got \{response.headers.to_json().stringify()}",
    )
  }
}

///|
pub(all) enum BytesEncoding {
  Base64
  Base64Url
}

///|
pub fn encode_bytes(bytes : Bytes, encoding : BytesEncoding) -> String {
  match encoding {
    Base64 => @codec/base64.encode(bytes, url_safe=false)
    Base64Url =>
      trim_trailing_padding(@codec/base64.encode(bytes, url_safe=true))
  }
}

///|
pub fn encode_bytes_array(
  values : Array[Bytes],
  encoding : BytesEncoding,
  delimiter : String,
) -> String {
  let encoded = encode_bytes_list(values, encoding)
  join(encoded, delimiter)
}

///|
pub fn encode_bytes_list(
  values : Array[Bytes],
  encoding : BytesEncoding,
) -> Array[String] {
  let encoded = Array::new(capacity=values.length())
  for value in values {
    encoded.push(encode_bytes(value, encoding))
  }
  encoded
}

///|
pub fn decode_bytes(encoded : String, encoding : BytesEncoding) -> Bytes raise {
  match encoding {
    Base64 => @codec/base64.decode(encoded, url_safe=false)
    Base64Url => @codec/base64.decode(pad_base64url(encoded), url_safe=true)
  }
}

///|
fn trim_trailing_padding(s : String) -> String {
  let chars = s.to_array()
  let mut end = chars.length()
  while end > 0 && chars[end - 1] == '=' {
    end -= 1
  }
  if end == chars.length() {
    return s
  }
  let sb = StringBuilder::new(size_hint=end)
  for i in 0..<end {
    sb.write_char(chars[i])
  }
  sb.to_string()
}

///|
fn pad_base64url(s : String) -> String raise {
  let rem = s.length() % 4
  if rem == 0 {
    s
  } else if rem == 2 {
    s + "=="
  } else if rem == 3 {
    s + "="
  } else {
    fail("invalid base64url length: " + s.length().to_string())
  }
}
