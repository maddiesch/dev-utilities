require 'addressable'

module Cors
  class Header
    CORS_ALLOWED_HEADERS = %w[
      Accept
      Authorization
      Content-Type
      If-Match
      If-Modified-Since
      If-None-Match
      If-Unmodified-Since
      Origin
      X-Requested-With
      X-CSRF-Token
    ].freeze

    CORS_ALLOWED_METHODS = %w[
      GET POST PATCH PUT DELETE OPTIONS
    ].freeze

    CORS_EXPOSE_HEADERS = %w[
      ETag Link
    ].freeze

    CORS_VARY = %w[
      Accept Accept-Encoding Origin
    ].freeze

    class << self
      def generate(env)
        new(env).generate
      end
    end

    attr_reader :request

    def initialize(env)
      @request = Rack::Request.new(env)
    end

    def generate
      {}.tap do |headers|
        headers['Access-Control-Allow-Credentials'] = 'true'
        headers['Access-Control-Allow-Origin']      = allowed_origin if allowed_origin
        headers['Access-Control-Expose-Headers']    = CORS_EXPOSE_HEADERS.join(', ')
        headers['Access-Control-Allow-Headers']     = CORS_ALLOWED_HEADERS.join(', ')
        headers['Vary']                             = CORS_VARY.join(', ')
      end
    end

    private

    def session_authentication?
      @session_authentication == true
    end

    def origin_header
      (request.env['HTTP_ORIGIN'].presence || request.env['Origin'].presence).to_s
    end

    def allowed_origin
      '*'
    end

    def acceptable_options_request?
      options_request? && request_from_known_origin?
    end

    def request_from_known_origin?
      domain = Addressable::URI.parse(origin_header).domain
      CORS_KNOWN_ORIGINS.include?(domain)
    rescue Addressable::URI::InvalidURIError
      false
    end

    def options_request?
      request.request_method == 'OPTIONS'
    end
  end
end
