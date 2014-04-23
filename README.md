# Virtus.group

[![Gem Version](https://badge.fury.io/rb/virtus-group.svg)](http://badge.fury.io/rb/virtus-group)
[![Build Status](https://travis-ci.org/spoptchev/virtus-group.png?branch=master)](https://travis-ci.org/spoptchev/virtus-group)
[![Dependency Status](https://gemnasium.com/spoptchev/virtus-group.svg)](https://gemnasium.com/spoptchev/virtus-group)

The idea of this gem is to define groups over Virtus attributes.
Which is especially useful when you are working with [form objects](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/).

## Installation

Add this line to your application's Gemfile:

    gem 'virtus-group'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install virtus-group

## Usage

```ruby
class SignUpForm
  include Virtus.model
  include Virtus.group

  group :user do
    attribute :email, String
    attribute :password, String
  end

  group :address do
    attribute :street, String
    attribute :zipcode, String
    attribute :city, String
  end
end
```

Don't worry, the `SignUpForm` object will still behave like a regular Virtus object.

```ruby
# ---

SignUpForm.attribute_group
# => {user: [:email, :password], address: [:street, :zipcode, :city]}

SignUpForm.attribute_group[:user]
# => [:email, :password]

SignUpForm.attribute_group[:address]
# => [:street, :zipcode, :city]

# ---

sign_up_form = SignUpForm.new({
  email: 'john@example.com', password: '12344321',
  street: 'ABC-Street 1', zipcode: 'Z1234', city: 'ABC'
})

sign_up_form.attributes_for :user
# => {email: 'john@example.com', password: '12344321'}

sign_up_form.attributes_for :address
# => {street: 'ABC-Street 1', zipcode: 'Z1234', city: 'ABC'}
```

You can easily build your models from the attribute groups:

```ruby
class SignUpForm
  include Virtus.model
  include Virtus.group

  group :user do
    attribute :email, String
    attribute :password, String
  end

  group :address do
    attribute :street, String
    attribute :zipcode, String
    attribute :city, String
  end

  def create
    user = User.new(attributes_for(:user))
    user.build_address(attributes_for(:address))
    user.save
  end
end
```



## Contributing

1. Fork it ( http://github.com/spoptchev/virtus-group/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



