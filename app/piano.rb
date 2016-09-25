$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require 'bundler/setup'

require 'sinatra/base'
require 'data_mapper'
require 'kramdown'
require 'omniauth-twitter'
require 'tilt/erb'

require 'config'
require 'helpers'

require 'models/user'
require 'models/post'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/piano.db")
DataMapper.finalize.auto_upgrade!

module Piano
  class App < Sinatra::Base

    # Include Piano helpers
    include Piano::Helpers

    configure do
      enable :sessions
      set    :session_secret, Piano.config.auth_token

      use OmniAuth::Builder do
        provider :twitter, Piano.config.twitter_key, Piano.config.twitter_secret
      end
    end

    before do
      if current_user
        @login = current_user
      else
        redirect '/login' unless request.path_info =~ /\/login/ ||
                                 request.path_info =~ /\/auth/ ||
                                 request.path_info =~ /\/$/
      end
    end

    get '/login' do
      redirect to("/auth/twitter")
    end

    get '/auth/twitter/callback' do
      if ['omniauth.auth'].nil?
        halt(401,'Not Authorized')
      end

      user = User.first(:uid => env['omniauth.auth'][:uid])

      if user.nil?
        user = User.new
        user.uid = env['omniauth.auth']['uid']
        user.provider = env['omniauth.auth']['provider']
        user.name = env['omniauth.auth']['info']['name']
        user.save
      end

      session[:user] = user

      redirect to("/")
    end

    get '/auth/failure' do
      params[:message]
    end

    get '/logout' do
      session[:user] = nil

      redirect to("/")
    end

    get '/' do
      @username = current_user ? session[:user][:name] : nil

      @posts = Post.all(:order => [:id.desc], :limit => 20)
      erb :home
    end

    get '/new' do
      @username = current_user ? session[:user][:name] : nil

      erb :new
    end

    post '/new' do
      post = Post.new
      post.user_id = session[:user][:id]
      post.title = 'Test'
      post.content = params[:content]
      post.created_at = Time.now
      post.updated_at = Time.now
      post.save

      redirect "/#{post.id}"
    end

    get %r{^\/([0-9]+)$} do |post_id|
      @username = current_user ? session[:user][:name] : nil

      post = Post.get post_id
      content = Kramdown::Document.new(post.content)
      @post = post

      erb :show, :locals => {:content => content.to_html }
    end

    get %r{^\/([0-9]+)/edit$} do |post_id|
      @username = current_user ? session[:user][:name] : nil

      @post = Post.get post_id

      erb :edit
    end

    post %r{^\/([0-9]+)/edit$} do |post_id|
      post = Post.get post_id
      post.content = params[:content]
      post.updated_at = Time.now
      post.save

      redirect "/#{post_id}"
    end

    get %r{^\/([0-9]+)/delete$} do |post_id|
      @username = current_user ? session[:user][:name] : nil

      @post = Post.get post_id

      erb :delete
    end

    post %r{^\/([0-9]+)/delete$} do |post_id|
      post = Post.get post_id
      post.destroy

      redirect '/'
    end

    not_found do
      halt 404, 'Page not found.'
    end
  end
end
