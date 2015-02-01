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

    describe "iOS 7" do
      before do
        UIDevice.currentDevice.stub!(:systemVersion, return: "7.1")

        @subject.add_action("OK", nil)
      end

      it "should present with the UIAlertView" do
        alert = UIAlertView.alloc.init
        alert.mock!("initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:") do |title, message, delegate, cancel_text, other_buttons|
          title.should.equal("title")
          message.should.equal("message")
          delegate.should.equal(UIApplication.sharedApplication.delegate)
          cancel_text.should.be.nil
          other_buttons.should.be.nil
          alert
        end

        UIAlertView.stub!(:alloc, return: alert)

        @subject.show
      end
    end

    describe "iOS8" do
      before do
        UIDevice.currentDevice.stub!(:systemVersion, return: "8.1")

        @subject.add_action("OK", nil)
      end

      it "should present with the UIAlertController" do
        rc = UIApplication.sharedApplication.keyWindow.rootViewController
        rc.mock!('presentViewController:animated:completion:') do |vc, animated, completion|
          vc.should.is_a?(UIAlertController).should.be.true
          animated.should.be.false
          completion.should.be.nil
        end

        @subject.show
      end
    end
  end
end
