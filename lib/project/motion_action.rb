module Motion
  class Action
    attr_accessor :title, :action

    def initialize(title, action=nil)
      self.title = title
      self.action = action
    end

    def choose
      if action != nil
        action.call
      end
    end
  end
end
