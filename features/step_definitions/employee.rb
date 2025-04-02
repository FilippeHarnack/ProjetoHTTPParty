require 'httparty'

Dado('que o usuario consulte informacoes de funcionario') do
  @get_url = 'http://dummy.restapiexample.com/api/v1/employees'
end  

Quando('ele realizar a pesquisa') do
  @list_employee = HTTParty.get(@get_url)
end

Então('uma lista de funcionarios deve retornar') do
  expect(@list_employee.code).to eq(200)
  expect(@list_employee.message).to eq('OK')
end

Dado('que o usuario cadastre um novo funcionario') do
  @post_url = 'http://dummy.restapiexample.com/api/v1/create'
end


Quando('ele enviar as informacoes do funcionario') do
  @create_employee = HTTParty.post(@post_url, 
    headers: { 'Content-Type' => 'application/json' },
    body: {
      "id": 27,
      "employee_name": "Tony",
      "employee_salary": 420800,
      "employee_age": 30,
      "profile_image": ""
    }.to_json
  )
  
  puts @create_employee
end


Então('esse funcionario sera cadastrado') do
  expect(@create_employee.code).to eql(200)
  expect(@create_employee.message).to eql('OK')
  expect(@create_employee['status']).to eql('success')
  expect(@create_employee['message']).to eql('Successfully! Record has been added.')
  expect(@create_employee['data']['employee_name']).to eql('Tony')
  expect(@create_employee['data']['employee_salary']).to eql(420800)
  expect(@create_employee['data']['employee_age']).to eql(30)
end


Dado('que o usuario altere uma informacao de funcionario') do
  @put_url = 'http://dummy.restapiexample.com/api/v1/update/27'
end


Quando('ele enviar as novas informacoes') do
  headers = { "Content-Type" => "application/json" } 

  @update_employee = HTTParty.put(@put_url, 
    body: {
      "employee_name": "Tony Stark",
      "employee_salary": 500000,
      "employee_age": 40
    }.to_json,
    headers: headers # ✅
  )

  puts @update_employee
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
