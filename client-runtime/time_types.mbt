///|
pub(all) enum DateTimeEncoding {
  Rfc3339
  Rfc7231
  UnixTimestamp
}

///|
pub(all) enum DurationEncoding {
  Iso8601
  Seconds
  Milliseconds
}

///|
pub(all) enum NumberWireType {
  Int32
  Int64
  Float
  Float32
  Float64
}

///|
pub(all) struct UtcDateTime {
  unix_second : Int64
  nanosecond : Int
  frac_digits : Int
} derive(Show, Eq, Compare)

///|
pub(all) struct OffsetDateTime {
  instant : UtcDateTime
  offset : @time.ZoneOffset
} derive(Show, Eq, Compare)

///|
pub(all) struct PlainDate {
  value : @time.PlainDate
} derive(Show, Eq, Compare)

///|
pub(all) struct PlainTime {
  value : @time.PlainTime
} derive(Show, Eq, Compare)

///|
pub(all) struct Duration {
  total_nanoseconds : Int64
} derive(Show, Eq, Compare)

///|
pub fn UtcDateTime::from_string(value : String) -> UtcDateTime raise {
  let (year, month, day, hour, minute, second, nano, frac_digits, offset) = parse_rfc3339(
    value,
  )
  let pdt = @time.PlainDateTime::of(
    year,
    month,
    day,
    hour~,
    minute~,
    second~,
    nanosecond=nano,
  )
  {
    unix_second: pdt.to_unix_second() - offset.to_int64(),
    nanosecond: nano,
    frac_digits,
  }
}

///|
pub fn UtcDateTime::to_string(self : UtcDateTime) -> String {
  format_rfc3339_from_instant(
    self.unix_second,
    self.nanosecond,
    self.frac_digits,
  )
}

///|
pub fn OffsetDateTime::from_string(value : String) -> OffsetDateTime raise {
  let (year, month, day, hour, minute, second, nano, frac_digits, offset) = parse_rfc3339(
    value,
  )
  let pdt = @time.PlainDateTime::of(
    year,
    month,
    day,
    hour~,
    minute~,
    second~,
    nanosecond=nano,
  )
  {
    instant: UtcDateTime::{
      unix_second: pdt.to_unix_second() - offset.to_int64(),
      nanosecond: nano,
      frac_digits,
    },
    offset: @time.ZoneOffset::from_seconds(offset),
  }
}

///|
pub fn OffsetDateTime::to_string(self : OffsetDateTime) -> String {
  format_rfc3339_from_instant(
    self.instant.unix_second,
    self.instant.nanosecond,
    self.instant.frac_digits,
  )
}

///|
pub fn PlainDate::from_string(value : String) -> PlainDate raise {
  { value: @time.PlainDate::from_string(value) }
}

///|
pub fn PlainDate::to_string(self : PlainDate) -> String {
  self.value.to_string()
}

///|
pub fn PlainTime::from_string(value : String) -> PlainTime raise {
  { value: @time.PlainTime::from_string(value) }
}

///|
pub fn PlainTime::to_string(self : PlainTime) -> String {
  self.value.to_string()
}

///|
pub fn Duration::from_string(value : String) -> Duration raise {
  { total_nanoseconds: parse_duration_to_nanoseconds(value) }
}

///|
pub fn Duration::to_string(self : Duration) -> String {
  format_duration_from_nanoseconds(self.total_nanoseconds)
}

///|
pub impl ToJson for UtcDateTime with to_json(self : UtcDateTime) -> Json {
  Json::string(self.to_string())
}

///|
pub impl @json.FromJson for UtcDateTime with from_json(
  j : Json,
  path : @json.JsonPath,
) -> UtcDateTime raise @json.JsonDecodeError {
  let raw : String = @json.from_json(j, path~)
  UtcDateTime::from_string(raw) catch {
    err => raise @json.JsonDecodeError((path, "invalid utcDateTime: \{err}"))
  }
}

///|
pub impl ToJson for OffsetDateTime with to_json(self : OffsetDateTime) -> Json {
  Json::string(self.to_string())
}

///|
pub impl @json.FromJson for OffsetDateTime with from_json(
  j : Json,
  path : @json.JsonPath,
) -> OffsetDateTime raise @json.JsonDecodeError {
  let raw : String = @json.from_json(j, path~)
  OffsetDateTime::from_string(raw) catch {
    err => raise @json.JsonDecodeError((path, "invalid offsetDateTime: \{err}"))
  }
}

