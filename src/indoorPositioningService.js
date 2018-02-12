const SERVICE = "IndoorPositioningService";

const forward = (exec, action) => (success, error) =>
  exec(success, error, SERVICE, action, []);

const setConfiguration = exec => (configuration, success, error) => {
  exec(success, error, SERVICE, "setConfiguration", [configuration]);
};

export const indoorPositioningService = () => {
  if (window.cordova) {
    const exec = window.cordova.exec;
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
