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
        last_sale
        listing_date
        owner
        traits
      ]
    end
    # rubocop:enable Metrics/MethodLength

    def initialize(json)
      super

      # Weird hack required bc OpenSea doesn't seem to be updating the #owner
      if @attributes.dig("owner", "user", "username") == "NullAddress"
        json = JSON.parse(json) if json.is_a?(String)
        top_owner = json["top_ownerships"].first&.fetch("owner", {})
        @attributes["owner"] = top_owner if top_owner
      end
    end
  end
end
