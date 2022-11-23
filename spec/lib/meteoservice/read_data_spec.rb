# frozen_string_literal: true

RSpec.describe Meteoservice::ReadData do
  let(:doc) do
    [{ "PHENOMENA" =>
      { "cloudiness" => "2", "precipitation" => "6", "rpower" => "0", "spower" => "0" },
       "PRESSURE" => { "max" => "757", "min" => "756" },
       "TEMPERATURE" => { "max" => "0", "min" => "-0" },
       "WIND" => { "min" => "4", "max" => "6", "direction" => "3" },
       "RELWET" => { "max" => "62", "min" => "61" },
       "HEAT" => { "min" => "-7", "max" => "-7" },
       "day" => "22", "month" => "11", "year" => "2022", "hour" => "15", "tod" => "2", "predict" => "0", "weekday" => "3" }]
  end

  let(:from_array) { described_class.from_array(doc) }

  let(:new_data) { from_array.to_a }

  describe '#from_array' do
    it "returns instance of #{described_class}" do
      expect(from_array).to be_an_instance_of described_class
    end

    it 'returns instance of Meteoservice::Meteo' do
      expect(new_data.first).to be_an_instance_of(Meteoservice::Meteo)
    end

    it 'returns forecast data' do
      data = new_data.first

      expect(data.data).to eq [2022, 11, 22, 15, 3]
      expect(data.phenomena).to eq [2, 6, 0, 0]
      expect(data.pressure).to eq [756, 757]
      expect(data.temperature).to eq [0, 0]
      expect(data.wind).to eq %w[4 6 3]
      expect(data.relwet).to eq [61, 62]
      expect(data.heat).to eq [-7, -7]
      expect(data.wind.all?(String)).to be true
    end
  end
end
