const mysql = require('mysql2');
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',   
  password: 'David12345',      
  database: 'ventas' 
});
connection.connect((err) => {
  if (err) {
    console.error('Error al conectar a MySQL:', err);
    return;
  }
  console.log('Conexión exitosa a la base de datos de ventas');
});
module.exports = connection;