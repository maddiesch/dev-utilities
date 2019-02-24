class SharedController < ApplicationController
  def not_found
    if request.request_method == 'OPTIONS'
      render(json: {})
    else
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
end
