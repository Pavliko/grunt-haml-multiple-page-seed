require "rubygems"
require "sinatra/base"

class MyApp < Sinatra::Base

  get '/test.js' do
    content_type :js
    "#{params[:callback]}('HELLO JSONP');"
  end

end
