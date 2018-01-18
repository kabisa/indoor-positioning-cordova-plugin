const buble = require("rollup-plugin-buble");
const resolve = require("rollup-plugin-node-resolve");

module.exports = function(config) {
  config.set({
    basePath: "../",
    frameworks: ["mocha", "chai", "sinon"],
    files: [
      "test/spec/spec_helper.js",
      {
        pattern: "test/spec/**/*.spec.js",
        watched: false
      }
    ],
    exclude: [],
    preprocessors: {
      "test/spec/spec_helper.js": ["rollup"],
      "test/spec/**/*.spec.js": ["rollup"]
    },
    rollupPreprocessor: {
      plugins: [buble(), resolve()],
      output: {
        format: "iife",
				name: "ips",
				sourcemap: "inline"
      }
    },
    reporters: ["mocha"],
    client: {
      mocha: {
        reporter: "html"
      }
    },
    mochaReporter: {
      showDiff: true
    },
    browsers: ["ChromeHeadless"]
  });
};
