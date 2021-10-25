mysqlDb = require('../../mysql_connection');

async function selectTipoDose() {
    try{
        const conn      = await mysqlDb.connect();
        const [rows]    = await conn.query('SELECT id, descricao, pais, empresa FROM carteira_tipo_dose;');
        return await rows;
    }catch(error){
        console.log(error);
    }
}

async function insertTipoDose(tipoDose) {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'INSERT INTO carteira_tipo_dose(id, descricao, pais, empresa) VALUES (?,?,?,?);';
        const values    = [tipoDose.id, tipoDose.descricao, tipoDose.pais, tipoDose.empresa];
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function updateTipoDose(id, tipoDose) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'UPDATE carteira_tipo_dose SET descricao=?, pais=?, empresa=? WHERE id=?';
        const values = [tipoDose.descricao, tipoDose.pais, tipoDose.empresa, id];
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function deleteTipoDose(id) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'DELETE FROM carteira_tipo_dose WHERE id=?';
        return await conn.query(sql, [id]);
    }catch(error){
        console.log(error);
    }
}

module.exports = { selectTipoDose, insertTipoDose, updateTipoDose, deleteTipoDose };