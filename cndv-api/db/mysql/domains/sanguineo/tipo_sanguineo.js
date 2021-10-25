mysqlDb = require('../../mysql_connection');

async function selectTipoSanguineo() {
    try{
        const conn      = await mysqlDb.connect();
        const [rows]    = await conn.query('SELECT tipo, pais, pode_receber, pode_doar, empresa FROM carteira_tipo_sanguineo;');
        return await rows;
    }catch(error){
        console.log(error);
    }
}

async function insertTipoSanguineo(tipoSanguineo) {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'INSERT INTO carteira_tipo_sanguineo(tipo, pais, pode_receber, pode_doar, empresa) VALUES (?,?,?,?,?);';
        const values    = [tipoSanguineo.tipo, tipoSanguineo.pais, tipoSanguineo.pode_receber, tipoSanguineo.pode_doar, tipoSanguineo.empresa];
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function updateTipoSanguineo(tipoSanguineo) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'UPDATE carteira_tipo_sanguineo SET tipo=?, pais=?, pode_receber=?, pode_doar=? WHERE tipo=?';
        const values = [tipoSanguineo.tipo, tipoSanguineo.pais, tipoSanguineo.pode_receber, tipoSanguineo.pode_doar, tipoSanguineo.tipo];
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function deleteTipoSanguineo(tipo) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'DELETE FROM carteira_tipo_sanguineo WHERE tipo=? AND empresa=?';
        return await conn.query(sql, [tipo]);
    }catch(error){
        console.log(error);
    }
}

module.exports = { selectTipoSanguineo, insertTipoSanguineo, updateTipoSanguineo, deleteTipoSanguineo };