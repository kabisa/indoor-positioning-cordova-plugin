import { message } from "../../src/message";

describe("message", function() {
  it("is equal to 'hello world'", function() {
    expect(message).to.equal("Hello world!");
  });
});
