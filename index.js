import { app } from "./app/src/server.js";
const PORT = process.env.PORT || 3000;

const host = process.env.DB_HOST || 'localhost'; 





app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Server running on port ${PORT}`);
});