require 'spec_helper'

describe TechCrawler::Shopify  do
  describe "#has_matching_header?" do
    subject { described_class.new(response).has_matching_header? }

    context "the response header 'X-Sorting-Hat-ShopId' contains all digits" do
      let(:response) do
        double('response', headers: { 'X-Sorting-Hat-ShopId' => '123456' })
      end

      specify do
        expect(subject).to eq(true)
      end
    end

    context "the response header 'X-Sorting-Hat-ShopId' is missing" do
      let(:response) do
        double('response', headers: {})
      end

      specify do
        expect(subject).to eq(false)
      end
    end
  end
end
