get '/' do
  erb :index, layout: false
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  
  @user = User.find_or_create_by_username(:username => @access_token.params[:screen_name], :oauth_token => @access_token.token, :oauth_secret => @access_token.secret)

  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  # at this point in the code is where you'll need to create your user account and store the access token
  
  erb :tweet
end

post '/:username/tweet' do
  @user = User.find_by_username(params[:username])
  job_id = @user.tweet(params[:tweet])
  return job_id
end

post '/:username/tweetlater' do
  @user = User.find_by_username(params[:username])
  job_id = @user.tweetlater(params[:tweet],params[:number])
  return job_id
end

get '/status/:job_id' do
 job_status = job_is_complete(params[:job_id])
 content_type :JSON
 {status: job_status}.to_json
end
  
