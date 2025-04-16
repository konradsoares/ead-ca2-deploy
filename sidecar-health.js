const express = require('express');
const app = express();
const PORT = 8080;

const activeNode = process.env.ACTIVE_NODE || 'unknown';

app.get(`/health-${activeNode}`, (req, res) => {
  res.status(200).send(`Healthy - ${activeNode}`);
});

app.listen(PORT, () => {
  console.log(`Health check service running at http://0.0.0.0:${PORT}/health-${activeNode}`);
});
