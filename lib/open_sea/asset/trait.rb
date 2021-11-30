# frozen_string_literal: true

module OpenSea
  module Asset
    class Trait < BaseModel
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
    end
  end
end
