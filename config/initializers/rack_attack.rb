
Rack::Attack.throttle("requests by ip", limit: 5, period: 1) do |request|
  request.ip
end