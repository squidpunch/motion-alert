describe Motion::Action do
  it "should set the title and action values on intialization" do
    a_proc = Proc.new {}
    action = Motion::Action.new("title", a_proc)

    action.title.should.equal("title")
    action.action.should.equal(a_proc)
  end
end
