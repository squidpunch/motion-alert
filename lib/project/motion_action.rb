module Motion
  class Action
    attr_accessor :title, :action, :style

    def initialize(options = {})
      self.title = options.fetch(:title, nil)
      self.action = options.fetch(:action, nil)
      self.style = options.fetch(:style, nil) || UIAlertActionStyleDefault
    end

    def choose
      if action != nil
        action.call
      end
    end
  end
end
