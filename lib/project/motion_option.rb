module Motion
  class Option
    attr_accessor :actions
    def initialize
      self.actions = []
    end

    def add(text, &block)
      actions << Action.new(text, block)
    end

    def [](index)
      actions[index]
    end

    def count
      actions.count
    end

    def first
      actions.first
    end
  end
end
