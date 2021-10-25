require('dotenv').config({path:'env/qa.env'});

const carteira_tipo_vacinas = [
    {
        descricao: 'BCG ID',
        pais: 'BRA'
    },
    {
        descricao: 'Hepatite B',
        pais: 'BRA'
    },
    {
        descricao: 'Rotavírus',
        pais: 'BRA'
    },
    {
        descricao: 'Tríplice Bacteriana  (DTPw, DTPa ou dTPa)',
        pais: 'BRA'
    },
    {
        descricao: 'Haemoplilus influenze tipo B',
        pais: 'BRA'
    },
    {
        descricao: 'Poliomielite (vírus inativos)',
        pais: 'BRA'
    },
    {
        descricao: 'Pneumocócica conjugada',
        pais: 'BRA'
    },
    {
        descricao: 'Meningocócica conjugada  C ou  ACWY',
        pais: 'BRA'
    },
    {
        descricao: 'Meningocócica B',
        pais: 'BRA'
    },
    {
        descricao: 'Poliomelite oral (vírus vivos atenuados)',
        pais: 'BRA'
    },
    {
        descricao: 'Influenza (gripe)',
        pais: 'BRA'
    },
    {
        descricao: 'Febre amarela',
        pais: 'BRA'
    },
    {
        descricao: 'Tríplice viral (sarampo, caxumba e rubéola)',
        pais: 'BRA'
    },
    {
        descricao: 'Varicela (catapora)',
        pais: 'BRA'
    },
    {
        descricao: 'Hepatite A ',
        pais: 'BRA'
    },
    {
        descricao: 'HPV',
        pais: 'BRA'
    },
    {
        descricao: 'Pneumocócica 23 valente',
        pais: 'BRA'
    },
    {
        descricao: 'Herpes zóster',
        pais: 'BRA'
    },
    {
        descricao: 'Dengue',
        pais: 'BRA'
    }
]; // TODO get tipo vacinas from DB
const UsuarioAcessoModel = require('../db/mysql/domains/usuario/usuario_acesso');
const TipoVacinaModel = require('../db/mysql/domains/vacina/tipo_vacina');
const HistoricoVacinaModel = require('../db/mysql/domains/carteira_medica_cidadao/historico_vacinas');
const CampanhaModel = require('../db/mysql/domains/campanha/campanhas');
const DadosPessoaisModel = require('../db/mysql/domains/carteira_medica_cidadao/dados_pessoais_cidadao');
const CidadeModel = require('../db/mysql/domains/localizacao/cidade');
const CidadaoDispositivo = require('../db/mysql/domains/messaging/cidadao_dispositivo');
const firebaseSDK = require('../services/firebase/oauth2_access_token');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');

