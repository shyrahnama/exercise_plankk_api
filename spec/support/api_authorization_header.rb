# https://jwt.io/
#
# Secret: 2822eb7960fd8adf08ab1642e2afb24442150c7e773e843802040bb483a54e0163f3c689b1927301ed21f6bf0829793e26322e1154766fc31f96e95c45793424
# Payload: {
#   "sub": "1234567890",
#   "name": "plankk_api_client",
#   "iat": 1561315622
# }


module ApiAuthorizationHeader
  # rubocop:disable Metrics/LineLength
  def add_authorization_header
    access_token = spec_token
    request.env["HTTP_AUTHORIZATION"] = access_token
  end

  def spec_token
  	"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6InBsYW5ra19hcGlfY2xpZW50IiwiaWF0IjoxNTYxMzE1NjIyfQ.J0n3qCwyDk_KlfiouhB8_k1HKDPbhqeYGT0mNv4_5Vo"
  end
  # rubocop:enable Metrics/LineLength
end