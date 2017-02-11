class FT.DataModels.Inbox extends FT.DataModels.Base
  API_ENDPOINT: "api/v1/messages"
  MODEL_NAME: "inbox"
  ATTR_ACCESSIBLE: [
    "recipient_name"
    "recipient_id"
    "read"
    "messages"
    "truncated_message"
  ]

  _buildDataModel: (attr) ->
    @recipient_name = attr.recipient_name
    @recipient_id = attr.recipient_id
    @read = _.any attr, (message) ->
      !message.read

    @messages = attr.messages
    @truncated_message = _.last(attr.messages).substring(0, 10) + "..."
