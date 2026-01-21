///|
pub let model_template : String =
  #|{{#models}}
  #|///|
  #|/// Model {{name}}
  #|pub(all) struct {{struct_name}} {
  #|{{#fields}}
  #|  {{name}} : {{type}}
  #|{{/fields}}
  #|} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))
  #|
  #|{{/models}}

///|
pub let handler_trait_template : String =
  #|{{#clients}}
  #|///|
  #|/// Traits for operation handlers
  #|pub(open) trait {{trait_name}} {
  #|  {{#methods}}async {{method_name}}(Self{{#params}}, {{name}} : {{type}}{{/params}}) -> Unit
  #|  {{/methods}}
  #|}
  #|{{/clients}}
