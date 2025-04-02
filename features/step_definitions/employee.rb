# encoding: utf-8
require 'httparty'
require_relative '../requests/employee_requests'
require 'faker'

Dado('que o usuario consulte informacoes de funcionario') do
  @getlist = Employee_Requests.new
end  

Quando('ele realizar a pesquisa') do
  @list_employee = @getlist.find_employee
end

Então('uma lista de funcionarios deve retornar') do
  expect(@list_employee.code).to eq(200)
  expect(@list_employee.message).to eq('OK')
end

Dado('que o usuario cadastre um novo funcionario') do
  @create_employee_request = Employee_Requests.new
  @name1 = Faker::Name.name
  @salary = Faker::Number.number(digits: 5)
  @age = Faker::Number.number(digits: 2)

  puts @name1
  puts @salary
  puts @age
end

Quando('ele enviar as informacoes do funcionario') do
  @create_employee = @create_employee_request.create_employee(@name1, @salary, @age)
  puts @create_employee
end

Então('esse funcionario sera cadastrado') do
  expect(@create_employee.code).to eql(200)
  expect(@create_employee.message).to eql('OK')
  expect(@create_employee['status']).to eql('success')
  expect(@create_employee['message']).to eql('Successfully! Record has been added.')
  expect(@create_employee['data']['employee_name']).to eql(@name1)
  expect(@create_employee['data']['employee_salary']).to eql(@salary)
  expect(@create_employee['data']['employee_age']).to eql(@age)
end

Dado('que o usuario altere uma informacao de funcionario') do
  @request = Employee_Requests.new
end

Quando('ele enviar as novas informacoes') do
  headers = { "Content-Type" => "application/json" }
  @put_url = 'http://dummy.restapiexample.com/api/v1/update/27' 

  @update_employee = HTTParty.put(@put_url, 
    body: {
      "employee_name": "Tony Stark",
      "employee_salary": 500000,
      "employee_age": 40
    }.to_json,
    headers: headers
  )

  if @update_employee.headers['content-type']&.include?('application/json')
    puts @update_employee
  else
    puts "Erro: A resposta da API não é JSON. Recebido: #{@update_employee.body}"
  end
end

Então('as informacoes serao alteradas') do
  expect(@update_employee.code).to eq(200)
  expect(@update_employee.message).to eq('OK')
  expect(@update_employee['status']).to eq('success')
  expect(@update_employee['message']).to eq('Successfully! Record has been updated.')
  expect(@update_employee['data']['employee_name']).to eq('Tony Stark')
  expect(@update_employee['data']['employee_salary']).to eq(500000)
  expect(@update_employee['data']['employee_age']).to eq(40)
end

Dado('que o usuario consulte informacoes de funcionario') do
  @request = Employee_Requests.new
end  

Quando('ele realizar a pesquisa') do
  employees = @request.find_employee
  if employees['data'] && !employees['data'].empty?
    @delete_employee = @request.delete_employee(employees['data'][0]['id'])
  else
    raise "Nenhum funcionário encontrado para deletar"
  end
end

Então('uma lista de funcionarios deve retornar') do
  expect(@delete_employee.code).to eq(200)
  expect(@delete_employee.message).to eq('OK')
  expect(@delete_employee['status']).to eq('success')
  expect(@delete_employee['message']).to eq('Successfully! Record has been deleted')
end