# frozen_string_literal: true

describe OpenSea::Collection do
  it 'initializes properly with valid json response' do
    collection_json = JSON.parse(File.read('json/open_sea/colleciton.json'))
    collection = described_class.new(json: collection_json)
    expect(collection).to be_valid
  end

  xit 'throws error for invalid json response' do
  end
end
