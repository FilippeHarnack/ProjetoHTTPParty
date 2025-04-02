# language: pt

Funcionalidade: Consulta de Funcionários
  Para obter informações sobre os funcionários cadastrados
  Como um usuário do sistema
  Eu desejo poder pesquisar funcionários na base de dados

  Cenário: Buscar informações de um funcionário
    Dado que o usuário deseja consultar a lista de funcionários
    Quando ele realizar a pesquisa
    Então o sistema deve retornar uma lista de funcionários
