describe Motion::Alert do
  shared "a motion alert" do
    it "should set the title to what you provided" do
      @subject.title.should.equal("title")
    end

    it "should set the message to what was provided" do
      @subject.message.should.equal("message")
    end

    it "should be a Motion::Alert" do
      @subject.is_a?(Motion::Alert).should.be.true
    end

    it "should return an options object for `actions`" do
      @subject.actions.is_a?(Motion::Option).should.be.true
    end
  end

  describe "when requesting an alert" do
    tests UINavigationController

    before do
      @subject = Motion::Alert.new(title: "title", message: "message")
    end

    behaves_like "a motion alert"

    it "should have the proper type" do
      @subject.type.should.equal(:alert)
    end

    describe "#show" do
      before do
        @subject.actions.add("OK") { "clicked ok" }
        @subject.show
      end

      after do
        if UIDevice.currentDevice.systemVersion.to_i >= 8
          UIApplication.sharedApplication.keyWindow.rootViewController.dismissViewControllerAnimated(false, completion: nil)
        end
      end

      it "should fire the on click" do
        if UIDevice.currentDevice.systemVersion.to_i >= 8
          # tapping the buttons doesnt seem to work in tests so calling the delegate directly
          Motion::Alert.instance.selected(0).should.equal("clicked ok")
        else
          # Same problem here, we cannot programatically tap these...
          # So lets mimick what should happen
          alert = NSClassFromString("_UIAlertManager").topMostAlert
          UIApplication.sharedApplication.delegate.alertView(alert, clickedButtonAtIndex: 0).should.equal("clicked ok")
        end
      end

      it "should present using the proper mechanism" do
        if UIDevice.currentDevice.systemVersion.to_i >= 8
          views(NSClassFromString("_UIAlertControllerView")).should.not.be.empty
        else
          alert = NSClassFromString("_UIAlertManager").topMostAlert
          alert.should.is_a(UIAlertView).should.be.true
        end
      end
    end
  end

  describe "when requesting an action sheet" do
    tests UINavigationController

    before do
      @subject = Motion::Alert.new(
        title: "title",
        message: "message",
        type: :action_sheet
      )
    end

    behaves_like "a motion alert"

    it "should have the proper type" do
      @subject.type.should.equal(:action_sheet)
    end

    describe "#show" do
      before do
        @subject.actions.add("OK") { "clicked ok" }
        @subject.show
      end

      after do
        if UIDevice.currentDevice.systemVersion.to_i >= 8
          UIApplication.sharedApplication.keyWindow.rootViewController.dismissViewControllerAnimated(false, completion: nil)
        end
      end

      it "should fire the on click" do
        if UIDevice.currentDevice.systemVersion.to_i >= 8
          # tapping the buttons doesnt seem to work in tests so calling the delegate directly
          Motion::Alert.instance.selected(0).should.equal("clicked ok")
        else
          # Same problem here, we cannot programatically tap these...
          # So lets mimick what should happen
          alert = NSClassFromString("_UIAlertManager").topMostAlert
          UIApplication.sharedApplication.delegate.alertView(alert, clickedButtonAtIndex: 0).should.equal("clicked ok")
        end
      end

      it "should present using the proper mechanism" do
        if UIDevice.currentDevice.systemVersion == "7.1"
          alert = NSClassFromString("_UIAlertManager").topMostAlert
          alert.should.is_a(UIActionSheet).should.be.true
        else
          views(NSClassFromString("_UIAlertControllerView")).should.not.be.empty
        end
      end
    end
  end

  describe "#presenter" do
    it "should default to the root view controller of the key window" do
      Motion::Alert.instance.presenter.should.equal(UIApplication.sharedApplication.keyWindow.rootViewController)
    end
  end
end
