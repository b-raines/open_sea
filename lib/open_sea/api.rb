# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module OpenSea
  class Api
    class << self
      def collection(title:)
        url = URI("#{OpenSea::BASE_URI}/collection/#{title}")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)

        response = http.request(request)
        OpenSea::Collection.new(JSON.parse(response.read_body)["collection"])
      end

      def assets(collection:, limit: 50, page: 0, autopaging: false)
        url = URI("#{OpenSea::BASE_URI}/assets?collection=#{collection}&limit=#{limit}&offset=#{page}")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)

        response = http.request(request)
        _assets = JSON.parse(response.read_body)["assets"].map do |asset|
          OpenSea::Asset.new(asset)
        end

        if autopaging && block_given?
          yield assets
          assets(collection: collection, limit: limit, page: page + 1, autopaging: true)
        else
          _assets
        end
      end
    end
  end
end
