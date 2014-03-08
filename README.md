# Virtus::Group

The idea of this gem is to define groups over virtus attributes.
Which is especially useful when you are working with [form objects](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/)
and you don't want to use nasty nested form objects.

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

Don't worry, the `SignUpForm` class will still behave like a regular Virtus class.
By defining the attributes in groups you get an extra property `attribute_group`.


```ruby
# ---
# the attribute_group class method

SignUpForm.attribute_group
# => {user: [:email, :password], address: [:street, :zipcode, :city]}

SignUpForm.attribute_group[:user]
# => [:email, :password]

SignUpForm.attribute_group[:address]
# => [:street, :zipcode, :city]

# ---
# the attribute_group instance method

sign_up_form = SignUpForm.new({
  email: 'john@example.com', password: '12344321',
  street: 'ABC-Street 1', zipcode: 'Z1234', city: 'ABC'
})

sign_up_form.attribute_group[:user]
# => {email: 'john@example.com', password: '12344321'}

sign_up_form.attribute_group[:address]
# => {street: 'ABC-Street 1', zipcode: 'Z1234', city: 'ABC'}
```

Let's say you have a `create` method on your `SignUpForm` you can use the attribute groups to create your models:

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
    user = User.build(attribute_group[:user])
    user.build_address(attribute_group[:address])
    user.save
  end
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'virtus-group'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install virtus-group

## Contributing

1. Fork it ( http://github.com/spoptchev/virtus-group/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


