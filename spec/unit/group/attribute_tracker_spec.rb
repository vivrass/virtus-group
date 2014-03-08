require "spec_helper"

describe Virtus::Group::AttributeTracker do

  let(:model_class) { Class.new.send(:include, Virtus.group) }

  describe "#attribute" do
    let(:proc) { Proc.new { attribute(:email, String) } }

    it "should add the attribute to tracked_attributes" do
      expect(model_class).to receive(:attribute).with(:email, String)
      instance = described_class.new(model_class, &proc)
      expect(instance.tracked_attributes).to include :email
    end
  end

  describe "#tracked_attributes" do
    let(:proc) { Proc.new {} }
    let(:instance) { described_class.new(model_class, &proc) }

    it "should return an empty array" do
      expect(instance.tracked_attributes).to eq []
    end
  end

end
