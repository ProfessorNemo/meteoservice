# frozen_string_literal: true

RSpec.describe Box::Parser do
  include Meteoservice::NestedHashValue

  let(:city_index) { 69 }
  let(:path) { "/export/gismeteo/point/#{city_index}.xml" }

  let(:meteodata) do
    VCR.use_cassette('source') { described_class.call(path) }
  end

  let(:city) do
    URI.decode_www_form_component(nested_hash_value(meteodata, 'TOWN')['sname'])
  end

  it 'city and data type' do
    expect(city).to eq('Санкт-Петербург')

    expect(nested_hash_value(meteodata, 'TOWN')['index']).to eq '69'

    expect(nested_hash_value(meteodata, 'FORECAST').size).to eq(4)

    expect(meteodata).to be_a(Hash)

    puts meteodata.inspect
  end

  context 'when the data structure is identical' do
    let(:hash) do
      nested_hash_value(meteodata, 'TEMPERATURE')
        .merge(nested_hash_value(meteodata, 'PRESSURE'))
        .merge(nested_hash_value(meteodata, 'RELWET'))
        .merge(nested_hash_value(meteodata, 'HEAT'))
    end

    it 'temperature, pressure, relwet and heat data' do
      expect(hash).to be_a(Hash)
      expect(hash.size).to eq(2)
      expect(hash).to respond_to(:keys)
      expect(hash).to include("max", "min")
      # все значения в хэше являются строками
      expect(num_string(hash)).to eq(2)
    end
  end

  it 'phenomena data' do
    hash = nested_hash_value(meteodata, 'PHENOMENA')

    expect(hash).to be_a(Hash)
    expect(hash.size).to eq(4)
    expect(hash).to respond_to(:keys)
    expect(hash).to include("cloudiness", "precipitation", "rpower", "spower")
    expect(num_string(hash)).to eq(4)
  end

  it 'wind data' do
    hash = nested_hash_value(meteodata, 'WIND')

    expect(hash).to be_a(Hash)
    expect(hash.size).to eq(3)
    expect(hash).to respond_to(:keys)
    expect(hash).to include("max", "min", "direction")
    expect(num_string(hash)).to eq(3)
  end
end

def num_string(hash)
  hash.map do |_key, val|
    val.instance_of?(String) ? true : nil
  end.count(true)
end
