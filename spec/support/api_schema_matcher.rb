RSpec::Matchers.define :match_json_schema do |schema|
  match do |json|
    schema_directory = "#{Dir.pwd}/spec/support/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"
    JSON::Validator.validate!(schema_path, json)
  end
end
