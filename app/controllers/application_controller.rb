class ApplicationController < Jets::Controller::Base
  before_action :setup_cors_response_headers

  private

  def setup_cors_response_headers
    Cors::Header.generate(request.env).each do |header, value|
      response.headers[header] = value
    end
  end
end
