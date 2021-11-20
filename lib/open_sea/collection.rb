# frozen_string_literal: true

module OpenSea
  class Collection
    ATTRIBUTES = %i[
      name
      external_link
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
      stats
    ].freeze

    attr_reader ATTRIBUTES

    def initialize(json:)
      JSON.parse(json).each do |k, v|
        send("#{k}=", v) if respond_to(k)
      end
    end

    def valid?
      name.present? && state.present?
    end

    private

    attr_writer ATTRIBUTES
  end
end
