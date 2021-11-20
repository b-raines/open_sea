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
      ]
    end
    # rubocop:enable Metrics/MethodLength

    def initialize(json)
      super
      attributes["traits"] = json["traits"].map { |trait| Trait.new(trait) }
    end
  end
end
