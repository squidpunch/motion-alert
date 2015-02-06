describe Motion::Action do
  it "should set the title when provided" do
    Motion::Action.new(title: 'my title').title.should.equal('my title')
  end

  it "should default the style" do
    Motion::Action.new.style.should.equal(UIAlertActionStyleDefault)
  end

  it "should set the style when provided" do
    Motion::Action.new(style: UIAlertActionStyleCancel).style.should.equal(UIAlertActionStyleCancel)
  end

  it "should set the action when provided" do
    p = Proc.new {}
    Motion::Action.new(action: p).action.should.equal(p)
  end

  describe "#choose" do
    it "should call the proc attached to it" do
      some_proc = Proc.new { "proc result" }
      Motion::Action.new(title: "title", action: some_proc).choose.should.equal("proc result")
    end

    it "can call choose when there is no proc on the action" do
      should.not.raise(Exception) do
        Motion::Action.new(title: "title").choose
      end
    end
  end
end
