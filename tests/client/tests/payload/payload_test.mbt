///|

///|
/// 对齐上游：test/e2e/http/payload/content-negotiation/main.test.ts
#cfg(target="native")
#skip("对齐 http-client-js：content-negotiation 场景在上游全部为 skip（二进制返回断言）")
async test "runtime payload/content-negotiation" {
  let same = @payload_content_negotiation.SameBodyClient::new(
    "http://localhost:3000",
  )
  ignore(same.get_content_negotiation_same_body("image/png"))
  ignore(same.get_content_negotiation_same_body_2("image/jpeg"))
  let different = @payload_content_negotiation.DifferentBodyClient::new(
    "http://localhost:3000",
  )
  ignore(different.get_content_negotiation_different_body("image/png"))
  ignore(different.get_content_negotiation_different_body_2("application/json"))
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
  let patch_result : Result[@payload_json_merge_patch.Resource, Error] = try? client.patch_json_merge_patch_update_resource(
    "application/merge-patch+json",
    {
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
  client.post_payload_media_type_string_body_sendasjson(
    "application/json", "foo",
  )
  let as_json : Result[String, Error] = try? client.get_payload_media_type_string_body_getasjson()
  match as_json {
    Ok(_) => fail("expected getAsJson currently fails with 400")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("expected 400 error, got: " + err.to_string())
      }
  }
}
