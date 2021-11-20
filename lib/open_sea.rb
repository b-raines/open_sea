# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'

class OpenSea
  BASE_URI = 'https://api.opensea.io/api/v1'

  class << self
    def collection(title:)
      url = URI("#{BASE_URI}/collection/#{title}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)

      response = http.request(request)
      OpenSea::Collection.new(json: response.read_body)
    end

    def collections; end
  end
end
