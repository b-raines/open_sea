# frozen_string_literal: true

module OpenSea
  class Asset < BaseModel
    # rubocop:disable Metrics/MethodLength
    def self.schema
      %w[
        token_id
        image_url
        background_color
        name
        external_link
        asset_contract
        owner
        last_sale
        listing_date
        traits
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
