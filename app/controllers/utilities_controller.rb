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
end
