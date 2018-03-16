import { indoorPositioningService } from "../../src/indoorPositioningService";

describe("Indoor Positioning Service", function() {
  context("when Cordova is unavailable", function() {
    beforeEach(function() {
      delete window.cordova;
    });

    context("with a stubbed console", function() {
      beforeEach(function() {
        this.consoleStub = sinon.stub(console, "log");
      });

      afterEach(function() {
        this.consoleStub.restore();
      });

      it("logs a message on the console", function() {
        indoorPositioningService();
        expect(this.consoleStub).to.have.been.calledWith(
          "Cordova is unavailable"
        );
      });
    });
  });

  context("when Cordova is available", function() {
    const SERVICE = "IndoorPositioningService";
    const success = sinon.stub();
    const error = sinon.stub();

    beforeEach(function() {
      this.execStub = sinon.stub();
      window.cordova = {
        exec: this.execStub
      };
    });

    afterEach(function() {
      delete window.cordova;
    });

    const testForwards = action => {
      it(`forwards ${action} actions`, function() {
        indoorPositioningService()[action](success, error);
        expect(this.execStub).to.have.been.calledWith(
          success,
          error,
          SERVICE,
          action,
          []
        );
      });
    };

    ["start", "stop", "getError", "getHeading", "getLocation"].map(
      testForwards
    );

    const testForwardsWithData = action => {
      it(`forwards ${action} actions with data`, function() {
        const data = "abc";
        indoorPositioningService()[action](data, success, error);
        expect(this.execStub).to.have.been.calledWith(
          success,
          error,
          SERVICE,
          action,
          [data]
        );
      });
    };

    ["setConfiguration", "setVenueData"].map(testForwardsWithData);
  });
});
