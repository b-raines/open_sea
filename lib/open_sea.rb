# frozen_string_literal: true

module OpenSea
  BASE_URI = 'https://api.opensea.io/api/v1'

  autoload :Api, 'open_sea/api'
  autoload :Asset, 'open_sea/asset'
  autoload :BaseModel, 'open_sea/base_model'
  autoload :Collection, 'open_sea/collection'
  Collection.autoload :Stats, 'open_sea/collection/stats'
  Asset.autoload :Trait, 'open_sea/asset/trait'
end