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
        i.actions = Option.new
      end
    end

    def add_action(button_title, action_proc)
      puts "Deprecated: use actions.add will be removed in 0.3.0"
      actions.add(button_title, &action_proc)
    end

    def show
      show_as_controller || show_as_alert
    end

    def selected(index)
      actions[index].choose
    end

    private

    def show_as_controller
      return nil if !can_show_controller?

      alert_controller.tap do |alert|
        self.actions.attach_to(alert)
        root_controller.presentViewController(alert, animated: false, completion: nil)
      end
    end

    def show_as_alert
      self.actions.attach_to(alert_view).show
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
