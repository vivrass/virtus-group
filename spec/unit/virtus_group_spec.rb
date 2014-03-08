require "spec_helper"

describe Virtus::Group do

  let(:model_class) { Class.new.send(:include, Virtus.group) }

  describe ".group" do
    it "should return the group name" do
      expect(model_class.group(:user)).to eq :user
    end
  end

end


