var app = {
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    onDeviceReady: function() {
        window.indoorPositioning.setConfiguration(
          configuration,
          () => this.logEvent("Successfully set configuration"),
          error =>
            this.logEvent("Error while setting configuration: " + error)
        );
        window.indoorPositioning.setVenueData(
          venueData,
          () => this.logEvent("Successfully set venue data"),
          error =>
            this.logEvent("Error while setting venue data: " + error)
        );
        window.indoorPositioning.start(
          () => this.logEvent("Started successfully"),
          error => this.logEvent("Error while starting: " + error)
        );
        setInterval(
          () => window.indoorPositioning.getLocation(
            this.updateLocation,
            error => this.logEvent("Error while getting location: " + error)
          ),
          2000
        );
        setInterval(
          () => window.indoorPositioning.getError(
            this.updateError,
            error => this.logEvent("Error while getting error: " + error)
          ),
          2000
        );
    },

    logEvent: function(description) {
      var sdkEventsElement = document.getElementById("sdk-events");
      var eventElement = document.createElement("li");

      eventElement.innerText = description;
      sdkEventsElement.appendChild(eventElement);
    },

    updateError: function(error) {
      document.getElementById("error").innerText = error;
    },

    updateLocation: function(location) {
      document.getElementById("lat").innerText = location.kIPLocationLatitude;
      document.getElementById("lon").innerText = location.kIPLocationLongitude;
    }
};

app.initialize();
