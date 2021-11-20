# frozen_string_literal: true

module OpenSea
  class Asset::Trait < BaseModel
    # rubocop:disable Metrics/MethodLength
    def self.schema
      %w[
        trait_type
        value
        display_type
        max_value
        trait_count
        order
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
