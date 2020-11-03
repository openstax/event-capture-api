module ResponseHelpers
  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end

  def expect_valid_bound_response(bindings_class, status=:ok)
    expect(response).to have_http_status(status)

    begin
      bound_response = bindings_class.new(json_response)
      expect(bound_response).to be_valid,
                                "bounded response was invalid: #{bound_response.list_invalid_properties}"
    rescue ArgumentError => ex
      fail "binding error: #{ex.message}"
    end

    yield bound_response
  end
end
