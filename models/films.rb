require_relative('../db/sql_runner')

class Film
  attr_reader :id, :price
  attr_accessor :title

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = 'INSERT INTO films(title, price)
    VALUES ($1, $2)
    RETURNING id'
    values = [@title, @price]
    performer = SqlRunner.run(sql, values).first
    @id = performer['id'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM films'
    SqlRunner.run(sql)
  end

  def self.all
    sql = 'SELECT * FROM films'
    films = SqlRunner.run(sql)
    return films.map { |film| Film.new(film)  }
  end

  def update
    sql = 'UPDATE films
    SET title = $1, price = $2
    WHERE id = $3'
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers
    sql = 'SELECT customers.*
          FROM customers
          INNER JOIN tickets
          ON tickets.customer_id = customers.id
          WHERE film_id = $1'
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map {|customer| Customer.new(customer)}
  end

end