///|
pub impl ToJson for PlainDate with to_json(self : PlainDate) -> Json {
  Json::string(self.to_string())
}

///|
pub impl @json.FromJson for PlainDate with from_json(
  j : Json,
  path : @json.JsonPath,
) -> PlainDate raise @json.JsonDecodeError {
  let raw : String = @json.from_json(j, path~)
  PlainDate::from_string(raw) catch {
    err => raise @json.JsonDecodeError((path, "invalid plainDate: \{err}"))
  }
}

///|
pub impl ToJson for PlainTime with to_json(self : PlainTime) -> Json {
  Json::string(self.to_string())
}

///|
pub impl @json.FromJson for PlainTime with from_json(
  j : Json,
  path : @json.JsonPath,
) -> PlainTime raise @json.JsonDecodeError {
  let raw : String = @json.from_json(j, path~)
  PlainTime::from_string(raw) catch {
    err => raise @json.JsonDecodeError((path, "invalid plainTime: \{err}"))
  }
}

///|
pub impl ToJson for Duration with to_json(self : Duration) -> Json {
  Json::string(self.to_string())
}

///|
pub impl @json.FromJson for Duration with from_json(
  j : Json,
  path : @json.JsonPath,
) -> Duration raise @json.JsonDecodeError {
  let raw : String = @json.from_json(j, path~)
  Duration::from_string(raw) catch {
    err => raise @json.JsonDecodeError((path, "invalid duration: \{err}"))
  }
}

///|
pub fn encode_utc_datetime_uri(
  value : UtcDateTime,
  encoding : DateTimeEncoding,
  wire_type : NumberWireType,
) -> String raise {
  match encoding {
    Rfc3339 => value.to_string()
    Rfc7231 => format_rfc7231(value.unix_second)
    UnixTimestamp =>
      format_integer_like(value.unix_second.to_string(), wire_type)
  }
}

///|
pub fn encode_offset_datetime_uri(
  value : OffsetDateTime,
  encoding : DateTimeEncoding,
  wire_type : NumberWireType,
) -> String raise {
  match encoding {
    Rfc3339 => value.to_string()
    Rfc7231 => format_rfc7231(value.instant.unix_second)
    UnixTimestamp =>
      format_integer_like(value.instant.unix_second.to_string(), wire_type)
  }
}

///|
pub fn encode_duration_uri(
  value : Duration,
  encoding : DurationEncoding,
  wire_type : NumberWireType,
) -> String raise {
  match encoding {
    Iso8601 => value.to_string()
    Seconds => format_number_for_uri(duration_to_seconds(value), wire_type)
    Milliseconds =>
      format_number_for_uri(duration_to_seconds(value) * 1000.0, wire_type)
  }
}

///|
pub fn encode_utc_datetime_json(
  value : UtcDateTime,
  encoding : DateTimeEncoding,
  wire_type : NumberWireType,
) -> Json raise {
  match encoding {
    Rfc3339 => Json::string(value.to_string())
    Rfc7231 => Json::string(format_rfc7231(value.unix_second))
    UnixTimestamp =>
      Json::number(normalize_number_for_json(value.unix_second, wire_type))
  }
}

///|
pub fn encode_offset_datetime_json(
  value : OffsetDateTime,
  encoding : DateTimeEncoding,
  wire_type : NumberWireType,
) -> Json raise {
  match encoding {
    Rfc3339 => Json::string(value.to_string())
    Rfc7231 => Json::string(format_rfc7231(value.instant.unix_second))
    UnixTimestamp =>
      Json::number(normalize_number_for_json(value.instant.unix_second, wire_type))
  }
}

///|
pub fn encode_duration_json(
  value : Duration,
  encoding : DurationEncoding,
  wire_type : NumberWireType,
) -> Json {
  ignore(wire_type)
  match encoding {
    Iso8601 => Json::string(value.to_string())
    Seconds => Json::number(duration_to_seconds(value))
    Milliseconds => Json::number(duration_to_seconds(value) * 1000.0)
  }
}

