describe Motion::Option do
  before do
    @subject = Motion::Option.new
  end

  describe "#add" do
    it "should add to the actions collection" do
      @subject.add("ok") { "proc result" }

      @subject.actions.count.should.equal(1)
      @subject.actions.first.title.should.equal("ok")
      @subject.actions.first.action.call.should.equal("proc result")
    end

    it "should allow a nil block for the action" do
      @subject.add("ok")
      @subject.count.should.equal(1)
      @subject.first.title.should.equal("ok")
      @subject.first.action.should.be.nil
    end
  end
end
