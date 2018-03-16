const SERVICE = "IndoorPositioningService";

const forward = (exec, action) => (success, error) =>
  exec(success, error, SERVICE, action, []);

const forwardWithData = (exec, action) => (data, success, error) => {
  exec(success, error, SERVICE, action, [data]);
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
      setConfiguration: forwardWithData(exec, "setConfiguration"),
      setVenueData: forwardWithData(exec, "setVenueData")
    };
  } else {
    // eslint-disable-next-line no-console
    console.log("Cordova is unavailable");
  }
};
