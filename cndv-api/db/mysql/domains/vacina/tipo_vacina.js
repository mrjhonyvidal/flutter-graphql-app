mysqlDb = require('../../mysql_connection');

async function selectTipoVacina() {
    try{
        const conn      = await mysqlDb.connect();
        const [rows]    = await conn.query('SELECT id, descricao, pais, empresa FROM carteira_tipo_vacina;');
        return await rows;
    }catch(error){
        console.log(error);
    }
}

async function insertTipoVacina(tipoVacina) {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'INSERT INTO carteira_tipo_vacina(id, descricao, pais, empresa) VALUES (?,?,?,?);';
        const values    = [tipoVacina.id, tipoVacina.descricao, 'BRA', '1111111111111']; // TODO pais and empresa pre-fixed, let dynamically and send on request
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function updateTipoVacina(id, tipoVacina) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'UPDATE carteira_tipo_vacina SET descricao=?, pais=?, empresa=? WHERE id=?';
        const values = [tipoVacina.descricao, tipoVacina.pais, tipoVacina.empresa, id];
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function deleteTipoVacina(id) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'DELETE FROM carteira_tipo_vacina WHERE id=?';
        return await conn.query(sql, [id]);
    }catch(error){
        console.log(error);
    }
}

module.exports = {
    selectTipoVacina,
    insertTipoVacina,
    updateTipoVacina,
    deleteTipoVacina
};