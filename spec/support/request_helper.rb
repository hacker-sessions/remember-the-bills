module Requests
  module JsonHelpers
    def expect_status(expectation)
      expect(response.status).to eq(expectation)
    end

    def json
      JSON.parse(response.body)
    end
  end

  module HeaderHelpers
    def header_with_authentication(user)
      user.create_new_auth_token.merge({'HTTP_ACCPET': 'application/json'})
    end

    def header_without_authentication
      {'content-type': 'application/json'}
    end
  end
end