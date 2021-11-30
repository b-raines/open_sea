# frozen_string_literal: true

describe OpenSea::Asset do
  it 'initializes properly with valid json response' do
    asset_json = JSON.parse(File.read("#{Dir.pwd}/spec/json/open_sea/assets.json"))['assets'].first
    asset = described_class.new(asset_json)
    expect(asset.token_id).to eq '1432'
  end

  xit 'throws error for invalid json response' do
    # Make sure proper error is thrown
  end
end
