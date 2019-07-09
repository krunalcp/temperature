# frozen_string_literal: true

require 'uri'
require 'net/http'

#:nodoc:
class Weather
  def self.details(params)
    JSON.parse(call_api(params))
  end

  def self.call_api(params)
    weather_url = URI(url(params))
    http = Net::HTTP.new(weather_url.host, weather_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(weather_url)
    http.request(request).read_body
  rescue StandardError
    {}
  end

  def self.url(params)
    Rails.application.credentials.dig(:weather, :url) +
      "?#{url_query(params)}&units=metric&appid=" +
      Rails.application.credentials.dig(:weather, :app_id)
  end

  def self.url_query(params)
    if params['lat'].present? && params['long'].present?
      "lat=#{params['lat']}&lon=#{params['long']}"
    elsif params['city'].present?
      "q=#{params['city']}"
    else
      "q=#{Rails.application.credentials.dig(:weather, :city)}"
    end
  end
end
