require "spec_helper"

class User
  attr_accessor :name, :admin
end

describe FactoryBoy::InstanceBuilder do
  context "#initialize" do
    it "should prepare a proper schema from a Class" do
      object = described_class.new(User)
      expect(object.schema).to be User
    end

    it "should prepare a proper schema from a symbol" do
      object = described_class.new(:user)
      expect(object.schema).to be User
    end

    it "should not prepare a proper schema from an invalid symbol" do
      expect { described_class.new(:invalid) }.to raise_error(NameError, "uninitialized constant Invalid")
    end

    it "should not prepare a proper schema from an invalid factory" do
      expect { described_class.new(123) }
        .to raise_error(FactoryBoy::InstanceBuilder::InvalidSchema, "The given schema must be either a class or a symbol, got: 123")
    end
  end

  context "#build" do
    it "should build a proper instance" do
      instance_builder = described_class.new(User)
      object           = instance_builder.build({})

      expect(object.name).to be_nil
    end

    it "should build a proper instance based on attributes" do
      instance_builder = described_class.new(User)
      name             = "foo"
      object           = instance_builder.build(name: name)

      expect(object.name).to eq name
    end

    it "should not build an instance based on invalid attributes" do
      instance_builder = described_class.new(User)

      expect { instance_builder.build(age: 10) }.to raise_error(NoMethodError)
    end
  end

  context "defining defaults" do
    it "should define a default attribute" do
      instance_builder = described_class.new(User)
      name             = "foo"

      instance_builder.name name

      object = instance_builder.build({})
      expect(object.name).to eq name
    end
    it "should be able to override default attributes" do
      instance_builder = described_class.new(User)
      name_default     = "foo"
      name_other       = "bar"

      instance_builder.name name_default

      object = instance_builder.build(name: name_other)
      expect(object.name).to eq name_other
    end
  end
end