///|
pub fn decode_utc_datetime_json(
  j : Json,
  encoding : DateTimeEncoding,
  _wire_type : NumberWireType,
  path : @json.JsonPath,
) -> UtcDateTime raise @json.JsonDecodeError {
  match encoding {
    Rfc3339 => {
      let raw : String = @json.from_json(j, path~)
      UtcDateTime::from_string(raw) catch {
        err => raise @json.JsonDecodeError((path, "invalid utcDateTime: \{err}"))
      }
    }
    Rfc7231 => {
      let raw : String = @json.from_json(j, path~)
      let unix_second = rfc7231_to_unix_seconds(raw) catch {
        err => raise @json.JsonDecodeError((path, "invalid utcDateTime: \{err}"))
      }
      UtcDateTime::{ unix_second, nanosecond: 0, frac_digits: 0 }
    }
    UnixTimestamp => {
      let raw : Double = @json.from_json(j, path~)
      UtcDateTime::{
        unix_second: raw.to_int64(),
        nanosecond: 0,
        frac_digits: 0,
      }
    }
  }
}

///|
pub fn decode_offset_datetime_json(
  j : Json,
  encoding : DateTimeEncoding,
  _wire_type : NumberWireType,
  path : @json.JsonPath,
) -> OffsetDateTime raise @json.JsonDecodeError {
  match encoding {
    Rfc3339 => {
      let raw : String = @json.from_json(j, path~)
      OffsetDateTime::from_string(raw) catch {
        err => raise @json.JsonDecodeError((path, "invalid offsetDateTime: \{err}"))
      }
    }
    Rfc7231 => {
      let raw : String = @json.from_json(j, path~)
      let unix_second = rfc7231_to_unix_seconds(raw) catch {
        err => raise @json.JsonDecodeError((path, "invalid offsetDateTime: \{err}"))
      }
      OffsetDateTime::{
        instant: UtcDateTime::{ unix_second, nanosecond: 0, frac_digits: 0 },
        offset: @time.utc_offset,
      }
    }
    UnixTimestamp => {
      let raw : Double = @json.from_json(j, path~)
      OffsetDateTime::{
        instant: UtcDateTime::{
          unix_second: raw.to_int64(),
          nanosecond: 0,
          frac_digits: 0,
        },
        offset: @time.utc_offset,
      }
    }
  }
}

///|
pub fn decode_duration_json(
  j : Json,
  encoding : DurationEncoding,
  _wire_type : NumberWireType,
  path : @json.JsonPath,
) -> Duration raise @json.JsonDecodeError {
  match encoding {
    Iso8601 => {
      let raw : String = @json.from_json(j, path~)
      Duration::from_string(raw) catch {
        err => raise @json.JsonDecodeError((path, "invalid duration: \{err}"))
      }
    }
    Seconds => {
      let n : Double = @json.from_json(j, path~)
      duration_from_seconds(n)
    }
    Milliseconds => {
      let n : Double = @json.from_json(j, path~)
      duration_from_seconds(n / 1000.0)
    }
  }
}

///|
pub fn encode_utc_datetime_array_json(
  values : Array[UtcDateTime],
  encoding : DateTimeEncoding,
  wire_type : NumberWireType,
) -> Json raise {
  let out : Array[Json] = []
  for v in values {
    out.push(encode_utc_datetime_json(v, encoding, wire_type))
  }
  Json::array(out)
}

///|
pub fn encode_offset_datetime_array_json(
  values : Array[OffsetDateTime],
  encoding : DateTimeEncoding,
  wire_type : NumberWireType,
) -> Json raise {
  let out : Array[Json] = []
  for v in values {
    out.push(encode_offset_datetime_json(v, encoding, wire_type))
  }
  Json::array(out)
}

///|
pub fn encode_duration_array_json(
  values : Array[Duration],
  encoding : DurationEncoding,
  wire_type : NumberWireType,
) -> Json {
  let out : Array[Json] = []
  for v in values {
    out.push(encode_duration_json(v, encoding, wire_type))
  }
  Json::array(out)
}

///|
pub fn decode_utc_datetime_array_json(
  j : Json,
  encoding : DateTimeEncoding,
  wire_type : NumberWireType,
  path : @json.JsonPath,
) -> Array[UtcDateTime] raise @json.JsonDecodeError {
  let raw : Array[Json] = @json.from_json(j, path~)
  let out : Array[UtcDateTime] = []
  for item in raw {
    out.push(decode_utc_datetime_json(item, encoding, wire_type, path))
  }
  out
}

