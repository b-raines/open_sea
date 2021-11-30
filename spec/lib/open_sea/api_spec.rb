# frozen_string_literal: true

describe OpenSea::Api do
  describe 'collection' do
    it 'returns collection for valid response json' do
      stub_request(:get, %r{#{OpenSea::BASE_URI}/collection}o)
        .to_return(status: 200, body: collection_json, headers: {})
      collection = described_class.collection(title: 'Doodles')
      expect(collection.name).to eq 'Doodles'
    end

    xit 'throws proper error for falied request' do
      # Ensure proper error raised
    end
  end

  describe 'assets' do
    it 'returns assets for valid response json' do
      stub_request(:get, %r{#{OpenSea::BASE_URI}/assets}o)
        .to_return(status: 200, body: assets_json, headers: {})
      assets = described_class.assets(collection: 'partydegenerates')
      expect(assets.first.token_id).to eq '1432'
      expect(assets.last.image_url).to eq 'https://lh3.googleusercontent.com/5OihTA5DzH_Nu3sVLlu4ao-zbzMNhp8ixpLONphkfwkGS2EUZc1q4EulKgh0u48WXsPfMhDS-HvXuJabjnPwlOeU8F1OsQRB652FLg'
    end

    xit 'throws proper error for falied request' do
      # Ensure proper error raised
    end
  end

  def collection_json
    File.read("#{Dir.pwd}/spec/json/open_sea/collection.json")
  end

  def assets_json
    File.read("#{Dir.pwd}/spec/json/open_sea/assets.json")
  end
end
