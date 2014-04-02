require "spec_helper"

describe Virtus::Group::AttributeGroups do

  describe "#for_class" do
    subject { described_class.new }

    it "should return an empty hash" do
      expect(subject.for_class(described_class)).to eq Hash.new
    end
  end

  describe "#mapping" do
    subject { described_class.new }

    it "should return an empty hash" do
      expect(subject.for_class(described_class)).to eq Hash.new
    end
  end

end
