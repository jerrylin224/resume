require "sinatra"
require "sinatra/content_for"
require "tilt/erubis"
require "sinatra/reloader"
require 'pony'

configure do
  enable :sessions
  set :session_secret, "secret"
  set :erb, escape_html: true
end

get '/' do
  erb :index
end

post "/contact" do
  Pony.mail(
    :from => params[:name] + "<" + params[:email] + ">",
    :to => 'pk60905@gmail.com',
    :subject => params[:name] + " has contacted you",
    :body => "收到來自這個信箱地址的來信#{params[:email]}，內容是： " + params[:message],
    :via => :smtp,
    :via_options => { 
      :address              => 'smtp.gmail.com', 
      :port                 => '587', 
      :enable_starttls_auto => true, 
      :user_name            => 'pk60905', 
      :password             => 'pkjig1234', 
      :authentication       => :plain, 
      :domain               => 'localhost.localdomain'
    })
  redirect '/thank_you' 
end


get '/thank_you' do
  erb :thank_you
end