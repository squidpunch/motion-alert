class MainController < UIViewController

  def viewDidLoad
    super
    self.title = 'Motion Alert Demo'

    self.view.backgroundColor = UIColor.whiteColor

    add_gem_button

    add_ios7_button

    add_ios8_button

  end

  def add_ios7_button
    b = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    b.frame = [[100, 100], [100, 50]]
    b.setTitle("iOS 7 alert", forState: UIControlStateNormal)

    b.addTarget(self, action: :show_ios_7_alert,
                forControlEvents: UIControlEventTouchUpInside)

    self.view.addSubview(b)
  end

  def add_ios8_button
    b = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    b.frame = [[100, 151], [100, 50]]
    b.setTitle("iOS 8 Alert", forState: UIControlStateNormal)

    b.addTarget(self, action: :show_ios_8_alert,
                forControlEvents: UIControlEventTouchUpInside)

    self.view.addSubview(b)
  end

  def add_gem_button
    b = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    b.frame = [[100, 202], [100, 50]]
    b.setTitle("Gem Alert", forState: UIControlStateNormal)

    b.addTarget(self, action: :show_gem_alert,
                forControlEvents: UIControlEventTouchUpInside)

    self.view.addSubview(b)
  end

  def show_ios_8_alert
    puts "this will be undefined if you `rake device target=7.1`"

    begin
      alert_view_controller =
        UIAlertController.alertControllerWithTitle(
          "iOS 8 AlertController",
          message: nil,
          preferredStyle: UIAlertControllerStyleAlert
      )
        alert_action = UIAlertAction.actionWithTitle(
          "OK",
          style: UIAlertActionStyleDefault,
          handler: ->(arg) { puts "pressed : #{arg}" }
        )
        alert_view_controller.addAction(alert_action)
        presentViewController(alert_view_controller, animated: true, completion: nil)
    rescue NameError => e
      puts "rescued from #{e}"
    end
  end

  def show_ios_7_alert
    puts "this will technically still work on iOS8 without warning but officially deprecated"
    alert = UIAlertView.alloc.initWithTitle(
      "iOS 7 Alert",
      message: nil,
      delegate: UIApplication.sharedApplication.delegate,
      cancelButtonTitle: "OK",
      otherButtonTitles: nil
    )
    alert.delegate = self
    alert.show
  end

  def show_gem_alert
    Motion::Alert.new({title: "Alert!", message:"This is a test message"}).tap do |a|
      a.add_action("OK", Proc.new { puts 'OK!' })
      a.add_action("Cancel", Proc.new { puts 'Cancel!' })
      a.show
    end
  end


  # for the iOS7 button
  def alertView(alert_view, clickedButtonAtIndex: index)
    puts "selected #{index}"
  end
end
