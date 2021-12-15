# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module OpenSea
  class Api
    class << self
      def collection(slug: nil, contract_address: nil)
        # Requires two requests, bc OpenSea doesn't return full collection stats w/ contract endpoint
        if contract_address && !contract_address.empty?
          contract = get("/asset_contract/#{contract_address}")
          slug = JSON.parse(contract.read_body).dig('collection', 'slug')
        end

        raise InvalidArgumentError, 'Must supply either slug or contract_address' if !slug || slug.empty?

        response = get("/collection/#{slug}")

        OpenSea::Collection.new(JSON.parse(response.read_body)['collection'])

      rescue => e
        pp e.message
      end

      def assets(collection: nil, contract_address: nil, token_ids: [], limit: 50, page: 0)
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

        response = get("/assets?#{query_string}")

        JSON.parse(response.read_body).fetch('assets', []).map do |asset|
          OpenSea::Asset.new(asset)
        end
      end

      def asset(contract_address:, token_id:)
        response = get("/asset/#{contract_address}/#{token_id}")
        OpenSea::Asset.new(JSON.parse(response.read_body))
      end

      private

      def success?(response)
        response.code.match?(/2\d\d/)
      end

      def get(url)
        url = URI("#{OpenSea::BASE_URI}#{url}")
        pp url

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request['X-API-KEY'] = OpenSea.config.api_key
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
