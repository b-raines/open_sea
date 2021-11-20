# frozen_string_literal: true

module OpenSea
  class Collection < BaseModel
    # rubocop:disable Metrics/MethodLength
    def self.schema
      %w[
        name
        external_url
        description
        slug
        image_url
        banner_image_url
        dev_seller_fee_basis_points
        safelist_request_status
        payout_address
        primary_asset_contracts
        traits
        payment_tokens
        editors
      ]
    end
    # rubocop:enable Metrics/MethodLength

    def initialize(json)
      super
      attributes['stats'] = Stats.new(json['stats'])
    end
  end
end