///|
pub fn decode_offset_datetime_array_json(
  j : Json,
  encoding : DateTimeEncoding,
  wire_type : NumberWireType,
  path : @json.JsonPath,
) -> Array[OffsetDateTime] raise @json.JsonDecodeError {
  let raw : Array[Json] = @json.from_json(j, path~)
  let out : Array[OffsetDateTime] = []
  for item in raw {
    out.push(decode_offset_datetime_json(item, encoding, wire_type, path))
  }
  out
}

///|
pub fn decode_duration_array_json(
  j : Json,
  encoding : DurationEncoding,
  wire_type : NumberWireType,
  path : @json.JsonPath,
) -> Array[Duration] raise @json.JsonDecodeError {
  let raw : Array[Json] = @json.from_json(j, path~)
  let out : Array[Duration] = []
  for item in raw {
    out.push(decode_duration_json(item, encoding, wire_type, path))
  }
  out
}

///|
fn normalize_number_for_json(
  value : Int64,
  _wire_type : NumberWireType,
) -> Double {
  value.to_double()
}

///|
fn format_number_for_uri(
  value : Double,
  wire_type : NumberWireType,
) -> String raise {
  if is_integer_wire_type(wire_type) {
    if !is_whole_number(value) {
      fail("expected integer value for duration encoding")
    }
    return value.to_int().to_string()
  }
  if wire_type is Float || wire_type is Float32 {
    return ensure_decimal_point(value.to_string())
  }
  value.to_string()
}

///|
fn format_integer_like(value : String, wire_type : NumberWireType) -> String {
  if wire_type is Float || wire_type is Float32 {
    ensure_decimal_point(value)
  } else {
    value
  }
}

///|
fn is_integer_wire_type(wire_type : NumberWireType) -> Bool {
  match wire_type {
    Int32 | Int64 => true
    _ => false
  }
}

///|
fn is_whole_number(value : Double) -> Bool {
  value == value.floor()
}

///|
fn ensure_decimal_point(s : String) -> String {
  if s.contains_char('.') {
    s
  } else {
    s + ".0"
  }
}

///|
fn duration_to_seconds(value : Duration) -> Double {
  value.total_nanoseconds.to_double() / 1000000000.0
}

///|
fn duration_from_seconds(seconds : Double) -> Duration {
  Duration::{ total_nanoseconds: (seconds * 1000000000.0).to_int64() }
}

///|
fn parse_duration_to_nanoseconds(value : String) -> Int64 raise {
  guard value.has_prefix("P") else { fail("invalid duration: " + value) }
  let mut i = 1
  let mut in_time = false
  let mut buf = ""
  let mut sign = 1.0
  let mut days = 0.0
  let mut hours = 0.0
  let mut minutes = 0.0
  let mut seconds = 0.0
  if i < value.length() && value.code_unit_at(i).unsafe_to_char() == '-' {
    sign = -1.0
    i += 1
  }
  while i < value.length() {
    let ch = value.code_unit_at(i).unsafe_to_char()
    if (ch >= '0' && ch <= '9') || ch == '.' {
      buf = buf + ch.to_string()
      i += 1
      continue
    }
    if ch == 'T' {
      in_time = true
      i += 1
      continue
    }
    if buf == "" {
      fail("invalid duration: " + value)
    }
    let num : Double = @strconv.parse_double(buf[:])
    match ch {
      'D' => days = num
      'H' =>
        if in_time {
          hours = num
        } else {
          fail("invalid duration unit: H")
        }
      'M' =>
        if in_time {
          minutes = num
        } else {
          fail("duration months are not supported")
        }
      'S' =>
        if in_time {
          seconds = num
        } else {
          fail("invalid duration unit: S")
        }
      'Y' | 'W' => fail("duration years/weeks are not supported")
      _ => fail("invalid duration: " + value)
    }
    buf = ""
    i += 1
  }
  if buf != "" {
    fail("invalid duration: " + value)
  }
  let total_seconds = sign *
    (days * 86400.0 + hours * 3600.0 + minutes * 60.0 + seconds)
  (total_seconds * 1000000000.0).to_int64()
}

