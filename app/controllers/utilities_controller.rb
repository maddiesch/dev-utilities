class UtilitiesController < ApplicationController
  def index
    routes = Jets.application.routes.routes.map { |r| [r.path, r.method] }.select { |r| r[0].starts_with?('v1/') }

    data = [].tap do |results|
      routes.each do |(path, http_method)|
        results << {
          type: 'route',
          id: Digest::MD5.hexdigest("#{http_method}:#{path}"),
          attributes: {
            http_method: http_method,
            path: path
          },
          links: {
            self: "#{request.scheme}://#{request.host}/#{path}"
          }
        }
      end
    end

    render(json: { data: data })
  end

  def ip
    json = {
      data: {
        type: 'ip',
        attributes: {
          value: request.ip
        }
      }
    }
    render(json: json)
  end

  def whoami
    json = {
      data: {
        type: 'whoami',
        attributes: {
          user_agent: request.user_agent,
          remote_ip: request.ip
        }
      }
    }
    render(json: json)
  end

  def time
    time = Time.now.utc
    json = {
      data: {
        type: 'time',
        attributes: {
          iso8601: time.strftime('%Y-%m-%dT%H:%M:%SZ'),
          epoch: time.to_i
        }
      }
    }
    render(json: json)
  end

  def echo
    json = {
      data: [
        {
          type: 'request',
          attributes: {
            method: request.request_method,
            url: request.url
          }
        },
        {
          type: 'headers',
          attributes: request.headers
        },
        {
          type: 'body',
          attributes: {
            content: request.body.read.presence
          }
        }
      ]
    }
    render(json: json)
  end

  def status
    codes = JSON.parse(File.read(Jets.root.join('config', 'status_codes.json')))
    status_code = params[:status].to_i
    status_name = codes[status_code.to_s]

    if status_name.present?
      json = {
        data: {
          type: 'status',
          attributes: {
            description: "[#{status_code}] #{status_name}",
            http_status: status_code,
            status_name: status_name
          }
        }
      }
      render(json: json, status: status_code)
    else
      json = {
        errors: [
          {
            status: '400',
            code: 'unknown_http_status',
            title: 'Unknown Status Code',
            detail: "The status code #{status_code} is not recognized.",
            meta: {
              status_codes: codes
            }
          }
        ]
      }
      render(json: json, status: 400)
    end
  end
end
