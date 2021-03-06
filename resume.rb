require 'sinatra'
require 'sinatra/content_for'
require 'tilt/erubis'
require 'sinatra/reloader' if development?
require 'pony'
require 'sendgrid-ruby'
include SendGrid

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, escape_html: true
end

get '/' do
  @skill = {
    'HTML5' => ['html5', 'my-sixty'],
    'CSS3' => ['css3', 'my-thirty'],
    'Ruby' => ['ruby', 'my-fiftyfive'],
    'JavaScript' => ['javascript', 'my-twentyfive'],
    'PSQL' => ['psql', 'my-fiftyfive'],
    'jQuery' => ['jquery', 'my-twentyfive']
  }

  erb :index
end

post '/contact' do
  Pony.mail(
    from: params[:name] + '<' + params[:email] + '>',
    to: 'pk60905@gmail.com',
    subject: params[:name] + '想聯絡你',
    body: '收到來自 ' + params[:email] + '的來信，內容是： ' + params[:message],
    via: :smtp,
    via_options: {
      address:               'smtp.sendgrid.net',
      port:                  '587',
      enable_starttls_auto:  true,
      user_name:             ENV['SENDGRID_USERNAME'],
      password:              ENV['SENDGRID_PASSWORD'],
      authentication:        :plain,
      domain:                'heroku.com'
    }
  )
  redirect '/thank_you'
end

get '/thank_you' do
  erb :thank_you
end
