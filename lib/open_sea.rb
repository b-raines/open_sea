# frozen_string_literal: true

module OpenSea
  BASE_URI = 'https://api.opensea.io/api/v1'

  autoload :Api, 'open_sea/api'
  autoload :Asset, 'open_sea/asset'
  autoload :BaseModel, 'open_sea/base_model'
  autoload :Collection, 'open_sea/collection'
  autoload :Configuration, 'open_sea/configuration'

  def self.configure
    yield self.config
  end

  def self.config
    @@config ||= Configuration.new
  end

  class InvalidArgumentError < StandardError; end
  class ApiError < StandardError
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def message
      errors = JSON.parse(response.body).map { |k, v| "#{k}: #{v}" }.join(", ")
      "#{response.code} #{response.message}: #{errors}"
    end
  end
end
