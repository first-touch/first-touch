FT.DataModels ||= {}

class FT.DataModels.Post extends FT.DataModels.Base
  API_ENDPOINT: 'api/v1/posts'
  MODEL_NAME: 'post'

  _buildJSON: ->
    post:
      content: @content
      user_id: @user_id
