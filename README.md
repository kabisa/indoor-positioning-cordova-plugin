# Cordova plugin for Indoor Positioning

[![Build Status](https://ci.kabisa.nl/buildStatus/icon?job=Indoor-positioning-cordova-plugin/master)](https://ci.kabisa.nl/job/Indoor-positioning-cordova-plugin/job/master/)

This plugin wraps the indoor positioning SDK developed by Signify.
It can be used to obtain information about the location and heading of a user's device.

You need a configuration string to be able to use the SDK to navigate inside a given venue.
Each configuration string corresponds to a single venue and has an expiration date.

## Using the plugin

1. Clone this repository and navigate to the folder in which you've cloned it.
1. Put the Android SDK (`IndoorPositioning.aar`) in the folder `src/android`.
1. Put the iOS SDK (`IndoorPositioning.framework`) in the folder `src/ios`.
1. Add the plugin to your Cordova app by executing `cordova plugin add <folder in which you've cloned the plugin>`.

This slightly cumbersome way of adding the plugin is required because we're not allowed to distribute the SDKs.
You have to manually add the Android and iOS SDK after obtaining them from Signify.

After adding the plugin to your Cordova app, you'll have access to the object `window.indoorPositioning`.
This object has the following methods:

* `start`, to start the SDK.
* `stop`, to stop the SDK.
* `setConfiguration`, to set the configuration for a given venue.
* `getLocation`, to get the most recent location of the device running the app.
* `getError`, to get the most recent error raised by the SDK.

Each method takes a success and an error callback.

* For the methods `start`, `stop`, and `setConfiguration`, the success callback takes no argument.
* For the method `getLocation`, the success callback takes a location object as argument, with two attributes: `kIPLocationLatitude` and `kIPLocationLongitude`.
* For the method `getError` the success callback takes an error as argument.
* The error callback takes an error as argument.

## Development workflow

### Prerequisites

* Node
* NPM
* Yarn

### Getting started

Run `bin/setup` to install all required node packages and set up git hooks.

### Linting

All JavaScript code for the plugin is linted with [ESLint](https://eslint.org/).

### JavaScript

* `yarn lint` lints all source code.
* `yarn test:unit` runs all unit tests once.
* `yarn test:watch` runs all unit tests continuously.
* `yarn test` runs the linter and all unit tests once.
* `yarn build` watches source files and builds a bundle when they change.

### Android and iOS

There's a very basic Cordova app in the `app` folder that demonstrates the use of this plugin.
You can use this app to debug the platform-specific code.

Run `bin/clean` to regenerate the Android and iOS code for this app.
Afterwards, you can import the code in `app/platforms/android` as a project in Android Studio, as described in the [Cordova documentation](https://cordova.apache.org/docs/en/latest/guide/platforms/android/index.html#opening-a-project-in-android-studio).
Similarly, you can import the code in `app/platforms/ios` as a project in XCode.
