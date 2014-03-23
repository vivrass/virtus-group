require "spec_helper"

shared_examples 'a virtus object' do
  it "should return the attributes" do
    expect(model.attributes).to eq attributes
  end
end

shared_examples 'an object with a virtus group' do
  let(:model) { model_class.new(attributes) }

  describe "#attributes_for" do
    it "should return the attributes for the user group" do
      expect(model.attributes_for(:user)).to eq user_attributes
    end

    it "should not return any attributes of the address group" do
      expect(model.attributes_for(:user)).not_to include address_attributes
    end

    it "should return the attributes for the address group" do
      expect(model.attributes_for(:address)).to eq address_attributes
    end

    it "should not return any attributes for the user group" do
      expect(model.attributes_for(:address)).not_to include user_attributes
    end
  end

  it_behaves_like "a virtus object"
end

describe Virtus::Group do

  let(:user_attributes) { Hash[email: 'john@example.com'] }
  let(:address_attributes) { Hash[city: 'Home'] }
  let(:attributes) { user_attributes.merge(address_attributes) }

  it_behaves_like 'an object with a virtus group' do
    let(:model_class) do
      Class.new do
        include Virtus.model
        include Virtus.group

        group :user do
          attribute :email, String
        end

        group :address do
          attribute :city, String
        end
      end
    end
  end

  it_behaves_like 'an object with a virtus group' do
    let(:base_class) do
      Class.new do
        include Virtus.model
        include Virtus.group

        group :user do
          attribute :email, String
        end
      end
    end

    let(:model_class) do
      Class.new(base_class) do
        group :address do
          attribute :city, String
        end
      end
    end
  end

  it_behaves_like 'an object with a virtus group' do
    let(:model_class) do
      Class.new do
        include Virtus.value_object
        include Virtus.group

        values do
          group :user do
            attribute :email, String
          end

          group :address do
            attribute :city, String
          end
        end
      end
    end
  end

end

