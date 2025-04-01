require 'httparty'

Dado('que o usuário deseja consultar a lista de funcionários') do
  @get_url = 'http://dummy.restapiexample.com/api/v1/employees'
end

Quando('ele realizar a pesquisa') do
  @list_employee = HTTParty.get(@get_url)
end

Então('o sistema deve retornar uma lista de funcionários') do
  expect(@list_employee.code).to eq(200)
  expect(@list_employee.message).to eq('OK')
  expect(@list_employee.parsed_response['data']).not_to be_empty
end
