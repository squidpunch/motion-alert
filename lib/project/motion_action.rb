module Motion
  class Action
    attr_accessor :title, :action

    def initialize(title, action)
      self.title = title
      self.action = action
    end
  end
end
