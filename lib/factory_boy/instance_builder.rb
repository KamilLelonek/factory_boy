module FactoryBoy
  class InstanceBuilder
    InvalidSchema = Class.new(StandardError)

    attr_accessor :schema, :defaults

    def initialize(schema)
      @defaults = {}
      @schema   = define_schema(schema)
    end

    def method_missing(name, *args, &_block)
      defaults[name] = args.first || super
    end

    def respond_to_missing?(name, include_private = false)
      defaults[name] || super
    end

    def build(attributes)
      schema.new.tap do |object|
        defaults
          .merge(attributes)
          .each { |key, val| object.public_send("#{key}=", val) }
      end
    end

    private
    def define_schema(schema)
      case schema
        when Symbol then Object.const_get(schema.capitalize)
        when Class  then schema
        else raise InvalidSchema.new("The given schema must be either a class or a symbol, got: #{schema}")
      end
    end
  end
end
