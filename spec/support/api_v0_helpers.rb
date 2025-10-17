module ApiV0Helpers

  def self.included(base)
    base.extend(ClassMethods)
  end

  def self.more_rspec_config(config)
    config.before(:example, api: :v0) do
      clear_headers
    end
  end

  def controller_spec?
    self.class.metadata[:type] == :controller
  end

  def request_spec?
    self.class.metadata[:type] == :request
  end

  def headers
    @headers ||= {}
  end

  def clear_headers
    @headers = nil
  end

  def api_post(*args, **kwargs, &block)
    post(*prep_request_args(args, kwargs), **kwargs, &block)
  end

  def api_get(*args, **kwargs, &block)
    get(*prep_request_args(args, kwargs), **kwargs, &block)
  end

  def api_put(*args, **kwargs, &block)
    put(*prep_request_args(args, kwargs), **kwargs, &block)
  end

  def api_delete(*args, **kwargs, &block)
    delete(*prep_request_args(args, kwargs), **kwargs, &block)
  end

  def add_path_prefix(args)
    args.dup.tap {|copy| copy[0] = "/api/v0/#{copy[0]}"}
  end

  def prep_request_args(args, kwargs)
    kwargs[:headers] ||= {}
    kwargs[:headers]['CONTENT_TYPE'] = 'application/json'

    args.dup.tap do |copy|
      copy[0] = "/api/v0/#{copy[0]}"
    end
  end

  def simple_api_request(verb, path)
    case verb
    when :get
      api_get(path)
    when :post
      api_post(path)
    when :put
      api_put(path)
    when :delete
      api_delete(path)
    else
      raise "Unknown verb #{verb}"
    end
  end

  module ClassMethods
    def test_request_status(spec, verb, path, status)
      spec.it "returns #{status} for #{verb} on path /api/v0/#{path}" do
        simple_api_request(verb, path)
        expect(response).to have_http_status(status)
      end
    end

    def test_crud_request_status(spec, route_prefix, status, actions)
      test_request_status(spec, :post, "#{route_prefix}", status) if create?(actions)
      test_request_status(spec, :get, "#{route_prefix}/42", status) if show?(actions)
      test_request_status(spec, :get, "#{route_prefix}", status) if index?(actions)
      test_request_status(spec, :put, "#{route_prefix}/42", status) if update?(actions)
      test_request_status(spec, :delete, "#{route_prefix}/42", status) if destroy?(actions)
    end
  end

end
