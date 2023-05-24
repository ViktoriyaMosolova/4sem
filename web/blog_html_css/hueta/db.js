const Pool = require('pg').Pool

const pool = new Pool({
    user: "user",
    password: 'userpass',
    host: "localhost",
    port: 5432,
    database: "node_postgres"
})

//bash
//psql -U user -d testdb
// \q
module.exports = pool