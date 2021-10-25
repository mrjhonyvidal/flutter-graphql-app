mysqlDb = require('../../mysql_connection');

async function selectCampanhas() {
    try{
        const conn      = await mysqlDb.connect();
        const [rows]    = await conn.query('SELECT id, nome, idade_inicio, idade_final, id_tipo_vacina, cidade, uf, descricao FROM campanhas ORDER BY dt_atualizacao DESC;');
        return await rows;
    }catch(error){
        console.log(error);
    }
}

async function selectCampanhaById(id) {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'SELECT ' +
            'campanhas.id, ' +
            'campanhas.nome, ' +
            'campanhas.idade_inicio, ' +
            'campanhas.idade_final, ' +
            'campanhas.id_tipo_vacina, ' +
            'campanhas.cidade, ' +
            'campanhas.uf, ' +
            'campanhas.descricao ' +
            'FROM campanhas ' +
            'WHERE campanhas.id=?';

        const values = [
            id
        ];
        const [rows] = await conn.query(sql, values);
        return await rows;
    }catch(error){
        console.log(error);
    }
}

async function searchCampanhas(input) {
    try{
        const valuesForSQLParameters = [];
        const conn      = await mysqlDb.connect();
        var sql       = 'SELECT ' +
            'campanhas.id, ' +
            'campanhas.nome, ' +
            'campanhas.idade_inicio, ' +
            'campanhas.idade_final, ' +
            'campanhas.id_tipo_vacina, ' +
            'campanhas.cidade, ' +
            'campanhas.uf, ' +
            'campanhas.descricao ' +
            'FROM campanhas WHERE 1=1 ';

        if(input.tipo != undefined && input.tipo) {
            const whereTipo = 'AND id_tipo_vacina=? ';
            sql = sql.concat(whereTipo);
            valuesForSQLParameters.push(input.tipo);
        }

        if(input.idade_inicio != undefined && input.idade_inicio) {
            const whereIdadeInicio = 'AND idade_inicio BETWEEN ? AND ? ';
            sql = sql.concat(whereIdadeInicio);
            // We considerer that campanhas are always within a 10 years range
            valuesForSQLParameters.push(input.idade_inicio, input.idade_inicio + 10);
        }

        if(input.idade_final != undefined && input.idade_final) {
            const whereIdadeFinal = 'AND idade_final<=? ';
            sql = sql.concat(whereIdadeFinal);
            valuesForSQLParameters.push(input.idade_final);
        }

        if(input.cidade != undefined && input.cidade) {
            const whereCidade = 'AND cidade=? ';
            sql = sql.concat(whereCidade);
            valuesForSQLParameters.push(input.cidade);
        }

        if(input.uf != undefined && input.uf) {
            const whereUF = 'AND uf=? ';
            sql = sql.concat(whereUF);
            valuesForSQLParameters.push(input.uf);
        }

        const orderBy = 'ORDER BY dt_atualizacao DESC';
        sql = sql.concat(orderBy);

        const [rows] = await conn.query(sql, valuesForSQLParameters);
        return await rows;
    }catch(error){
        console.log(error);
    }
}

async function insertCampanha(campanha) {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'INSERT INTO campanhas(nome, idade_inicio, idade_final, id_tipo_vacina, cidade, uf, descricao) VALUES (?,?,?,?,?,?,?);';
        const values    = [
            campanha.nome,
            campanha.idade_inicio,
            campanha.idade_final,
            campanha.id_tipo_vacina,
            campanha.cidade,
            campanha.uf,
            campanha.descricao
        ];
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function updateCampanha(id, campanha) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'UPDATE campanhas ' +
            'SET nome=?, ' +
            'idade_inicio=?, ' +
            'idade_final=?, ' +
            'id_tipo_vacina=?, ' +
            'cidade=?, ' +
            'uf=?, ' +
            'descricao=? ' +
            'WHERE id=?';

        const values = [
            campanha.nome,
            campanha.idade_inicio,
            campanha.idade_final,
            campanha.id_tipo_vacina,
            campanha.cidade,
            campanha.uf,
            campanha.descricao,
            id
        ];
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function deleteCampanha(id) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'DELETE FROM campanhas WHERE id=?';
        return await conn.query(sql, [id]);
    }catch(error){
        console.log(error);
    }
}

module.exports = {
    selectCampanhas,
    selectCampanhaById,
    searchCampanhas,
    insertCampanha,
    updateCampanha,
    deleteCampanha
};