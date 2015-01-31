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
    before do
      @ui_alert_view_show = false
      @ui_alert_controller_show = false

      @fake_alert_view = stub(:show) do
        @ui_alert_view_show = true
      end
      @fake_alert_view.stub!(:delegate=) do |value|
      end

      UIAlertView.stub!(:alloc) do
        stub(:initWithTitle) do |args|
          @fake_alert_view
        end
      end
    end

    describe "iOS 7" do
      before do
        UIDevice.currentDevice.stub!(:systemVersion, return: "7.1")

        @subject.show
      end

      it "should present using UIViewAlert" do
        @ui_alert_view_show.should.be.true
      end

      it "should not have called UIAlertController" do
        UIApplication.sharedApplication.keyWindow.rootViewController.visibleViewController.class.should.not.equal(UIAlertController)
      end
    end

    describe "iOS8" do
      before do
        UIDevice.currentDevice.stub!(:systemVersion, return: "8.1")

        @subject.show
      end

      it "should not present using UIViewAlert" do
        @ui_alert_view_show.should.be.false
      end

      it "should have called UIAlertController" do
        UIApplication.sharedApplication.keyWindow.rootViewController.visibleViewController.class.should.equal(UIAlertController)
      end
    end
  end
end
