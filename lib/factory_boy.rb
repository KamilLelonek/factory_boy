require "factory_boy/version"
require "factory_boy/instance_builder"

module FactoryBoy
  UnknownFactory = Class.new(StandardError)

  @instance_builders = {}

  class << self
    attr_accessor :instance_builders

    def define_factory(schema, opts = {}, &block)
      klass = opts.fetch(:class, schema)
      prepare_instance_builder(schema, klass, block)
    end

    def build(schema, attributes = {})
      raise_if_unknown_factory(schema)
      build_instance(schema, attributes)
    end

    private
    def prepare_instance_builder(schema, klass, block)
      InstanceBuilder.new(klass).tap do |instance_builder|
        instance_builder.instance_eval(&block) if block
        instance_builders[schema] = instance_builder
      end
    end

    def raise_if_unknown_factory(schema)
      raise UnknownFactory.new("Unknown factory") unless instance_builders.include?(schema)
    end

    def build_instance(schema, attributes)
      instance_builders
        .fetch(schema)
        .build(attributes)
    end
  end
end
