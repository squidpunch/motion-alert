module Motion
  class Option
    attr_accessor :actions

    def initialize
      self.actions = []
      self
    end

    def add(text, style=nil, &block)
      actions << Action.new(title: text, style: style, action: block)
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
        actions.each_with_index do |action, index|
          view.addButtonWithTitle(action.title)
          case action.style
          when UIAlertActionStyleCancel
            view.cancelButtonIndex = index
          when UIAlertActionStyleDestructive
            view.destructiveButtonIndex = index
          end
        end
      when UIAlertController
        actions.each do |a|
          alert_action = UIAlertAction.actionWithTitle(
            a.title,
            style: a.style,
            handler: ->(arg) { a.action ? a.action.call : nil }
          )
          view.addAction(alert_action)
        end
      end

      view
    end
  end
end
