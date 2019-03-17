require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')

require('pry')

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new( 'name' => 'John', 'funds' => 100)
customer2 = Customer.new( 'name' => 'James', 'funds' => 95)
customer3 = Customer.new( 'name' => 'Jack', 'funds' => 67)
customer4 = Customer.new( 'name' => 'Jill', 'funds' => 134)
customer1.save
customer2.save
customer3.save
customer4.save

film1 = Film.new( 'title' => 'Avengers', 'price' => 18)
film2 = Film.new( 'title' => 'Batman', 'price' => 14)
film1.save
film2.save

film1.title = 'Captain Marvel'
film1.update

ticket1 = Ticket.new( 'customer_id' => customer1.id, 'film_id' => film1.id)
ticket2 = Ticket.new( 'customer_id' => customer2.id, 'film_id' => film2.id)
ticket3 = Ticket.new( 'customer_id' => customer3.id, 'film_id' => film2.id)
ticket4 = Ticket.new( 'customer_id' => customer4.id, 'film_id' => film1.id)
ticket1.save
ticket2.save
ticket3.save
ticket4.save

Ticket.all
Film.all
Customer.all

binding.pry
nil
