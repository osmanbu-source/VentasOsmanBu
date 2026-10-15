const express = require('express');
const cors = require('cors');
const controladorVentas = require('./Controllers/Controlador');
const app = express();
app.use(cors());
app.use(express.json());
app.get('/api/ventas', controladorVentas.obtenerVentas);
app.get('/api/ventas/:id', controladorVentas.obtenerVentaPorId);
app.post('/api/ventas', controladorVentas.crearVenta);
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Servidor de Node.js corriendo en el puerto ${PORT}`);
});