// TODO Extract Query and Mutation for each Module we have
// Ex:. carteiraTipoVacionaResolver, dadosPessoaisCidadaoResolver, acessoUsuarioResolver, tipoDoseResolver, tipoSanguineoResolver, historicoVacinacaoResolver
const resolvers = {
    Query: {
        getCarteiraTipoVacinas: () => carteira_tipo_vacinas,
        getCarteiraTipoVacina: (_, {input}, ctx, info ) => {
            console.log(ctx);
            const result = carteira_tipo_vacinas.filter(tipo => tipo.descricao === input.descricao);
            return result;
        },
        obtenerUsuario: async (_, {token}, ctx) => {
            // Apollo has a global context that have access to headers information
            // This way we don't need to jwt.verify(token,...) anymore
            //return ctx.usuario;
            const usuarioCPF = await jwt.verify(token, process.env.SECRET_JWT);
            return usuarioCPF;
        },
        obtenerCidadoes: async() => {
            try{
                const cidadoes = await DadosPessoaisModel.selectTodosCidadoes();
                return cidadoes;
            }catch(error){
                console.log(error);
            }
        },
        obtenerCampanhas: async() => {
            try{
                const campanhas = await CampanhaModel.selectCampanhas();
                return campanhas;
            }catch(error){
                console.log(error);
            }
        },
        searchCampanhas: async(_, {input}) => {
            try{
                const campanhas = await CampanhaModel.searchCampanhas(input);
                return campanhas;
            }catch(error){
                console.log(error);
            }
        },
        obtenerCampanha: async(_, {id}) => {
            try{
                const campanha = await CampanhaModel.selectCampanhaById(id);
                return campanha[0];
            }catch(error){
                console.log(error);
            }
        },
        obtenerHistoricoVacinacao: async(_, {cpf}) => {
            try{
                const historicoVacinacao = await HistoricoVacinaModel.selectHistoricoVacinacao(cpf);
                return historicoVacinacao;
            }catch(error){
                console.log(error);
            }
        },
        obtenerDadosPessoais: async(_, {cpf}) => {
            try{
                const dadosPessoais = await DadosPessoaisModel.selectDadosPessoaisCidadao(cpf);
                return dadosPessoais[0];
            }catch(error){
                console.log(error);
            }
        },
        obtenerCidades: async() => {
            try {
                return await CidadeModel.selectCidades();
            } catch (error) {
                console.log(error);
            }
        },
        obtenerCidadesFilteredByUF: async(_, {uf}) => {
            try {
                return await CidadeModel.selectCidadesByUF(uf);
            } catch (error) {
                console.log(error);
            }
        },
        obtenerDispositosCidadaoParaCampanha: async(_, {input}) => {
            try{
                const {idade_inicio, idade_final, uf, municipio} = input;
                return await CidadaoDispositivo.selectAndroidDispositivosMatchAgeAndLocation(idade_inicio, idade_final, uf, municipio);
            } catch (error) {
                console.log(error);
            }
        }
    },
    Mutation: {
        novoUsuarioAcesso: async (_, {input}) => {
            // TODO apply SPR in this function, too many responsabilities!

            // Verify is user is registered
            const {cpf, email, senha, dt_nascimento, cidade, uf} = input;
            const isNewUsuario = await UsuarioAcessoModel.checkUsuarioExiste(cpf, email);
            if (isNewUsuario.length > 0) {
                throw new Error('Já existe um usuário cadastrado com esse cpf ou email.')
            }

            // Encrypt password
            const salt = await bcryptjs.genSalt(10);
            input.senha = await bcryptjs.hash(senha, salt);

            // Save to DB
            try {
                const result = await UsuarioAcessoModel.insertUsuarioAcesso(input);
                return result[0].rowsAffected;
            } catch (error) {
                throw new Error(error);
            }
        },
        novoCidadaoDispositivo: async(_, {input}) => {

          const {cpf, token, tipo} = input;

            const isNewDispositivo = await CidadaoDispositivo.selectCidadaoDispositivo(cpf, token);
            if (isNewDispositivo.length > 0) {
                return 'O dispositivo já está cadastrado.';
            }

          await CidadaoDispositivo.insertCidadaoDispositivo(input);
          return "Dispositivo cadastrado com sucesso!";
        },
        autenticarUsuario: async (_, {input}) => {
            const {cpf, senha} = input;

            const existeUsuario = await UsuarioAcessoModel.checkUsuarioExisteWithCPF(cpf);
            if (!existeUsuario[0]) {
                throw new Error('CPF ou senha inválida.');
            }

            const isPasswordCorrect = await bcryptjs.compare(senha, existeUsuario[0].senha);
            if (!isPasswordCorrect) {
                throw new Error('Senha inválida');
            }

            // Generate JWT token
            return {
                token: createToken(existeUsuario[0], process.env.SECRET_JWT, '24h'),
                email: existeUsuario[0].email,
                cpf: existeUsuario[0].cpf,
                nome: existeUsuario[0].nome
            }
        },
        novoTipoVacina: async (_, {input}) => {
            try {
                const result = await TipoVacinaModel.insertTipoVacina(input);
                return result[0].rowsAffected;
            } catch (error) {
                console.log(error);
            }
        },
        novoHistoricoVacinacao: async (_, {input}) => {
            try{
                const result = await HistoricoVacinaModel.insertHistoricoVacinacao(input);
                return result[0].rowsAffected;
            } catch (error) {
                console.log(error);
            }
        },
        novaCampanha: async (_, {input}) => {
          try {
              // Destruct Campanhas
              const {nome, idade_inicio, idade_final, cidade, uf} = input;
              const result = await CampanhaModel.insertCampanha(input);

              // Get all citizen devices that match campanha
              // TODO check here we're considering that all the campaings will have age limit
              // make it more flexible and add more parameters
              let devices = await CidadaoDispositivo.selectAndroidDispositivosMatchAgeAndLocation(
                  idade_inicio,
                  idade_final,
                  uf,
                  cidade
              );

              let message = `${nome}. Idade entre ${idade_inicio} a ${idade_final} em ${cidade} ,${uf}.Veja onde você pode vacinar.`;
              devices.map((device) => {
                  firebaseSDK.sendFcmMessage(firebaseSDK.buildToUniqueDeviceTokenMessage(
                      nome.toString(),
                      message.toString(),
                      device.dispositivo_token
                  ))
              });

              return result[0].rowsAffected;
          } catch (error) {
              console.log(error);
          }
        },
        eliminarCampanha: async(_, {id}) => {
            let campanha = await CampanhaModel.selectCampanhaById(id);

            if (!campanha) {
                throw new Error('Campanha nao encontrada');
            }

            await CampanhaModel.deleteCampanha(id)
            return "Campanha Eliminada!";
        },
        atualizarCampanha: async (_, {id, input}) => {

            let campanha = await CampanhaModel.selectCampanhaById(id);

            if (!campanha) {
                throw new Error('Campanha não encontrada');
            }

            campanha = await CampanhaModel.updateCampanha(id, input);
            return campanha;
        },
        atualizarDadosPessoais: async (_, {cpf, input}) => {
            let dadosPessoais = await DadosPessoaisModel.selectDadosPessoaisCidadao(cpf);

            if (!dadosPessoais) {
                throw new Error('Dados Pessoais não encontrados');
            }

            dadosPessoais = await DadosPessoaisModel.updateDadosPessoaisCidadao(cpf, input);
            return dadosPessoais;
        },
        atualizarHistoricoVacinacao: async (_, {id, cpf, input}) => {

            let historicoVacinacao = await HistoricoVacinaModel.selectHistoricoVacinacaoByIDAndCPF(id, cpf);

            if (!historicoVacinacao) {
                throw new Error('Historico de Vacinação não encontrado');
            }

            historicoVacinacao = await HistoricoVacinaModel.updateHistoricoVacinacao(id, cpf, input);
            return historicoVacinacao;
        },
        eliminarHistoricoVacinacao: async(_, {id, cpf}) => {
            let historicoVacinacao = await HistoricoVacinaModel.selectHistoricoVacinacaoByIDAndCPF(id, cpf);

            if (!historicoVacinacao) {
                throw new Error('Histórico de Vacinação não encontrado!');
            }

            await HistoricoVacinaModel.deleteHistoricoVacinacao(id, cpf);
            return "Histórico Vacinação eliminado!";
        },
    }
}

const createToken = (user, secretTokenKey, expiresIn) => {
    const { cpf, nome, email  } = user;
    return jwt.sign({ cpf, nome, email }, secretTokenKey, { expiresIn })
}

module.exports = resolvers;