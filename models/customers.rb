require_relative('../db/sql_runner')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = 'INSERT INTO customers(name, funds)
    VALUES ($1, $2)
    RETURNING id'
    values = [@name, @funds]
    performer = SqlRunner.run(sql, values).first
    @id = performer['id'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def self.all
    sql = 'SELECT * FROM customers'
    customers = SqlRunner.run(sql)
    return customers.map { |customer| Customer.new(customer)  }
  end

  def update
    sql = 'UPDATE customers
    SET name = $1, funds = $2
    WHERE id = $3'
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films
    sql = 'SELECT films.*
          FROM films
          INNER JOIN tickets
          ON tickets.film_id = films.id
          WHERE customer_id = $1'
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map {|film| Film.new(film)}
  end


end
