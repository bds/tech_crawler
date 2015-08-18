require 'spec_helper'

describe TechCrawler::Freshdesk do
  describe "#has_matching_html?" do
    subject { described_class.new(response).has_matching_html? }
    let(:response) do
      double('response', body: body)
    end
    let(:body) do
      <<-eos
        Lebowski ipsum wal, I lost m'chain of thought here. But—aw hell,
        I done innerduced him enough. Dolor sit amet, consectetur adipiscing
        elit praesent ac magna justo. That, or Duder. His Dudeness. Or
        El Duderino, if you know, you're not into the whole brevity thing.
        Pellentesque ac lectus quis elit blandit fringilla #{keyword} ut turpis
        praesent felis. Can we just rent it from you? Ligula, malesuada
        suscipit malesuada non, ultrices non urna sed orci ipsum, placerat.
      eos
    end

    specify '.path' do
      expect(described_class.path).to eq('/help')
    end

    context "the body contains the string 'freshdesk'" do
      let(:keyword) { 'freshdesk' }

      specify do
        expect(subject).to eq(true)
      end
    end

    context "the body does not contain the string 'freshdesk'" do
      let(:keyword) { '' }

      specify do
        expect(subject).to eq(false)
      end
    end
  end
end
