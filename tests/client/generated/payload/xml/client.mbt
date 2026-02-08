///|

///|
/// SimpleModelValueClient HTTP 客户端。
pub(all) struct SimpleModelValueClient {
  base_url : String
}

///|

///|
/// 创建 SimpleModelValueClient。
pub fn SimpleModelValueClient::new(base_url : String) -> SimpleModelValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/simpleModel（自动解析响应）。
pub async fn SimpleModelValueClient::get_payload_xml_simplemodel(
  self : SimpleModelValueClient,
) -> SimpleModel {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/payload/xml/simpleModel")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : SimpleModel = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/simpleModel（自动解析响应）。
pub async fn SimpleModelValueClient::put_payload_xml_simplemodel(
  self : SimpleModelValueClient,
  body : SimpleModel,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/payload/xml/simpleModel")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ModelWithSimpleArraysValueClient HTTP 客户端。
pub(all) struct ModelWithSimpleArraysValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelWithSimpleArraysValueClient。
pub fn ModelWithSimpleArraysValueClient::new(
  base_url : String,
) -> ModelWithSimpleArraysValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/modelWithSimpleArrays（自动解析响应）。
pub async fn ModelWithSimpleArraysValueClient::get_payload_xml_modelwithsimplearrays(
  self : ModelWithSimpleArraysValueClient,
) -> ModelWithSimpleArrays {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithSimpleArrays",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelWithSimpleArrays = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/modelWithSimpleArrays（自动解析响应）。
pub async fn ModelWithSimpleArraysValueClient::put_payload_xml_modelwithsimplearrays(
  self : ModelWithSimpleArraysValueClient,
  body : ModelWithSimpleArrays,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithSimpleArrays",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ModelWithArrayOfModelValueClient HTTP 客户端。
pub(all) struct ModelWithArrayOfModelValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelWithArrayOfModelValueClient。
pub fn ModelWithArrayOfModelValueClient::new(
  base_url : String,
) -> ModelWithArrayOfModelValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/modelWithArrayOfModel（自动解析响应）。
pub async fn ModelWithArrayOfModelValueClient::get_payload_xml_modelwitharrayofmodel(
  self : ModelWithArrayOfModelValueClient,
) -> ModelWithArrayOfModel {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithArrayOfModel",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelWithArrayOfModel = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/modelWithArrayOfModel（自动解析响应）。
pub async fn ModelWithArrayOfModelValueClient::put_payload_xml_modelwitharrayofmodel(
  self : ModelWithArrayOfModelValueClient,
  body : ModelWithArrayOfModel,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithArrayOfModel",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ModelWithOptionalFieldValueClient HTTP 客户端。
pub(all) struct ModelWithOptionalFieldValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelWithOptionalFieldValueClient。
pub fn ModelWithOptionalFieldValueClient::new(
  base_url : String,
) -> ModelWithOptionalFieldValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/modelWithOptionalField（自动解析响应）。
pub async fn ModelWithOptionalFieldValueClient::get_payload_xml_modelwithoptionalfield(
  self : ModelWithOptionalFieldValueClient,
) -> ModelWithOptionalField {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithOptionalField",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelWithOptionalField = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/modelWithOptionalField（自动解析响应）。
pub async fn ModelWithOptionalFieldValueClient::put_payload_xml_modelwithoptionalfield(
  self : ModelWithOptionalFieldValueClient,
  body : ModelWithOptionalField,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithOptionalField",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ModelWithAttributesValueClient HTTP 客户端。
pub(all) struct ModelWithAttributesValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelWithAttributesValueClient。
pub fn ModelWithAttributesValueClient::new(
  base_url : String,
) -> ModelWithAttributesValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/modelWithAttributes（自动解析响应）。
pub async fn ModelWithAttributesValueClient::get_payload_xml_modelwithattributes(
  self : ModelWithAttributesValueClient,
) -> ModelWithAttributes {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithAttributes",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelWithAttributes = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/modelWithAttributes（自动解析响应）。
pub async fn ModelWithAttributesValueClient::put_payload_xml_modelwithattributes(
  self : ModelWithAttributesValueClient,
  body : ModelWithAttributes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithAttributes",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ModelWithUnwrappedArrayValueClient HTTP 客户端。
pub(all) struct ModelWithUnwrappedArrayValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelWithUnwrappedArrayValueClient。
pub fn ModelWithUnwrappedArrayValueClient::new(
  base_url : String,
) -> ModelWithUnwrappedArrayValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/modelWithUnwrappedArray（自动解析响应）。
pub async fn ModelWithUnwrappedArrayValueClient::get_payload_xml_modelwithunwrappedarray(
  self : ModelWithUnwrappedArrayValueClient,
) -> ModelWithUnwrappedArray {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithUnwrappedArray",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelWithUnwrappedArray = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/modelWithUnwrappedArray（自动解析响应）。
pub async fn ModelWithUnwrappedArrayValueClient::put_payload_xml_modelwithunwrappedarray(
  self : ModelWithUnwrappedArrayValueClient,
  body : ModelWithUnwrappedArray,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithUnwrappedArray",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ModelWithRenamedArraysValueClient HTTP 客户端。
pub(all) struct ModelWithRenamedArraysValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelWithRenamedArraysValueClient。
pub fn ModelWithRenamedArraysValueClient::new(
  base_url : String,
) -> ModelWithRenamedArraysValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/modelWithRenamedArrays（自动解析响应）。
pub async fn ModelWithRenamedArraysValueClient::get_payload_xml_modelwithrenamedarrays(
  self : ModelWithRenamedArraysValueClient,
) -> ModelWithRenamedArrays {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithRenamedArrays",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelWithRenamedArrays = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/modelWithRenamedArrays（自动解析响应）。
pub async fn ModelWithRenamedArraysValueClient::put_payload_xml_modelwithrenamedarrays(
  self : ModelWithRenamedArraysValueClient,
  body : ModelWithRenamedArrays,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithRenamedArrays",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ModelWithRenamedFieldsValueClient HTTP 客户端。
pub(all) struct ModelWithRenamedFieldsValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelWithRenamedFieldsValueClient。
pub fn ModelWithRenamedFieldsValueClient::new(
  base_url : String,
) -> ModelWithRenamedFieldsValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/modelWithRenamedFields（自动解析响应）。
pub async fn ModelWithRenamedFieldsValueClient::get_payload_xml_modelwithrenamedfields(
  self : ModelWithRenamedFieldsValueClient,
) -> ModelWithRenamedFields {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithRenamedFields",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelWithRenamedFields = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/modelWithRenamedFields（自动解析响应）。
pub async fn ModelWithRenamedFieldsValueClient::put_payload_xml_modelwithrenamedfields(
  self : ModelWithRenamedFieldsValueClient,
  body : ModelWithRenamedFields,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithRenamedFields",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ModelWithEmptyArrayValueClient HTTP 客户端。
pub(all) struct ModelWithEmptyArrayValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelWithEmptyArrayValueClient。
pub fn ModelWithEmptyArrayValueClient::new(
  base_url : String,
) -> ModelWithEmptyArrayValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/modelWithEmptyArray（自动解析响应）。
pub async fn ModelWithEmptyArrayValueClient::get_payload_xml_modelwithemptyarray(
  self : ModelWithEmptyArrayValueClient,
) -> ModelWithEmptyArray {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithEmptyArray",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelWithEmptyArray = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/modelWithEmptyArray（自动解析响应）。
pub async fn ModelWithEmptyArrayValueClient::put_payload_xml_modelwithemptyarray(
  self : ModelWithEmptyArrayValueClient,
  body : ModelWithEmptyArray,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithEmptyArray",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ModelWithTextValueClient HTTP 客户端。
pub(all) struct ModelWithTextValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelWithTextValueClient。
pub fn ModelWithTextValueClient::new(
  base_url : String,
) -> ModelWithTextValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/modelWithText（自动解析响应）。
pub async fn ModelWithTextValueClient::get_payload_xml_modelwithtext(
  self : ModelWithTextValueClient,
) -> ModelWithText {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/payload/xml/modelWithText")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelWithText = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/modelWithText（自动解析响应）。
pub async fn ModelWithTextValueClient::put_payload_xml_modelwithtext(
  self : ModelWithTextValueClient,
  body : ModelWithText,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/payload/xml/modelWithText")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ModelWithDictionaryValueClient HTTP 客户端。
pub(all) struct ModelWithDictionaryValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelWithDictionaryValueClient。
pub fn ModelWithDictionaryValueClient::new(
  base_url : String,
) -> ModelWithDictionaryValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/modelWithDictionary（自动解析响应）。
pub async fn ModelWithDictionaryValueClient::get_payload_xml_modelwithdictionary(
  self : ModelWithDictionaryValueClient,
) -> ModelWithDictionary {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithDictionary",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelWithDictionary = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/modelWithDictionary（自动解析响应）。
pub async fn ModelWithDictionaryValueClient::put_payload_xml_modelwithdictionary(
  self : ModelWithDictionaryValueClient,
  body : ModelWithDictionary,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithDictionary",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ModelWithEncodedNamesValueClient HTTP 客户端。
pub(all) struct ModelWithEncodedNamesValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelWithEncodedNamesValueClient。
pub fn ModelWithEncodedNamesValueClient::new(
  base_url : String,
) -> ModelWithEncodedNamesValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/xml/modelWithEncodedNames（自动解析响应）。
pub async fn ModelWithEncodedNamesValueClient::get_payload_xml_modelwithencodednames(
  self : ModelWithEncodedNamesValueClient,
) -> ModelWithEncodedNames {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithEncodedNames",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelWithEncodedNames = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /payload/xml/modelWithEncodedNames（自动解析响应）。
pub async fn ModelWithEncodedNamesValueClient::put_payload_xml_modelwithencodednames(
  self : ModelWithEncodedNamesValueClient,
  body : ModelWithEncodedNames,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/xml/modelWithEncodedNames",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/xml")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
