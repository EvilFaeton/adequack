require "spec_helper"
require_relative "../fixtures/interfaces/animal"
require_relative "../fixtures/interfaces/identificationable"
require_relative "../fixtures/animal"
require_relative "../fixtures/owner"

describe Animal do
  it do
    described_class.should behave_like Interface::AnimalInterface,
      Interface::Identificationable
    expect(described_class).to behave_like Interface::AnimalInterface,
      Interface::Identificationable
  end
end

describe Owner do
  let(:animal) do
    behavioral_double double,
      Interface::AnimalInterface, Interface::Identificationable
  end

  subject { described_class.new animal }

  context "when using should syntax" do
    it "tricks animal" do
      animal.should_receive(:bark).and_return("barked")
      subject.trick_animal.should eql "barked"
    end

    it "feeds animal" do
      animal.should_receive(:feed).and_return("barked")
      subject.enormously_feed_animal.should eql "barked"
    end
  end

  context "when using expect syntax" do
    it "tricks animal" do
      animal.should_receive(:bark).and_return("barked")
      expect(subject.trick_animal).to eql "barked"
    end

    it "feeds animal" do
      animal.should_receive(:feed).and_return("barked")
      expect(subject.enormously_feed_animal).to eql "barked"
    end
  end
end
