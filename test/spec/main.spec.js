import { alertMessage } from "../../src/main";

describe("alertMessage", function() {
  beforeEach(function() {
    this.alertStub = sinon.stub(window, "alert");
  });

  afterEach(function() {
    this.alertStub.restore();
  });

  it("show a dialog", function() {
    expect(this.alertStub).not.to.have.been.called;
    alertMessage();
    expect(this.alertStub).to.have.been.calledOnce;
  });
});
