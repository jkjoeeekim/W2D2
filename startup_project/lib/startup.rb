require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        salaries.keys.include?(title)
    end

    def >(startup)
        self.funding > startup.funding
    end

    def hire(employee_name, title)
        if valid_title?(title)
            employee = Employee.new(employee_name, title)
            employees << employee
        else
            raise "Title is invalid"
        end
    end

    def size
        employees.length
    end

    def pay_employee(employee)
        salary = salaries[employee.title]
        if funding > salary
            employee.pay(salary)
            @funding -= salary
        else
            raise "Insufficient Minerals"
        end
    end

    def payday
        employees.each { |employee| pay_employee(employee) }
    end

    def average_salary
        salaries_array = []
        employees.each { |employee| salaries_array << salaries[employee.title] }
        salaries_array.sum / salaries_array.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each { |title, salary| @salaries[title] = salary unless @salaries.keys.include?(title) }
        startup.employees.each { |employee| @employees << employee }
        startup.close
    end
end
