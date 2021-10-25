mysqlDb = require('../../mysql_connection');

async function selectHistoricoVacinacao(cpf) {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'SELECT ' +
            'carteira_vacina_historico.id, ' +
            'carteira_vacina_historico.cpf, ' +
            'carteira_tipo_vacina.descricao as tipo_vacina_descricao, ' +
            'carteira_vacina_historico.dt_aplicacao, ' +
            'carteira_tipo_dose.descricao as tipo_dose_descricao, ' +
            'carteira_vacina_historico.lote, ' +
            'carteira_vacina_historico.codigo, ' +
            'carteira_vacina_historico.nome_aplicador, ' +
            'carteira_vacina_historico.reg_profissional, ' +
            'carteira_vacina_historico.unidade_saude, ' +
            'carteira_vacina_historico.cidade, ' +
            'carteira_vacina_historico.uf, ' +
            'carteira_vacina_historico.obs ' +
            'FROM carteira_vacina_historico, ' +
            'carteira_tipo_dose, ' +
            'carteira_tipo_vacina ' +
            'WHERE carteira_tipo_vacina.id = carteira_vacina_historico.id_tipo_vacina ' +
            'AND carteira_tipo_dose.id = carteira_vacina_historico.id_tipo_dose ' +
            'AND carteira_vacina_historico.cpf=?';

        const values = [
            cpf
        ];
        const [rows] = await conn.query(sql, values);
        return await rows;

    }catch(error){
        console.log(error);
    }
}

async function selectHistoricoVacinacaoByIDAndCPF(id, cpf) {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'SELECT ' +
            'carteira_vacina_historico.id, ' +
            'carteira_vacina_historico.cpf, ' +
            'carteira_tipo_vacina.descricao as tipo_vacina_descricao, ' +
            'carteira_vacina_historico.dt_aplicacao, ' +
            'carteira_tipo_dose.descricao as tipo_dose_descricao, ' +
            'carteira_vacina_historico.lote, ' +
            'carteira_vacina_historico.codigo, ' +
            'carteira_vacina_historico.nome_aplicador, ' +
            'carteira_vacina_historico.reg_profissional, ' +
            'carteira_vacina_historico.unidade_saude, ' +
            'carteira_vacina_historico.cidade, ' +
            'carteira_vacina_historico.uf, ' +
            'carteira_vacina_historico.obs ' +
            'FROM carteira_vacina_historico, ' +
            'carteira_tipo_dose, ' +
            'carteira_tipo_vacina ' +
            'WHERE carteira_tipo_vacina.id = carteira_vacina_historico.id_tipo_vacina ' +
            'AND carteira_tipo_dose.id = carteira_vacina_historico.id_tipo_dose ' +
            'AND carteira_vacina_historico.id=? AND carteira_vacina_historico.cpf=?';

        const values = [
            id,
            cpf
        ];
        const [rows] = await conn.query(sql, values);
        return await rows;

    }catch(error){
        console.log(error);
    }
}

async function insertHistoricoVacinacao(historicoVacinacao) {
    try{
        const conn      = await mysqlDb.connect();
        const sql       = 'INSERT INTO carteira_vacina_historico(' +
            'id_tipo_vacina, ' +
            'dt_aplicacao, ' +
            'id_tipo_dose, ' +
            'lote, ' +
            'codigo, ' +
            'nome_aplicador, ' +
            'reg_profissional, ' +
            'unidade_saude, ' +
            'cidade, ' +
            'uf, ' +
            'obs' +
            ') VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);';
        const values    = [
            historicoVacinacao.id_tipo_vacina,
            historicoVacinacao.dt_aplicacao,
            historicoVacinacao.id_tipo_dose,
            historicoVacinacao.lote,
            historicoVacinacao.codigo,
            historicoVacinacao.nome_aplicador,
            historicoVacinacao.reg_profissional,
            historicoVacinacao.unidade_saude,
            historicoVacinacao.cidade,
            historicoVacinacao.uf,
            historicoVacinacao.obs
        ];
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function updateHistoricoVacinacao(id, cpf, historicoVacinacao) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'UPDATE carteira_vacina_historico ' +
            'SET id_tipo_vacina=?, ' +
            'dt_aplicacao=?, ' +
            'id_tipo_dose=?, ' +
            'lote=?, ' +
            'codigo=?, ' +
            'nome_aplicador=?, ' +
            'reg_profissional=?, ' +
            'unidade_saude=?, ' +
            'cidade=?, ' +
            'uf=?, ' +
            'obs=?' +
            ' WHERE cpf=? AND id=?';
        const values = [
            historicoVacinacao.id_tipo_vacina,
            historicoVacinacao.dt_aplicacao,
            historicoVacinacao.id_tipo_dose,
            historicoVacinacao.lote,
            historicoVacinacao.codigo,
            historicoVacinacao.nome_aplicador,
            historicoVacinacao.reg_profissional,
            historicoVacinacao.unidade_saude,
            historicoVacinacao.cidade,
            historicoVacinacao.uf,
            historicoVacinacao.obs,
            cpf,
            id
        ];
        return await conn.query(sql, values);
    }catch(error){
        console.log(error);
    }
}

async function deleteHistoricoVacinacao(id, cpf) {
    try {
        const conn = await mysqlDb.connect();
        const sql = 'DELETE FROM carteira_vacina_historico WHERE id=? AND cpf=?';
        return await conn.query(sql, [id, cpf]);
    }catch(error){
        console.log(error);
    }
}

module.exports = {
    selectHistoricoVacinacao,
    selectHistoricoVacinacaoByIDAndCPF,
    insertHistoricoVacinacao,
    updateHistoricoVacinacao,
    deleteHistoricoVacinacao
};