require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:leprosorium.db"

class Post < ActiveRecord::Base
	#has_many :comments, :foreign_key => "postID"
	validates :creator, presence: true, length: { minimum: 3 }
	validates :body, presence: true	
end

class Comment < ActiveRecord::Base
	#belongs_to :posts, :foreign_key => "postID"
	# validates :name, presence: true, length: { minimum: 3 }
	# validates :phone, presence: true
	# validates :datestamp, presence: true
	# validates :color, presence: true	
end

# before do
# 	@posts = Post.all
# end

get '/' do
	@posts = Post.order('created_at DESC')
	
 	erb :index			
 end

# обработчик get-запроса /new
# (браузер получает страницу с сервера)

get '/new' do
	@c = Post.new
	erb :new
end


post '/new' do
		
	
	
	@c = Post.new params[:post]
	if @c.save
		erb "<h2>Спасибо, за пост!</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :new
	end
end

# вывод информации о посте

get '/details/:post_id' do

 	post_id = params[:post_id]

 	@row = Post.find(post_id)
# 	# получаем список постов
# 	# (у нас будет только один пост)
# 	results = @db.execute 'select * from Posts where id = ?', [post_id]
	
# 	# выбираем этот один пост в переменную @row
# 	@row = results[0]

# 	# выбираем комментарии для нашего поста
	@koment = Comment.find_by(postID: post_id)
	# 	@comments = @db.execute 'select * from Comments where post_id = ? order by id', [post_id]
	
# 	# возвращаем представление details.erb
 	erb :details
 end

# # обработчик post-запроса /details/...
# # (браузер отправляет данные на сервер, мы их принимаем) 

 post '/details/:post_id' do
	
# 	# получаем переменную из url'a
 	post_id = params[:post_id]
 	comment = params[:comment]
# 	# получаем переменную из post-запроса
 	

 	@c = Comment.new params[:comment]
 	@c.postID = post_id
 	@c.save
	
	
# 	# сохранение данных в БД

# 	@db.execute 'insert into Comments
# 		(
# 			content,
# 			created_date,
# 			post_id
# 		)
# 			values
# 		(
# 			?,
# 			datetime(),
# 			?
# 		)', [content, post_id]

# 	# перенаправление на страницу поста

 	redirect to('/details/' + post_id)
 end