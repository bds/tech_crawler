require 'spec_helper'

describe TechCrawler::Magento do
  describe "#has_matching_cookies?" do
    subject { described_class.new(response).has_matching_cookies? }

    context "the response header contains a matching cookie" do
      let(:response) do
        double(
          'response', headers: {
            'Set-Cookie' => Array('frontend=3234')
          }
        )
      end

      specify do
        expect(subject).to eq(true)
      end
    end

    context "the response header contains no cookies" do
      let(:response) do
        double('response', headers: {})
      end

      specify do
        expect(subject).to eq(false)
      end
    end
  end
end

