require 'httparty'

class Employee_Requests
  include HTTParty
  base_uri 'http://dummy.restapiexample.com/api/v1'
  format :json
  headers 'Content-Type' => 'application/json'

  def find_employee
    self.class.get('/employees')
  end

  def create_employee(name, salary, age)
    self.class.post('/create', body: {
      "employee_name": name,
      "employee_salary": salary,
      "employee_age": age,
      "profile_image": ""
    }.to_json)
  end

  def update_employee(id, name, salary, age)
    self.class.put("/update/#{id}", body: {
      "employee_name": name,
      "employee_salary": salary,
      "employee_age": age,
      "profile_image": ""
    }.to_json)
  end

  def delete_employee(id)
    self.class.delete("/delete/#{id}")
  end
end