///|
fn format_duration_from_nanoseconds(total_nanos : Int64) -> String {
  if total_nanos == 0L {
    return "PT0S"
  }
  let negative = total_nanos < 0L
  let abs_nanos = if negative { -total_nanos } else { total_nanos }
  let nanos_per_second = 1000000000L
  let nanos_per_minute = nanos_per_second * 60L
  let nanos_per_hour = nanos_per_minute * 60L
  let nanos_per_day = nanos_per_hour * 24L
  let days = abs_nanos / nanos_per_day
  let mut rem = abs_nanos % nanos_per_day
  let hours = rem / nanos_per_hour
  rem = rem % nanos_per_hour
  let minutes = rem / nanos_per_minute
  rem = rem % nanos_per_minute
  let seconds = rem / nanos_per_second
  let nanos = (rem % nanos_per_second).to_int()
  let sb = StringBuilder::new()
  if negative {
    sb.write_char('-')
  }
  sb.write_char('P')
  if days > 0L {
    sb.write_string(days.to_string())
    sb.write_char('D')
  }
  if hours > 0L || minutes > 0L || seconds > 0L || nanos > 0 || days == 0L {
    sb.write_char('T')
    if hours > 0L {
      sb.write_string(hours.to_string())
      sb.write_char('H')
    }
    if minutes > 0L {
      sb.write_string(minutes.to_string())
      sb.write_char('M')
    }
    if seconds > 0L || nanos > 0 || (hours == 0L && minutes == 0L) {
      sb.write_string(seconds.to_string())
      if nanos > 0 {
        sb.write_char('.')
        sb.write_string(trim_trailing_zeros(nanos_to_9(nanos)))
      }
      sb.write_char('S')
    }
  }
  sb.to_string()
}

///|
fn format_rfc3339_from_instant(
  unix_second : Int64,
  nanosecond : Int,
  frac_digits : Int,
) -> String {
  let dt = @time.unix(unix_second, zone=@time.utc_zone) catch {
    _ => return "1970-01-01T00:00:00Z"
  }
  let mut out = "\{pad4(dt.year())}-\{pad2(dt.month())}-\{pad2(dt.day())}T\{pad2(dt.hour())}:\{pad2(dt.minute())}:\{pad2(dt.second())}"
  if frac_digits > 0 {
    out = out + "." + fixed_frac_digits(nanosecond, frac_digits)
  }
  out + "Z"
}

///|
fn fixed_frac_digits(nanosecond : Int, digits : Int) -> String {
  let normalized_digits = if digits > 9 {
    9
  } else if digits < 1 {
    1
  } else {
    digits
  }
  String::unsafe_substring(
    nanos_to_9(nanosecond),
    start=0,
    end=normalized_digits,
  )
}

///|
fn nanos_to_9(nanosecond : Int) -> String {
  let padded = nanosecond.to_string().pad_start(9, '0')
  if padded.length() > 9 {
    String::unsafe_substring(
      padded,
      start=padded.length() - 9,
      end=padded.length(),
    )
  } else {
    padded
  }
}

///|
fn trim_trailing_zeros(value : String) -> String {
  let trimmed = value.trim_end(chars="0")
  if trimmed.length() == 0 {
    "0"
  } else {
    trimmed.to_string()
  }
}

///|
fn parse_rfc3339(
  value : String,
) -> (Int, Int, Int, Int, Int, Int, Int, Int, Int) raise {
  let t_idx = match value.find("T") {
    Some(idx) => idx
    None => -1
  }
  if t_idx < 0 {
    fail("invalid rfc3339 datetime")
  }
  let zone_start = match value.rev_find("Z") {
    Some(idx) if idx > t_idx => idx
    _ =>
      match value.rev_find("+") {
        Some(idx) if idx > t_idx => idx
        _ =>
          match value.rev_find("-") {
            Some(idx) if idx > t_idx => idx
            _ => -1
          }
      }
  }
  if zone_start <= t_idx {
    fail("invalid rfc3339 datetime")
  }
  let date_part = String::unsafe_substring(value, start=0, end=t_idx)
  let time_part = String::unsafe_substring(value, start=t_idx + 1, end=zone_start)
  let zone_part = String::unsafe_substring(
    value,
    start=zone_start,
    end=value.length(),
  )
  let date = date_part.split("-").to_array()
  if date.length() != 3 {
    fail("invalid rfc3339 datetime")
  }
  let year : Int = @strconv.parse_int(date[0].to_string())
  let month : Int = @strconv.parse_int(date[1].to_string())
  let day : Int = @strconv.parse_int(date[2].to_string())
  let (hour, minute, second, nano, frac_digits) = parse_clock(time_part)
  let offset = parse_zone_offset(zone_part)
  ignore(
    @time.PlainDateTime::of(
      year,
      month,
      day,
      hour~,
      minute~,
      second~,
      nanosecond=nano,
    ),
  )
  (year, month, day, hour, minute, second, nano, frac_digits, offset)
}

