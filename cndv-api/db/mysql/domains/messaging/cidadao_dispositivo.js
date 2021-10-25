mysqlDb = require('../../mysql_connection');

async function selectCidadaoDispositivo(cpf, token) {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'SELECT ' +
            'cidadao_cpf, ' +
            'dispositivo_token, ' +
            'tipo ' +
            'FROM cidadao_dispositivos WHERE cidadao_cpf=? AND dispositivo_token=?';

        const values = [
            cpf,
            token
        ];
        const [rows] = await conn.query(sql, values);
        return await rows;

    }catch(error){
        console.log(error);
    }
}

async function selectTodosDispositivos() {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'SELECT ' +
            'cidadao_cpf, ' +
            'dispositivo_token, ' +
            'tipo ' +
            'FROM cidadao_dispositivos';

        const [rows] = await conn.query(sql);
        return await rows;

    }catch(error){
        console.log(error);
    }
}

/**
 * Get all Android mobile devices that match the Cidadao Age range and Location(UF, Municipio) of Campaign
 * @returns {Promise<*>}
 */
async function selectAndroidDispositivosMatchAgeAndLocation(campanha_idade_inicial, campanha_idade_final, campanha_uf, campanha_municipio) {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'SELECT ' +
            'cidadao_dispositivos.dispositivo_token ' +
            'FROM cidadao_dispositivos LEFT JOIN carteira_vacina ' +
            'ON cidadao_dispositivos.cidadao_cpf = carteira_vacina.cpf ' +
            'WHERE carteira_vacina.uf = ? AND carteira_vacina.cidade = ? AND TIMESTAMPDIFF(YEAR, carteira_vacina.dt_nascimento, CURDATE()) BETWEEN ? AND ?';

        const values = [
          campanha_uf,
          campanha_municipio,
          campanha_idade_inicial,
          campanha_idade_final
        ];

        const [rows] = await conn.query(sql, values);
        return await rows;
    }catch(error){
        console.log(error);
    }
}

async function insertCidadaoDispositivo(cidadaoDispositivo) {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'INSERT INTO cidadao_dispositivos(' +
            'cidadao_cpf, ' +
            'dispositivo_token, ' +
            'tipo' +
            ') VALUES (?,?,?);';
        const values    = [
            cidadaoDispositivo.cpf,
            cidadaoDispositivo.token,
            cidadaoDispositivo.tipo
        ];
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function updateCidadaoDispositivo(cpf, token) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'UPDATE cidadao_dispositivos ' +
            'SET dispositivo_token=?' +
            ' WHERE cidadao_cpf=?';
        const values = [
            token,
            cpf
        ];
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function deleteCidadaoDispositivo(cpf, token) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'DELETE FROM cidadao_dispositivos WHERE cidadao_cpf=? AND dispositivo_token=?';
        return await conn.query(sql, [cpf, token]);
    }catch(error){
        console.log(error);
    }
}

module.exports = {
    selectCidadaoDispositivo,
    selectTodosDispositivos,
    selectAndroidDispositivosMatchAgeAndLocation,
    insertCidadaoDispositivo,
    updateCidadaoDispositivo,
    deleteCidadaoDispositivo
};