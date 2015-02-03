module Motion
  class Alert
    attr_accessor :title
    attr_accessor :message
    attr_accessor :actions

    def self.instance
      Dispatch.once { @instance ||= alloc.init }
      @instance
    end

    def self.new(options = {})
      instance.tap do |i|
        i.title = options.fetch(:title, nil)
        i.message = options.fetch(:message, nil)
        i.actions = []
      end
    end

    def add_action(button_title, action_proc)
      self.actions << Action.new(button_title, action_proc)
    end

    def show
      show_as_controller || show_as_alert
    end

    def selected(index)
      if action = self.actions[index].action
        action.call
      end
    end

    private

    def show_as_controller
      return nil if !can_show_controller?

      alert_controller.tap do |alert|
        self.actions.each do |a|
          alert_action = UIAlertAction.actionWithTitle(
            a.title,
            style: UIAlertActionStyleDefault,
            handler: ->(arg) { a.action.call }
          )
          alert.addAction(alert_action)
        end

        root_controller.presentViewController(alert, animated: false, completion: nil)
      end
    end

    def show_as_alert
      alert_view.tap do |alert|
        self.actions.each do |a|
          alert.addButtonWithTitle(a.title)
        end
        alert.show
      end
    end

    def alert_controller
      UIAlertController.alertControllerWithTitle(
        title,
        message: message,
        preferredStyle: UIAlertControllerStyleAlert
      )
    end

    def alert_view
      UIAlertView.alloc.initWithTitle(
        title,
        message: message,
        delegate: UIApplication.sharedApplication.delegate,
        cancelButtonTitle: nil,
        otherButtonTitles:
        nil
      )
    end

    def can_show_controller?
      !!UIDevice.currentDevice.systemVersion.match("^8")
    end

    def root_controller
      UIApplication.sharedApplication.keyWindow.rootViewController
    end
  end
end
