require "sinatra"
require "data_mapper"
require_relative "bookmark"
require "dm-serializer"

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/bookmarks.db")
DataMapper.finalize.auto_upgrade!

get "/bookmarks/:id" do
  id = params[:id]
  bookmark = Bookmark.get(id)

  if bookmark
    content_type :json
    bookmark.to_json
  else
    [404, "bookmark #{id} not found"]
  end
end

put "/bookmarks/:id" do
  id = params[:id]
  bookmark = Bookmark.get(id)

  if bookmark
    input = params.slice "url", "title"
    if bookmark.update input
      204 # No Content
    else
      400 # Bad Request
    end
  else
    [404, "bookmark #{id} not found"]
  end
end

delete "/bookmarks/:id" do
  id = params[:id]
  bookmark = Bookmark.get(id)
  if bookmark
    if bookmark.destroy
      200 # OK
    else
      500 # Internal Server Error
    end
  else
    [404, "bookmark #{id} not found"]
  end
end

def get_all_bookmarks
  Bookmark.all(:order => :title)
end

get "/bookmarks" do
  content_type :json
  get_all_bookmarks.to_json
end

post "/bookmarks" do
  input = params.slice "url", "title"
  bookmark = Bookmark.new input
  if bookmark.save
    # Created
    [201, "/bookmarks/#{bookmark['id']}"]
  else
    400 # Bad Request
  end
end

class Hash
  def slice(*whitelist)
    whitelist.inject({}) {|result, key| result.merge(key => self[key])}
  end
end