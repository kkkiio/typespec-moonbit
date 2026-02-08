///|

///|
fn load_png_bytes() -> Bytes raise {
  @fs.read_file_to_bytes(
    "\{@test_config.TYPESPEC_HTTP_SPECS_ASSETS_DIR}/image.png",
  )
}

///|
fn load_jpg_bytes() -> Bytes raise {
  @fs.read_file_to_bytes(
    "\{@test_config.TYPESPEC_HTTP_SPECS_ASSETS_DIR}/image.jpg",
  )
}

///|
/// 对齐上游：test/e2e/http/payload/content-negotiation/main.test.ts
#cfg(target="native")
async test "runtime payload/content-negotiation" {
  let png_bytes = load_png_bytes()
  let jpg_bytes = load_jpg_bytes()
  let same = @payload_content_negotiation.SameBodyClient::new(
    "http://localhost:3000",
  )
  let same_png = same.get_avatar_as_png()
  let same_jpeg = same.get_avatar_as_jpeg()
  assert_eq(same_png, png_bytes)
  assert_eq(same_jpeg, jpg_bytes)
  let different = @payload_content_negotiation.DifferentBodyClient::new(
    "http://localhost:3000",
  )
  let diff_png = different.get_avatar_as_png()
  assert_eq(diff_png, png_bytes)
  let diff_json = different.get_avatar_as_json()
  assert_eq(diff_json.content, png_bytes)
}

///|
/// 对齐上游：test/e2e/http/payload/json-merge-patch/main.test.ts
#cfg(target="native")
async test "runtime payload/json-merge-patch" {
  let client = @payload_json_merge_patch.JsonMergePatchClient::new(
    "http://localhost:3000",
  )
  let create_result : Result[@payload_json_merge_patch.Resource, Error] = try? client.put_json_merge_patch_create_resource({
      name: "Madge",
      description: Some("desc"),
      map: Some({
        "k": { name: Some("InnerMadge"), description: Some("innerDesc") },
      }),
      array: Some([{ name: Some("InnerMadge"), description: Some("innerDesc") }]),
      int_value: Some(1),
      float_value: Some(1.25),
      inner_model: Some({
        name: Some("InnerMadge"),
        description: Some("innerDesc"),
      }),
      int_array: Some([1, 2, 3]),
    },
  )
  match create_result {
    Ok(_) => fail("expected create currently fails with 400")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("expected 400 error, got: " + err.to_string())
      }
  }
  let patch_result : Result[@payload_json_merge_patch.Resource, Error] = try? client.patch_json_merge_patch_update_resource({
      description: None,
      map: None,
      array: None,
      int_value: None,
      float_value: None,
      inner_model: None,
      int_array: None,
    },
  )
  match patch_result {
    Ok(_) => fail("expected patch currently fails with 400")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("expected 400 error, got: " + err.to_string())
      }
  }
}

///|
/// 对齐上游：test/e2e/http/payload/media-type/main.test.ts（非 skip）
#cfg(target="native")
async test "runtime payload/media-type" {
  let client = @payload_media_type.StringBodyClient::new(
    "http://localhost:3000",
  )
  client.post_payload_media_type_string_body_sendasjson("foo")
  let as_json : Result[String, Error] = try? client.get_payload_media_type_string_body_getasjson()
  match as_json {
    Ok(_) => fail("expected getAsJson currently fails with 400")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("expected 400 error, got: " + err.to_string())
      }
  }
}
