# language: pt
Funcionalidade: Gerenciamento de Funcionários
  Para obter informações sobre os funcionários
  Como um usuário do sistema
  Eu desejo poder consultar e cadastrar funcionários

  Cenário: Buscar informações de um funcionário
    Dado que o usuario deseja consultar a lista de funcionarios
    Quando ele realizar a pesquisa
    Então uma lista de funcionarios deve ser retornada

  @cenario_dois
Cenário: Cadastrar funcionario
    Dado que o usuario cadastre um novo funcionario
    Quando ele enviar as informacoes do funcionario
    Então esse funcionario sera cadastrado

