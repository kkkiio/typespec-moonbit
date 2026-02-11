///|
pub(all) struct NameState {
  key_to_name : Map[String, String]
  name_to_key : Map[String, String]
  next_suffix : Map[String, Int]
}

///|
pub(all) struct NameRequest {
  stable_key : String
  preferred_name : String
}

///|
pub fn NameRequest::new(
  stable_key : String,
  preferred_name : String,
) -> NameRequest {
  { stable_key, preferred_name }
}

///|
pub fn new_name_state() -> NameState {
  { key_to_name: Map::new(), name_to_key: Map::new(), next_suffix: Map::new() }
}

///|
pub fn NameState::lookup(self : NameState, stable_key : String) -> String? {
  self.key_to_name.get(stable_key)
}

///|
pub fn NameState::alloc(
  self : NameState,
  stable_key : String,
  preferred_name : String,
) -> String {
  match self.key_to_name.get(stable_key) {
    Some(existing) => existing
    None => {
      let base = normalize_base_name(preferred_name)
      let resolved = alloc_unique_name(self, stable_key, base)
      self.key_to_name.set(stable_key, resolved)
      resolved
    }
  }
}

///|
pub fn NameState::alloc_batch(
  self : NameState,
  requests : Array[NameRequest],
) -> Map[String, String] raise {
  if requests.length() == 0 {
    return Map::new()
  }

  let sorted = Array::new(capacity=requests.length())
  for req in requests {
    sorted.push(req)
  }
  sorted.sort_by_key(fn(req) { "\{req.stable_key}#\{req.preferred_name}" })

  let preferred_by_key : Map[String, String] = Map::new()
  for req in sorted {
    match preferred_by_key.get(req.stable_key) {
      Some(existing) =>
        if existing != req.preferred_name {
          fail(
            "inconsistent preferred name for stable key '\{req.stable_key}': '\{existing}' vs '\{req.preferred_name}'",
          )
        }
      None => preferred_by_key.set(req.stable_key, req.preferred_name)
    }
  }

  let keys = Array::new(capacity=requests.length())
  for item in preferred_by_key.to_array() {
    keys.push(item.0)
  }
  keys.sort()

  let out : Map[String, String] = Map::new()
  for key in keys {
    let preferred = preferred_by_key.get(key).unwrap_or("Model")
    let name = self.alloc(key, preferred)
    out.set(key, name)
  }
  out
}

///|
fn normalize_base_name(name : String) -> String {
  let trimmed = name.trim()
  if trimmed.length() == 0 {
    "Model"
  } else {
    sanitize_identifier(trimmed.to_string())
  }
}

///|
fn alloc_unique_name(
  state : NameState,
  stable_key : String,
  base : String,
) -> String {
  match state.name_to_key.get(base) {
    None => {
      state.name_to_key.set(base, stable_key)
      if !state.next_suffix.contains(base) {
        state.next_suffix.set(base, 1)
      }
      base
    }
    Some(owner) =>
      if owner == stable_key {
        base
      } else {
        let mut idx = state.next_suffix.get(base).unwrap_or(1)
        let mut candidate = "\{base}\{idx.to_string()}"
        while state.name_to_key.contains(candidate) {
          idx += 1
          candidate = "\{base}\{idx.to_string()}"
        }
        state.next_suffix.set(base, idx + 1)
        state.name_to_key.set(candidate, stable_key)
        candidate
      }
  }
}
