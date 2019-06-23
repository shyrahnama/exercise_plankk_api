module ApiAuthorizationHeader
  # rubocop:disable Metrics/LineLength
  # rubocop:enable Metrics/LineLength
  def add_authorization_header
    access_token = "eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJjdXN0b206Y2"

    request.env["HTTP_AUTHORIZATION"] = access_token
  end
end