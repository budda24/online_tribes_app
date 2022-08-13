const { MAXIMUM_TEST_PHONE_NUMBERS } = require("firebase-admin/lib/auth/auth-config")

module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
    "google",
    "plugin:@typescript-eslint/recommended",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    skipBlankLines: true,
    project: ["tsconfig.json", "tsconfig.dev.json"],
    tsconfigRootDir: __dirname,

    sourceType: "module",
  },
  ignorePatterns: [
    "/lib/**/*", // Ignore built files.
  ],
  plugins: [
    "@typescript-eslint",
    "import",
  ],
  rules: {
    "import/no-unresolved": 0,
    "no-multiple-empty-lines": max,
    "padded-blocks":["error", "never"]

  },
};
