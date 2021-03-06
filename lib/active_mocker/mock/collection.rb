require 'forwardable'

module ActiveMocker
module Mock

  class Collection

    include Enumerable

    def initialize(collection=[])
      @collection = [*collection]
    end

    def <<(*records)
      collection.concat(records.flatten)
    end

    extend ::Forwardable
    def_delegators :@collection, :take, :push, :clear, :first, :last, :concat, :replace, :uniq, :count, :size, :length, :empty?, :any?, :many?, :include?, :delete
    alias_method :distinct, :uniq

    def select(&block)
      collection.select(&block)
    end

    def each(&block)
      collection.each do |item|
        block.call(item)
      end
    end

    def map(&block)
      collection.map do |item|
        block.call(item)
      end
    end

    def to_a
      @collection
    end

    def to_ary
      to_a
    end

    def hash
      @collection.hash
    end

    def ==(val)
      @collection == val
    end

    # Returns true if relation is blank.
    def blank?
      to_a.blank?
    end

    protected

    attr_accessor :collection

  end

end
end