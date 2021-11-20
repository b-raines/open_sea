# frozen_string_literal: true

require 'json'

module OpenSea
  class BaseModel
    attr_reader :attributes

    # Override w/ array of strings for model schema
    def self.schema
      []
    end

    def initialize(json)
      @attributes = self.class.schema.map { |x| [x, nil] }.to_h
      json = JSON.parse(json) if json.is_a?(String)
      attributes.merge!(json.slice(*attributes.keys))
    end

    def to_s
      attributes
    end

    # Override for required attrs to validate data
    def valid?
      false
    end

    private

    def respond_to_missing?(method_name, _include_all)
      attributes.include?(method_name.to_s)
    end

    def method_missing(meth, *args)
      if attributes.key?(meth.to_s)
        attributes[meth.to_s]
      else
        super
      end
    end
  end
end
