shared_examples_for :deny_access do |method_type, path, params = {}|
  it 'returns 401 (unauthorized) request' do
    case method_type
    when :get
      get path,
          params: params,
          headers: header_without_authentication
    when :post
      post path,
           params: params,
           headers: header_without_authentication
    when :put
      put path,
          params: params,
          headers: header_without_authentication
    when :delete
      delete path,
             params: params,
             headers: header_without_authentication
    end

    expect(response).to have_http_status(401)
  end
end
