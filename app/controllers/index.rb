get '/' do
  if session[:id]
   erb :index
  else
    redirect '/signin'
  end
end

get '/signin' do
  #this will take the user to a sign in and sign up page... so it will be for both
  erb :sign_in
end

post '/users' do
  #users are created here
  #this is sign_up
  @user = User.create(params[:user])
  if @user
    session[:id] = @user.id
  end
  redirect '/'
end

post '/session' do
  @user = User.find_by(username: params[:user]['username'])
  if @user.password == params[:user]['password']
    session[:id] = @user.id
    redirect '/'
  else
    redirect '/signin'
  end
end

get '/logout' do
  session.clear
  redirect '/signin'
end

get '/search' do
  api = YouTube::Client.new
  hash = api.get_search_results("corgi #{params['search']}")
  snippets = Filter.find_snippet(hash)
  #these are all arrays
  @video_ids = Filter.video_id(hash)
  @titles = FilterSnippet.find_all_titles(snippets)
  @descriptions = FilterSnippet.find_all_descriptions(snippets)
  @thumbnails = FilterSnippet.find_all_thumbnails(snippets)
  erb :_display_snippet, :layout => false
end

post '/favorite/new' do
  puts "*******"
  p params
  p params.key(nil)
  p id = session[:id]
  favorite = Favorite.create(url: params.key(nil), user_id: id)
  erb :_woof, :layout => false
end

get '/favorite' do
  if session[:id]
    @user = User.find(session[:id])
    @favorites=@user.favorites #this is an array
    erb :favorite
  else
    redirect '/signin'
  end
end