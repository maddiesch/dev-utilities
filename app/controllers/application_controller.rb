class ApplicationController < Jets::Controller::Base
  def not_found
    json = {
      errors: [
        {
          status: '404',
          code: 'not_found',
          title: 'Not Found',
          detail: 'The resource you requested could not be found',
          meta: {
            request: {
              method: request.request_method,
              path: request.path
            }
          }
        }
      ]
    }
    render(json: json, status: :not_found)
  end
end
