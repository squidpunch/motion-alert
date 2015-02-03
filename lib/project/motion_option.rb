module Motion
  class Option
    attr_accessor :actions

    def initialize
      self.actions = []
      self
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

    def each
      actions.each
    end

    def attach_to(view)
      case view
      when UIAlertView, UIActionSheet
        actions.each do |a|
          view.addButtonWithTitle(a.title)
        end
      when UIAlertController
        actions.each do |a|
          alert_action = UIAlertAction.actionWithTitle(
            a.title,
            style: UIAlertActionStyleDefault,
            handler: ->(arg) { a.action ? a.action.call : nil }
          )
          view.addAction(alert_action)
        end
      end

      view
    end
  end
end
