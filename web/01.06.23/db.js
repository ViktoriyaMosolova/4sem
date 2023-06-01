const Pool = require('pg').Pool

const pool = new Pool({
    user: "user",
    password: 'userpass',
    host: "localhost",
    port: 5432,
    database: "test"
})

//bash
//psql -U user -d test
// \q
module.exports = pool