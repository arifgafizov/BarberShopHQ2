require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

# создаем сущность
set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	# Валидация на пустое значение
	# аналогично :presence => true
	validates :name, presence: true
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	# Вывод барберов на экран с помощью ActiveRecord
	@barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do
	# создаем пустой объект чтоб переменная @c определилась при get запросе
	@c = Client.new
	erb :visit
end

post '/visit' do

	# Принимаем хеш с данными из вида visit
	@c = Client.new params[:client]
	if @c.save
		erb "<h2>Thank you, you signed up </h2>"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end

	# сохранение клиентов в БД на странице visit с помощью ActiveRecord
	#clients = Client.create(name: @username, phone: @phone, datestamp: @datetime, barber: @barber, color: @color)

	end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@contact_email = params['contact_email']
	@message = params['message']

	# сохранение контактов в БД на странице contacts с помощью ActiveRecord
	c = Contact.new
	c.contact_email = @contact_email
	c.message = @message
	c.save

	erb :contacts
end
