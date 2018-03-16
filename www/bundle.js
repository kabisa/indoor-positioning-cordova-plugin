'use strict';

var SERVICE = "IndoorPositioningService";

var forward = function (exec, action) { return function (success, error) { return exec(success, error, SERVICE, action, []); }; };

var forwardWithData = function (exec, action) { return function (data, success, error) {
  exec(success, error, SERVICE, action, [data]);
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
      setConfiguration: forwardWithData(exec, "setConfiguration"),
      setVenueData: forwardWithData(exec, "setVenueData")
    };
  } else {
    // eslint-disable-next-line no-console
    console.log("Cordova is unavailable");
  }
};

var main = indoorPositioningService();

module.exports = main;
