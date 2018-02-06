'use strict';

var SERVICE = "IndoorPositioningService";

var forward = function (exec, action) { return function (success, error) { return exec(success, error, SERVICE, action, []); }; };

var setConfiguration = function (exec) { return function (configuration, success, error) {
  exec(success, error, SERVICE, "setConfiguration", [configuration]);
}; };

var indoorPositioningService = function () {
  if (window.cordova) {
    var exec = window.cordova.exec;
    return {
      start: forward(exec, "start"),
      stop: forward(exec, "stop"),
      getError: forward(exec, "getError"),
      getHeading: forward(exec, "getHeading"),
      getLocation: forward(exec, "getLocation"),
      setConfiguration: setConfiguration(exec)
    };
  } else {
    // eslint-disable-next-line no-console
    console.log("Cordova is unavailable");
  }
};

window.indoorPositioning = indoorPositioningService();
