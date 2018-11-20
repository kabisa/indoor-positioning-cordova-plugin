module.exports = {
  env: {
    browser: true,
    es6: true,
    commonjs: true
  },
  globals: {
    process: true,
    __VERSION_NUMBER__: true,
    __BUILD_IDENTIFIER__: true
  },
  plugins: ["compat", "prettier"],
  extends: ["eslint:recommended"],
  parserOptions: {
    sourceType: "module",
    ecmaVersion: 6
  },
  rules: {
    "prettier/prettier": "error",
    "compat/compat": "error"
  }
};
