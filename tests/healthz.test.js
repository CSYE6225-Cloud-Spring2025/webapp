const request = require("supertest");
const app = require("../app");

describe("Healthz Tests", () => {
    let server;

    beforeAll(async () => {
      server = app.listen();
    });

    afterAll(async () => {
        server.close();
    });

    test("200 for success health check", async () => {
      const response = await request(server).get("/healthz");
      expect(response.status).toBe(200);
    });

    test("400 for incorrect endpoint", async () => {
        const response = await request(server).get("/healthztest");
        expect(response.status).toBe(400);
    });

    test("400 for request with query parameters", async () => {
        const response = await request(server).get("/healthz?param=testing");
        expect(response.status).toBe(400);
    });

    test("405 for incorrect action", async () => {
        const response = await request(server).post("/healthz");
        expect(response.status).toBe(405);
    });
});
