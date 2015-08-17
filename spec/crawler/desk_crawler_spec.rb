require 'spec_helper'

describe TechCrawler::Crawler, 'Desk', :vcr do
  subject { described_class.new(domains, mock_logger) }

  let(:mock_logger) do
    instance_double("Logger", info: nil, error: nil)
  end
  let(:domains) do
    IO.read('spec/support/desk.txt').split
  end

  specify '#call! matches all URLs' do
    expect(mock_logger).to receive(:info).exactly(domains.size).times.with(
      /TechCrawler::Desk, true/
    )

    subject.call!
  end
end