import express from "express";

const app = express();
app.use(express.json());

app.get("/health", (req, res) => {
  res.status(200).json({ status: "healthy" });
});

app.get("/status", (req, res) => {
  res.json({
    service: "credpal-devops-service",
    uptime: process.uptime(),
  });
});

app.post("/process", (req, res) => {
  res.json({
    message: "Request processed successfully",
    data: req.body,
  });
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});