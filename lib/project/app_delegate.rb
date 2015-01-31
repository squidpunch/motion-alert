class AppDelegate
  # I have no idea why a delegate cannot be a class that i define
  # so i have to piggy back on the app delegate for this..
  def alertView(alert_view, clickedButtonAtIndex: index)
    Motion::Alert.instance.selected(index)
  end
end
