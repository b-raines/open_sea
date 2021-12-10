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

      def assets(collection: '', contract_address: '', token_ids: [], limit: 50, page: 0)
        if (collection.nil? || collection.empty?) && (contract_address.nil? || contract_address.empty?)
          raise InvalidArgumentError, 'Must supply either collection slug or contract_address'
        end

        query_string = URI.encode_www_form({
          collection: collection,
          asset_contract_address: contract_address,
          token_ids: token_ids,
          limit: limit,
          offset: page,
        })

        response = get(url: "/assets?#{query_string}")

        JSON.parse(response.read_body).fetch('assets', []).map do |asset|
          OpenSea::Asset.new(asset)
        end
      end

      def asset(contract_address:, token_id:)
        response = get(url: "/asset/#{contract_address}/#{token_id}")
        OpenSea::Asset.new(JSON.parse(response.read_body))
      end

      private

      def success?(response)
        response.code.match?(/2\d\d/)
      end

      def get(url:)
        url = URI("#{OpenSea::BASE_URI}#{url}")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request['X-API-KEY'] = api_key if api_key
        response = http.request(request)
        raise ApiError.new(response) unless success?(response)
        response
      end

      def api_key
        ENV["OPEN_SEA_API_KEY"]
      end
    end
  end
end
