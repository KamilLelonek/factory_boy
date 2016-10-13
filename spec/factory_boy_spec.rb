require "spec_helper"

class User
  attr_accessor :name, :admin
end

describe FactoryBoy do
  it "has a version number" do
    expect(FactoryBoy::VERSION).not_to be nil
  end

  it "should allow to define a factory for a sepcific class" do
    expect { FactoryBoy.define_factory(User) }.not_to raise_error
  end

  it "should create an instance of specified factories" do
    FactoryBoy.define_factory(User)

    user = FactoryBoy.build(User)

    expect(user)     .to be_kind_of(User)
    expect(user.name).to be_nil
  end

  it "should not create an instance of an unknown factory" do
    Admin = Class.new

    expect { FactoryBoy.build(Admin) }.to raise_error(FactoryBoy::UnknownFactory)
  end

  it "should take default attributes for a factory" do
    FactoryBoy.define_factory(User)

    name = "foobar"
    user = FactoryBoy.build(User, name: name)

    expect(user)     .to be_kind_of(User)
    expect(user.name).to eq name
  end

  it "should be able to set default attribute value" do
    default_name = "foobar"

    FactoryBoy.define_factory(User) do
      name default_name
    end

    user = FactoryBoy.build(User)

    expect(user.name).to eq default_name
  end

  it "should allow to override default attribute value" do
    default_name = "foo"

    FactoryBoy.define_factory(User) do
      name default_name
    end

    name = "bar"
    user = FactoryBoy.build(User, name: name)

    expect(user.name).to eq name
  end

  it "should define a factory from a symbol" do
    name = "foobar"

    FactoryBoy.define_factory(:user) do
      name name
    end

    user = FactoryBoy.build(:user)

    expect(user.name).to eq name
  end

  it "should not create an instance of an unknown factory" do
    expect { FactoryBoy.build(:admin) }.to raise_error(FactoryBoy::UnknownFactory)
  end

  it "should allow to define a custom class for a factory" do
    name = "foobar"

    FactoryBoy.define_factory(:admin, class: User) do
      name  name
      admin true
    end

    user = FactoryBoy.build(:admin)

    expect(user.name) .to eq name
    expect(user.admin).to eq true
  end
end
