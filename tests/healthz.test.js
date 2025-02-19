const request = require("supertest");
const {app, sequelize} = require("../app");

describe("Healthz Tests", () => {
    let server;

    beforeAll(async () => {
      server = app.listen();
      await sequelize.sync();
    });

    afterAll(async () => {
        server.close();
        await sequelize.close();
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

    test("503 after table dropped", async () => {
        await sequelize.getQueryInterface().dropTable('healthchecks');
        const response = await request(server).get("/healthz");
        expect(response.status).toBe(503);
    });

});
