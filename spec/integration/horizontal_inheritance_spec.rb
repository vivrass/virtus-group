require 'spec_helper'

describe Virtus::Group do
  let!(:base_class) do
    Class.new do
      include Virtus.model
      include Virtus.group
    end
  end

  let!(:user_class) do
    Class.new(base_class) do
      group :user do
        attribute :email, String
      end
    end
  end

  let!(:address_class) do
    Class.new(base_class) do
      group :address do
        attribute :city, String
      end
    end
  end

  describe "base class" do
    it "should have no attribute groups" do
      expect(base_class.attribute_group).to be_empty
    end
  end

  describe "user class" do
    it "should have only the user attributes" do
      expect(user_class.attribute_group).to include :user
      expect(user_class.attribute_group).not_to include :address
    end
  end

  describe "address class" do
    it "should have only the address attributes" do
      expect(address_class.attribute_group).to include :address
      expect(address_class.attribute_group).not_to include :user
    end
  end
end
