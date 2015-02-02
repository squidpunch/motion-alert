describe Motion::Alert do
  before do
    @subject = Motion::Alert.new(title: "title", message: "message")
  end

  it "should set the title to what you provided" do
    @subject.title.should.equal("title")
  end

  it "should set the message to what was provided" do
    @subject.message.should.equal("message")
  end

  it "should be a Motion::Alert" do
    @subject.is_a?(Motion::Alert).should.be.true
  end

  describe "#add_action" do
    before do
      @proc = Proc.new {}
      @subject.add_action("ok", @proc)
    end

    it "should add to the action collection" do
      @subject.actions.count.should.equal(1)
      @subject.actions.first.title.should.equal("ok")
      @subject.actions.first.action.should.equal(@proc)
    end
  end

  describe "#show" do
    tests UINavigationController

    before do
      @clicked_ok = false
      @subject.add_action("OK", Proc.new { @clicked_ok = true })
      @subject.add_action("cancel", nil)
      @subject.show
    end

    it "should show the dialog values" do
      view("title").should.not.be.nil
      view("message").should.not.be.nil
      view("OK").should.not.be.nil
    end

    it "should present using the proper mechanism" do
      if UIDevice.currentDevice.systemVersion == "7.1"
        alert = NSClassFromString("_UIAlertManager").topMostAlert
        alert.should.is_a(UIAlertView).should.be.true
      else
        views(NSClassFromString("_UIAlertControllerView")).should.not.be.empty
      end
    end

    it "should properly call the proc attached to the button" do
      if UIDevice.currentDevice.systemVersion == "7.1"
        # tapping the buttons doesnt seem to work in tests so calling the
        # delegate directly
        alert = NSClassFromString("_UIAlertManager").topMostAlert
        UIApplication.sharedApplication.delegate.alertView(alert, clickedButtonAtIndex: 0)
        @clicked_ok.should.be.true
      else
        # Same problem here, we cannot programatically tap these...
        # So lets mimick what should happen
        Motion::Alert.instance.selected(0)
        @clicked_ok.should.be.true
      end
    end

    it "should not raise exception if the button action is nil" do
      should.not.raise(Exception) do
        Motion::Alert.instance.selected(1)
      end
    end
  end
end
