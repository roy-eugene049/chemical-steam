require "sinatra/respond_with"


get "/" do
    @bookmarks = get_all_bookmarks
    erb :bookmark_list
end

get "/bookmarks" do
    @bookmarks = get_all_bookmarks
    respond_with :bookmark_list, @bookmarks
  end

get "/bookmark/new" do
    erb :bookmark_form_new
end

helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end

