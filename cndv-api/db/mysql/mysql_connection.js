require('dotenv').config({path:'env/qa.env'});

async function connect(){
    if (global.connection && global.connection.state !== 'disconnected') {
        return global.connection;
    }

    const mysql = require("mysql2");
    const pool = mysql.createPool({
        host: process.env.MYSQL_HOST,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
        port: process.env.MYSQL_PORT,
        database: process.env.MYSQL_DATABASE,
        waitForConnections: true,
        connectionLimit: 10,
        queueLimit: 0
    });

    const promisePool = pool.promise();
    return promisePool;
}

module.exports = {connect}