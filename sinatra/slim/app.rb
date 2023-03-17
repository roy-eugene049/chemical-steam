require "slim"

get "/" do
    @bookmarks = get_all_bookmarks
    slim :bookmark_list # renders views/bookmark_list.slim
end