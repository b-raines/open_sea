# frozen_string_literal: true

describe OpenSea::Collection do
  it 'initializes properly with valid json response' do
    collection_json = JSON.parse(File.read("#{Dir.pwd}/spec/json/open_sea/collection.json"))["collection"]
    collection = described_class.new(collection_json)
    expect(collection.name).to eq 'Doodles'
    expect(collection.external_url).to eq 'https://doodles.app'
    expect(collection.stats.one_day_volume).to eq 1007.0807702282
  end

  xit 'throws error for invalid json response' do
    # Make sure proper error is thrown
  end
end
