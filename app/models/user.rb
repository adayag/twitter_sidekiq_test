class User < ActiveRecord::Base
  has_many :tweets

  def create_client
    Twitter::Client.new(
      :oauth_token => self.oauth_token,
      :oauth_token_secret => self.oauth_secret
    )
  end

  def tweet(status)
    tweet = tweets.create!(:text => status)
    TweetWorker.perform_async(tweet.id)
  end

  def tweetlater(status, number)
    tweet = tweets.create!(:text => status)
    time = number.to_i
    TweetWorker.perform_in(time.minutes, tweet.id)
  end
end
