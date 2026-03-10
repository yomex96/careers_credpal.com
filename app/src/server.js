import express from "express";
import dotenv from "dotenv";
import pg from "pg";



// dotenv.config();

dotenv.config({ override: false }); 

const { Pool } = pg;

export const app = express();
app.use(express.json());

// Database configuration

export const pool = new Pool({
  host: process.env.DB_HOST || "localhost",
  port: parseInt(process.env.DB_PORT || "5432"),
  user: process.env.DB_USER || "app",
  password: process.env.DB_PASSWORD || "changethis123",
  database: process.env.DB_NAME || "app",
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 5000,
});


const initDB = async () => {
  const queryText = `
    CREATE TABLE IF NOT EXISTS processes (
      id SERIAL PRIMARY KEY,
      data TEXT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  `;
  try {
    const client = await pool.connect();
    await client.query(queryText);
    client.release();
    console.log("✅ Database initialized: 'processes' table is ready.");
  } catch (err) {
    console.error("❌ Database initialization failed:", err.message);
    
  }
};

// Run initialization
initDB();

// --- Routes ---

app.get("/", (req, res) => res.send("CredPal is Working finally let's go!🚀"));

// Standard DevOps Health Check
app.get("/health", (req, res) => res.status(200).json({ status: "healthy" }));

// Detailed Status Endpoint
app.get("/status", (req, res) => {
  res.status(200).json({ 
    service: "credpal-devops-service", 
    uptime: `${Math.floor(process.uptime())}s`,
    timestamp: new Date().toISOString()
  });
});

// POST /process 
app.post("/process", async (req, res, next) => {
  try {
    const { data } = req.body;
    if (!data) {
      return res.status(400).json({ error: "Data field is required in request body" });
    }
    
    const result = await pool.query(
      "INSERT INTO processes(data) VALUES($1) RETURNING *", 
      [data]
    );
    
    res.status(201).json({ 
      message: "Request processed successfully", 
      record: result.rows[0],
      timestamp: new Date().toISOString()
    });
  } catch (err) {
    next(err);
  }
});

// GET /process - Retrieve all records
app.get("/process", async (req, res, next) => {
  try {
    const result = await pool.query("SELECT * FROM processes ORDER BY created_at DESC");
    res.status(200).json({ 
      count: result.rows.length, 
      records: result.rows 
    });
  } catch (err) {
    next(err);
  }
});

app.get("/ping", (req, res) => res.status(200).json({ message: "pong", timestamp: new Date().toISOString() }));

// --- Error Handling ---

// Global Error Handler
app.use((err, req, res, next) => {
  console.error(`[Error] ${err.message}`);
  res.status(500).json({ 
    error: "Internal Server Error", 
    details: process.env.NODE_ENV === "development" ? err.message : "An unexpected error occurred",
    timestamp: new Date().toISOString() 
  });
});


