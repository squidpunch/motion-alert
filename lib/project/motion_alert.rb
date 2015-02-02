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
      if can_show_controller?
        root_controller.presentViewController(alert_view_controller, animated: false, completion: nil)
      else
        alert_view.delegate = UIApplication.sharedApplication.delegate
        alert_view.show
      end
    end

    def selected(index)
      if action = self.actions[index].action
        action.call
      end
    end

    private

    def alert_view_controller
      alert_view_controller =
        UIAlertController.alertControllerWithTitle(
          title,
          message: message,
          preferredStyle: UIAlertControllerStyleAlert
      )
      self.actions.each do |a|
        alert_action = UIAlertAction.actionWithTitle(
          a.title,
          style: UIAlertActionStyleDefault,
          handler: ->(arg) { a.action.call }
        )
        alert_view_controller.addAction(alert_action)
      end

      alert_view_controller
    end

    def alert_view
      alert_view = UIAlertView.alloc.initWithTitle(
        title,
        message: message,
        delegate: UIApplication.sharedApplication.delegate,
        cancelButtonTitle: nil,
        otherButtonTitles:
        nil
      )
      self.actions.each do |a|
        alert_view.addButtonWithTitle(a.title)
      end

      alert_view
    end

    def can_show_controller?
      !!UIDevice.currentDevice.systemVersion.match("^8")
    end

    def root_controller
      UIApplication.sharedApplication.keyWindow.rootViewController
    end
  end
end
