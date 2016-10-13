# FactoryBoy

`FactoryBoy` gem is a simple factory DSL inspired by [`FactoryGirl`](https://github.com/thoughtbot/factory_girl).

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/factory_boy`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "factory_boy"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factory_boy

## Usage

Let's assume we have the following class:

```ruby
class User
  attr_accessor :name
end
```

You are able to define a factory for this class:

```ruby
FactoryBoy.define_factory(User)
```

and then create instances of the class:

```ruby
FactoryBoy.build(User) # => #<User:0x007fb6c4133c60 @name=nil>
```

The `#build` method creates the instance using the default constructor.
You are able to set attributes by passing a hash as the second argument to `#build`:

```ruby
FactoryBoy.build(User, name: "foobar") # => #<User:0x007fb6c4133c60 @name="foobar">
```

FactoryBoy is able to set default attribute values. This is how it works:

```ruby
FactoryBoy.define_factory(User) do
  name "foobar"
end

FactoryBoy.build(User) # => #<User:0x007fb6c4133c60 @name="foobar">
```

These defaults are overridable:

```ruby
FactoryBoy.build(User, name: "FOOBAR") # => #<User:0x007fb6c4133c60 @name="FOOBAR">
```

FactoryBoy handles the following way of building:

```ruby
FactoryBoy.define_factory(:user) do
  name "foobar"
end

FactoryBoy.build(:user) # => #<User:0x007fb98492834 @name="foobar">
and
```

You can also define a custom class for your factory:

```ruby
FactoryBoy.define_factory(:admin, class: User) do
  name "foobar"
  admin true
end

FactoryBoy.build(:admin) # => #<User:0x007fb98492834 @name="foobar" @admin=true>
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/factory_boy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

