describe AppDelegate do
  before do
    Motion::Alert.instance.stub!(:selected) do |value|
      @value = value
    end
  end

  after do
    Motion::Alert.instance.reset(:selected)
  end

  it "should pass the selected index into the alert object" do
    UIApplication.sharedApplication.delegate.alertView(stub('fake alert'), clickedButtonAtIndex: 20)
    @value.should.equal(20)
  end
end
