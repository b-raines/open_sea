# frozen_string_literal: true

module OpenSea
  class Collection::Stats < BaseModel
    # rubocop:disable Metrics/MethodLength
    def self.schema
      %w[
        one_day_volume
        one_day_change
        one_day_sales
        one_day_average_price
        seven_day_volume
        seven_day_change
        seven_day_sales
        seven_day_average_price
        thirty_day_volume
        thirty_day_change
        thirty_day_sales
        thirty_day_average_price
        total_volume
        total_sales
        total_supply
        count
        num_owners
        average_price
        num_reports
        market_cap
        floor_price
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
