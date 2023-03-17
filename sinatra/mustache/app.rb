require "sinatra/mustache"

get "/" do
    @bookmarks = get_all_bookmarks
    mustache :bookmark_list # renders views/bookmark_list.mustache
end

