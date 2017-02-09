require "sinatra"
require 'pony'
require "sinatra/content_for"
require "tilt/erubis"
require "sinatra/reloader"
require "mail"
require "pry"

configure do
  enable :session
  set :session_secret, "secret"
  set :erb, escape_html: true
end

get '/' do
  erb :index
end




# Mail.defaults do
#   retriever_method :pop3, :address    => "pk60905@gmail.com",
#                           :port       => 995,
#                           :user_name  => 'pk60905@gmail.com',
#                           :password   => 'pkjig1234',
#                           :enable_ssl => true
# end
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
  redirect '/success' 
end

  # session[:email] = 'work?'

  # Pony.options = {
  #     :via_options => {
  #       :address        => 'smtp.gmail.com',
  #       :port           => '587',    
  #       :user_name      => 'pk60905@gmail.com',
  #       :password       => 'pkjig1234',
  #       :authentication => :plain # :plain, :login, :cram_md5, no auth by default
  #       # :domain         => "127.0.0.1" # the HELO domain provided by the client to the server
  #     }
  #   }

    # Pony.mail({
    #   :to => 'pk60905@gmail.com',
    #   :subject => 'ji',
    #   :via => :smtp,
    #   :from => 'pk60905@hotmail.com'
    # })

    # erb :index


        # name = params[:name]
        # mail = params[:mail]
        # body = params[:body]

        # Pony.mail(:to => 'pk60905@hotmail.com', :from => "#{mail}", :subject => "art inquiry from #{name}", :body => "#{body}")
# }



get '/success' do
  "Thanks for your email. We'll be in touch soon."
end