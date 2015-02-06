module Motion
  class Alert
    attr_accessor :title
    attr_accessor :message
    attr_accessor :actions
    attr_accessor :type

    def self.instance
      Dispatch.once { @instance ||= alloc.init }
      @instance
    end

    def self.new(options = {})
      instance.tap do |i|
        i.title = options.fetch(:title, nil)
        i.message = options.fetch(:message, nil)
        i.type = options.fetch(:type, :alert)
        i.actions = Option.new
      end
    end

    def show
      show_as_controller || show_as_alert || show_as_action_sheet
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
      if type == :alert
        self.actions.attach_to(alert_view).show
      end
    end

    def show_as_action_sheet
      self.actions.attach_to(action_sheet).showInView(root_controller.view)
    end

    def alert_controller
      UIAlertController.alertControllerWithTitle(
        title,
        message: message,
        preferredStyle: style
      )
    end

    def style
      case type
      when :alert
        UIAlertControllerStyleAlert
      when :action_sheet
        UIAlertControllerStyleActionSheet
      else
        UIAlertControllerStyleAlert
      end
    end

    def alert_view
      UIAlertView.alloc.initWithTitle(
        title,
        message: message,
        delegate: UIApplication.sharedApplication.delegate,
        cancelButtonTitle: nil,
        otherButtonTitles: nil
      )
    end

    def action_sheet
      UIActionSheet.alloc.initWithTitle(
        title,
        delegate: UIApplication.sharedApplication.delegate,
        cancelButtonTitle: nil,
        destructiveButtonTitle: nil,
        otherButtonTitles: nil
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
