require "spec_helper"

describe Virtus::Group do

  let(:model_class) { Class.new.send(:include, Virtus.group) }

  describe ".group" do
    let(:attribute_tracker_instance) { double(:attribute_tracker_instance) }
    let(:proc) { Proc.new {} }
    let(:tracked_attributes) { [:email] }
    let(:group_name) { :user }

    it "should add tracked attributes to an attribute group" do
      expect(Virtus::Group::AttributeTracker).to receive(:new).once.
        with(model_class, &proc).and_return(attribute_tracker_instance)

      expect(attribute_tracker_instance).to receive(:tracked_attributes).once.and_return(tracked_attributes)

      expect(model_class.group(group_name, &proc)).to eq tracked_attributes
      expect(model_class.attribute_group[group_name]).to eq tracked_attributes
    end
  end

  describe ".attribute_group" do
    it "should return an empty hash" do
      expect(model_class.attribute_group).to eq Hash.new
    end
  end

  describe "#attributes_for" do
    let(:attribute_group) { Hash[user: [:email, :password], address: [:city]] }
    let(:instance) { model_class.new }
    let(:attributes) { Hash[email: 'john@example.com', password: '12344321', city: 'Home'] }

    it "should return all attributes and their values in the selected group" do
      expect(model_class).to receive(:attribute_group).once.and_return(attribute_group)
      expect(instance).to receive(:attributes).once.and_return(attributes)

      result = instance.attributes_for(:user)
      expect(result).to eq Hash[email: 'john@example.com', password: '12344321']
      expect(result).not_to include :city
    end
  end

end


