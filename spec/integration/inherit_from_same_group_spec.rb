require 'spec_helper'

describe Virtus::Group, "inherit from same group" do
  let!(:user_base_class) do
    Class.new do
      include Virtus.model
      include Virtus.group

      group :user do
        attribute :email
      end
    end
  end

  let!(:user_class) do
    Class.new(user_base_class) do
      group :user do
        attribute :password, String
      end
    end
  end

  let!(:other_user_class) do
    Class.new(user_base_class) do
      group :user do
        attribute :token, String
      end
    end
  end

  let!(:mega_user_class) do
    Class.new(user_class) do
      group :user do
        attribute :token, String
      end
    end
  end

  describe "user class" do
    it "should have the email and password attribute" do
      expect(user_class.attribute_group[:user]).to eq [:email, :password]
    end
  end

  describe "other user class" do
    it "should have the email and token attribute" do
      expect(other_user_class.attribute_group[:user]).to eq [:email, :token]
    end
  end

  describe "mega user class" do
    it "should have the email, password and token attribute" do
      expect(mega_user_class.attribute_group[:user]).to eq [:email, :password, :token]
    end
  end

  context "when accidentally adding same attribute twice" do
    let!(:user_class) do
      Class.new(user_base_class) do
        group :user do
          attribute :email, String
          attribute :password, String
        end
      end
    end

    it "should not add email twice" do
      expect(user_class.attribute_group[:user]).to eq [:email, :password]
    end
  end
end
