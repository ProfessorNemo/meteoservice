# frozen_string_literal: true

RSpec.describe Meteoservice::NestedHashValue do
  let(:hash) do
    { "FORECAST" =>
    [{ "PHENOMENA" =>
      { "city" => "Санкт-Петербург", "precipitation" => "10" } }] }
  end

  specify '#nested_hash_value' do
    nested_stub = instance_double described_class

    allow(nested_stub).to receive(:nested_hash_value).with(hash, 'city').and_return("Санкт-Петербург")

    expect(nested_stub.nested_hash_value(hash, 'city')).to eq("Санкт-Петербург")

    expect(nested_stub).to have_received(:nested_hash_value)
      .with(hash, 'city').once
  end
end
