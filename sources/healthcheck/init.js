const express = require("express");
const app = express();
app.get("/healthcheck-monitor", (req, res) => {
  res.send({ success: true, message: "It is working" });
});
const PORT = process.env.PORT || 65530;
app.listen(PORT, () => {
  console.log(`Server is running on PORT ${PORT}`);
});