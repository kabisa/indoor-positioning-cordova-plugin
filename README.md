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
cordova plugin add git+ssh://git@github.com:kabisa/indoor-positioning-cordova-plugin.git#:/plugin
```

Alternatively, modify `config.xml` for your app manually by adding the following.

```
<plugin name="indoor-positioning-cordova-plugin" spec="git+ssh://git@github.com:kabisa/indoor-positioning-cordova-plugin.git#:/plugin" />
```

### Zebra devices

There's a modified version of the indoor positioning SDK for Android that supports certain Zebra devices.
A version of this plugin that wraps this version of the SDK is available on the `zebra` branch.
Add this version of the plugin to your app by executing the following command.

```
cordova plugin add git+ssh://git@github.com:kabisa/indoor-positioning-cordova-plugin.git#zebra:/plugin
```

Alternatively, modify `config.xml` for your app manually by adding the following.

```
<plugin name="indoor-positioning-cordova-plugin" spec="git+ssh://git@github.com:kabisa/indoor-positioning-cordova-plugin.git#zebra:/plugin" />
```

## Development workflow

### Prerequisites

* Node >= 6
* NPM
* Yarn

### Getting started

Run `bin/setup` to install all required node packages and set up git hooks.

### Linting

All JavaScript code is linted with [ESLint](https://eslint.org/).

### JavaScript

* Run `yarn lint` to lint all source code.
* Run `yarn test:unit` to run all unit tests once.
* Run `yarn test:watch` to run all unit tests continuously.
* Run `yarn test` to run the linter and all unit tests once.
* Run `yarn build` to watch source files and build a bundle when they change.

### Android

* Set up a new Cordova app and add the Android platform.
One way to do this is described in the [Cordova documentation](https://cordova.apache.org/docs/en/latest/guide/cli/index.html).
* Add this plugin to the app by executing `cordova plugin add <path to plugin>`.
* Execute `cordova build android` and import the code in `<your app>/platforms/android` as a project in Android Studio, as described in the [Cordova documentation](https://cordova.apache.org/docs/en/latest/guide/platforms/android/index.html#opening-a-project-in-android-studio).