///|
fn parse_clock(value : String) -> (Int, Int, Int, Int, Int) raise {
  let main = value.split(".").to_array()
  let hms = main[0].to_string().split(":").to_array()
  if hms.length() != 3 {
    fail("invalid time")
  }
  let hour : Int = @strconv.parse_int(hms[0].to_string())
  let minute : Int = @strconv.parse_int(hms[1].to_string())
  let second : Int = @strconv.parse_int(hms[2].to_string())
  let mut nano = 0
  let mut frac_digits = 0
  if main.length() == 2 {
    let frac_raw = main[1].to_string()
    frac_digits = if frac_raw.length() > 9 { 9 } else { frac_raw.length() }
    nano = @strconv.parse_int(
      String::unsafe_substring(frac_raw.pad_end(9, '0'), start=0, end=9),
    )
  } else if main.length() > 2 {
    fail("invalid time fraction")
  }
  (hour, minute, second, nano, frac_digits)
}

///|
fn parse_zone_offset(zone : String) -> Int raise {
  if zone == "Z" {
    return 0
  }
  match zone.strip_prefix("+") {
    Some(rest) => {
      let xs = rest.to_string().split(":").to_array()
      if xs.length() != 2 {
        fail("invalid zone offset")
      }
      let hour : Int = @strconv.parse_int(xs[0].to_string())
      let minute : Int = @strconv.parse_int(xs[1].to_string())
      hour * 3600 + minute * 60
    }
    None =>
      match zone.strip_prefix("-") {
        Some(rest) => {
          let xs = rest.to_string().split(":").to_array()
          if xs.length() != 2 {
            fail("invalid zone offset")
          }
          let hour : Int = @strconv.parse_int(xs[0].to_string())
          let minute : Int = @strconv.parse_int(xs[1].to_string())
          -(hour * 3600 + minute * 60)
        }
        None => fail("invalid zone offset")
      }
  }
}

///|
fn format_rfc7231(unix_second : Int64) -> String raise {
  let dt = @time.unix(unix_second, zone=@time.utc_zone)
  let weekday = match dt.weekday() {
    Monday => "Mon"
    Tuesday => "Tue"
    Wednesday => "Wed"
    Thursday => "Thu"
    Friday => "Fri"
    Saturday => "Sat"
    Sunday => "Sun"
  }
  let month = match dt.month() {
    1 => "Jan"
    2 => "Feb"
    3 => "Mar"
    4 => "Apr"
    5 => "May"
    6 => "Jun"
    7 => "Jul"
    8 => "Aug"
    9 => "Sep"
    10 => "Oct"
    11 => "Nov"
    12 => "Dec"
    _ => fail("invalid month")
  }
  "\{weekday}, \{pad2(dt.day())} \{month} \{dt.year().to_string()} \{pad2(dt.hour())}:\{pad2(dt.minute())}:\{pad2(dt.second())} GMT"
}

///|
fn rfc7231_to_unix_seconds(value : String) -> Int64 raise {
  let parts = value.split(", ").to_array()
  if parts.length() != 2 {
    fail("invalid rfc7231 datetime")
  }
  let xs = parts[1].to_string().split(" ").to_array()
  if xs.length() != 5 || xs[4].to_string() != "GMT" {
    fail("invalid rfc7231 datetime")
  }
  let day : Int = @strconv.parse_int(xs[0].to_string())
  let month = match xs[1].to_string() {
    "Jan" => 1
    "Feb" => 2
    "Mar" => 3
    "Apr" => 4
    "May" => 5
    "Jun" => 6
    "Jul" => 7
    "Aug" => 8
    "Sep" => 9
    "Oct" => 10
    "Nov" => 11
    "Dec" => 12
    _ => fail("invalid rfc7231 month")
  }
  let year : Int = @strconv.parse_int(xs[2].to_string())
  let (hour, minute, second, _nano, _frac_digits) = parse_clock(
    xs[3].to_string(),
  )
  let pdt = @time.PlainDateTime::of(year, month, day, hour~, minute~, second~)
  pdt.to_unix_second()
}

///|
fn pad2(v : Int) -> String {
  v.to_string().pad_start(2, '0')
}

///|
fn pad4(v : Int) -> String {
  v.to_string().pad_start(4, '0')
}
