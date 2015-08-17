require 'spec_helper'

describe TechCrawler::Desk  do
  describe "#has_matching_html?" do
    subject { described_class.new(response).has_matching_html? }
    let(:response) do
      double('response', body: body)
    end

    specify '.path' do
      expect(described_class.path).to eq('/help')
    end

    context "the body contains the string 'desk.com'" do
      let(:body) do
        "Lebowski ipsum wal, I lost m'chain of thought here. But—aw hell, I done innerduced him enough. Dolor sit amet, consectetur adipiscing elit praesent ac magna justo. That, or Duder. His Dudeness. Or El Duderino, if you know, you're not into the whole brevity thing. Pellentesque ac lectus quis elit blandit fringilla %s ut turpis praesent felis. Can we just rent it from you? Ligula, malesuada suscipit malesuada non, ultrices non urna sed orci ipsum, placerat." % 'desk.com'
      end

      specify do
        expect(subject).to eq(true)
      end
    end

    context "the body contains the string 'sfdc'" do
      let(:body) do
        "Lebowski ipsum that wasn't her toe. Dolor sit amet, consectetur adipiscing elit praesent ac magna. Mr. Lebowski is in seclusion in the West Wing. Justo pellentesque ac lectus. Well sir, it's this rug I have, really tied the room together. Quis %s blandit fringilla a. That is our most modestly priced receptacle. Ut turpis praesent felis ligula. Okay. Vee take ze money you haf on you und vee call it eefen. Malesuada suscipit malesuada non, ultrices." % 'sfdc'
      end

      specify do
        expect(subject).to eq(true)
      end
    end

    context "the body contains the string 'desktop'" do
      let(:body) do
        "Lebowski ipsum hello, Pilar? My name is Walter Sobchak, we spoke on the phone, this is my associate Jeffrey Lebowski. Dolor sit amet, consectetur adipiscing elit praesent ac magna justo pellentesque %s lectus. I'm not Mr. Lebowski; you're Mr. Lebowski. I'm the Dude. Quis elit blandit fringilla a ut turpis praesent felis ligula. And so, Theodore Donald Karabotsos, in accordance with what we think your dying wishes might well have been, we commit your mortal remains to the bosom of the Pacific Ocean, which you loved so well. Malesuada suscipit malesuada non, ultrices non urna." % 'desktop'
      end

      specify do
        expect(subject).to eq(false)
      end
    end

    context "the body contains the string 'freshdesk.com'" do
      let(:body) do
        "Lebowski ipsum 1972 Pontiac LeBaron. Dolor sit amet, consectetur adipiscing elit praesent ac magna justo pellentesque ac lectus. Okay. Vee take ze money you haf on you und vee call it eefen. Quis elit blandit fringilla %s turpis praesent felis ligula, malesuada. Little Lebowski Urban Achievers, yes, and proud we are of all of them. Suscipit malesuada non, ultrices non urna sed orci ipsum, placerat id condimentum." % 'freshdesk.com' % 'freshdesk.com'
      end

      specify do
        expect(subject).to eq(false)
      end
    end
  end
end
