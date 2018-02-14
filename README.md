# Cordova plugin for Indoor Positioning

[![Build Status](https://ci.kabisa.nl/buildStatus/icon?job=Indoor-positioning-cordova-plugin/master)](https://ci.kabisa.nl/job/Indoor-positioning-cordova-plugin/job/master/)

This plugin wraps the indoor positioning SDK developed by Philips Lighting.
It can be used to obtain information about the location and heading of a user's device.

You need a configuration string to be able to use the SDK to navigate inside a given venue.
Each configuration string corresponds to a single venue and has an expiration date.
A number of configuration strings are available in the shared folder for IPS in LastPass.

## Using the plugin

Add the plugin to your app by executing the following command.

```
cordova plugin add git+ssh://git@github.com:kabisa/indoor-positioning-cordova-plugin.git
```

Alternatively, modify `config.xml` for your app manually by adding the following.

```
<plugin name="indoor-positioning-cordova-plugin" spec="git+ssh://git@github.com:kabisa/indoor-positioning-cordova-plugin.git" />
```

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
