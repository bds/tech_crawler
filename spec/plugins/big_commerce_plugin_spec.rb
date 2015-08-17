require 'spec_helper'

describe TechCrawler::BigCommerce  do
  describe "#has_matching_cookies?" do
    subject { described_class.new(response).has_matching_cookies? }

    context "the response header contains two matching cookies" do
      let(:response) do
        double(
          'response', headers: {
            'Set-Cookie' => ['fornax_anonymousId=', 'SHOP_SESSION_TOKEN=']
          }
        )
      end

      specify do
        expect(subject).to eq(true)
      end
    end

    context "the response header contains two non-matching cookies" do
      let(:response) do
        double(
          'response', headers: {
            'Set-Cookie' => ['JSESSIONID=', 'gdId==']
          }
        )
      end

      specify do
        expect(subject).to eq(false)
      end
    end

    context "the response header contains only the fornax cookie" do
      let(:response) do
        double('response', headers: { 'Set-Cookie' => 'fornax_anonymousId=' })
      end

      specify do
        expect(subject).to eq(false)
      end
    end

    context "the response header contains only the SHOP_SESSSION_TOKEN cookie" do
      let(:response) do
        double('response', headers: { 'Set-Cookie' => 'SHOP_SESSION_TOKEN=' })
      end

      specify do
        expect(subject).to eq(false)
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
