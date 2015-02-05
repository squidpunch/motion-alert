describe Motion::Action do
  it "should set the title and action values on intialization" do
    a_proc = Proc.new {}
    action = Motion::Action.new("title", a_proc)

    action.title.should.equal("title")
    action.action.should.equal(a_proc)
  end

  it "allows an action without a proc" do
    should.not.raise(Exception) do
      action = Motion::Action.new("title")
      action.title.should.equal("title")
      action.action.should.be.nil
    end
  end

  describe "#choose" do
    it "should call the proc attached to it" do
      some_proc = Proc.new { "proc result" }
      Motion::Action.new("title", some_proc).choose.should.equal("proc result")
    end

    it "can call choose when there is no proc on the action" do
      should.not.raise(Exception) do
        Motion::Action.new("title").choose
      end
    end
  end
end
