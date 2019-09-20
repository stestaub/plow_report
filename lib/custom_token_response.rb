module CustomTokenResponse
  def body
    additional_data = {
        'userid' => @token.resource_owner_id.to_s,
        'created_at' => @token.created_at.to_i.to_s
    }
    # call original `#body` method and merge its result with the additional data hash
    super.merge(additional_data)
  end
end