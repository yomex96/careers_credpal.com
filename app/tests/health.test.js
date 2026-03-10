import request from "supertest";
import { app, pool } from "../src/server.js";
import { jest } from "@jest/globals";

describe("CredPal API Endpoints", () => {
  
  // Clean up: Close the database pool after all tests are done 
  // so Jest can exit gracefully.
  afterAll(async () => {
    await pool.end();
  });

  describe("Basic Connectivity", () => {
    test("GET /health returns healthy status", async () => {
      const res = await request(app).get("/health");
      expect(res.statusCode).toBe(200);
      expect(res.body.status).toBe("healthy");
    });

    test("GET /status returns service info", async () => {
      const res = await request(app).get("/status");
      expect(res.statusCode).toBe(200);
      expect(res.body.service).toBe("credpal-devops-service");
    });
  });

  describe("Data Processing", () => {
    test("POST /process adds data successfully", async () => {
      // Mocking the database query so the test doesn't rely on a live DB
      const mockResult = { id: 1, data: "test-data", created_at: new Date() };
      const dbSpy = jest.spyOn(pool, "query").mockResolvedValue({ rows: [mockResult] });

      const res = await request(app)
        .post("/process")
        .send({ data: "test-data" });

      expect(res.statusCode).toBe(201);
      expect(res.body.message).toBe("Request processed successfully");
      expect(res.body.record.data).toBe("test-data");
      
      dbSpy.mockRestore(); // Clean up the mock
    });

    test("POST /process returns 400 for missing data", async () => {
      const res = await request(app).post("/process").send({});
      expect(res.statusCode).toBe(400);
    });
  });
});
