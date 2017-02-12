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
  from = Email.new(email: 'pk60905@gmail.com')
  subject = 'Hello World from the SendGrid Ruby Library!'
  to = Email.new(email: 'pk60905@gmail.com')
  content = Content.new(type: 'text/plain', value: 'Hello, Email!')
  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers
  )
  redirect '/thank_you'
end

get '/thank_you' do
  erb :thank_you
end
