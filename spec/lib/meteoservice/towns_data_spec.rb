# frozen_string_literal: true

RSpec.describe Meteoservice::TownsData do
  let(:service_stub) { class_double described_class }

  let(:result) do
    [[{ "PHENOMENA" =>
      { "cloudiness" => "2", "precipitation" => "6", "rpower" => "0", "spower" => "0" },
        "PRESSURE" => { "max" => "757", "min" => "756" },
        "TEMPERATURE" => { "max" => "0", "min" => "-0" },
        "WIND" => { "min" => "4", "max" => "6", "direction" => "3" },
        "RELWET" => { "max" => "62", "min" => "61" },
        "HEAT" => { "min" => "-7", "max" => "-7" },
        "day" => "22", "month" => "11", "year" => "2022", "hour" => "15", "tod" => "2", "predict" => "0", "weekday" => "3" }], "Москва"]
  end

  describe '#process' do
    it 'when path exist' do
      allow(service_stub).to receive(:process).and_return(result)
      response = service_stub.process

      expect(response).to eq(result)
      expect(response).to be_a(Array)
      expect(response.count).to eq(2)
      expect(response[1]).to eq "Москва"
    end
  end
end
