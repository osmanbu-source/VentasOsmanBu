const db = require('../Base');
const obtenerVentas = (req, res) => {
  const sql = 'SELECT * FROM ventas';
  db.query(sql, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
};
const obtenerVentaPorId = (req, res) => {
  const { id } = req.params;
  const sql = 'SELECT * FROM ventas WHERE id = ?';
  db.query(sql, [id], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    if (results.length === 0) return res.status(404).json({ mensaje: 'Venta no encontrada' });
    res.json(results[0]);
  });
};
const crearVenta = (req, res) => {
  const { cliente, total, fecha } = req.body;
  const sql = 'INSERT INTO ventas (cliente, total, fecha) VALUES (?, ?, ?)';
  db.query(sql, [cliente, total, fecha], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ mensaje: 'Venta registrada con éxito', id: result.insertId });
  });
};
module.exports = {
  obtenerVentas,
  obtenerVentaPorId,
  crearVenta
};