# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module OpenSea
  class Api
    class << self
      def collection(title:)
        response = get("/collection/#{title}")
        OpenSea::Collection.new(JSON.parse(response.read_body)['collection'])
      end

      def assets(collection:, limit: 50, page: 0)
        response = get(url: "/assets?collection=#{collection}&limit=#{limit}&offset=#{page}")
        _assets = JSON.parse(response.read_body)['assets'].map do |asset|
          OpenSea::Asset.new(asset)
        end

        _assets
      end

      def asset(contract_address:, token_id:)
        response = get(url: "/asset/#{contract_address}/#{token_id}")
        OpenSea::Asset.new(JSON.parse(response.read_body))
      end

      private

      def get(url:)
        url = URI("#{OpenSea::BASE_URI}#{url}")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        http.request(request)
      end
    end
  end
end
