#! /usr/bin/ruby -w

require 'open-uri'
require 'json'
require 'jsonpath'
require 'fileutils'

=begin
./img
./json
./tmp
./WebContent
./WebContent/img
./WebContent/img/album
./WebContent/img/album/covers
./WebContent/img/album/thumbs
./WebContent/img/artist
./WebContent/img/artist/covers
./WebContent/img/artist/thumbs
./WebContent/WEB-INF

=end


input_data = {
  "Black Sabbath"           => ["Sabotage"],
  "Mogwai"                  => ["Young Team"],
  "Bob Dylan"               => ["Blonde on Blonde"],
  "Pink Floyd"              => ["Animals"],
  "Led Zeppelin"            => ["Physical Graffiti"],
  "ABBA"                    => ["Arrival"],
  "Van Morrison"            => ["Moondance",
                                "Astral Weeks"],
  "Miles Davis"             => ["Kind of Blue"],
  "Mastodon"                => ["Leviathan"],
  "Ween"                    => ["The Mollusk"],
  "The Smiths"              => ["Hatful of Hollow"],
  "Flight of the Conchords" => ["Flight of the Conchords"],
  "Punch Brothers"          => ["The Phosphorescent Blues"],
  "John Coltrane"           => ["Giant Steps"],
  "Radiohead"               => ["Kid A",
                                "OK Computer"],
  "Built to Spill"          => ["Keep It Like a Secret"],
  "Wire"                    => ["Pink Flag"],
  "Thelonious Monk"         => ["Brilliant Corners"],
  "Run the Jewels"          => ["Run the Jewels"],
  "Roxy Music"              => ["Stranded"],
  "ZZ Top"                  => ["Tres Hombres"],
  "Allman Brothers Band"    => ["Eat a Peach"],
  "Frank Zappa"             => ["Apostrophe"],
  "Pixies"                  => ["Doolittle"],
  "The Rolling Stones"      => ["Sticky Fingers",
                                "Some Girls",
                                "Let It Bleed"],
  "The Beatles"             => ["Rubber Soul"],
  "Brian Eno"               => ["Here Come the Warm Jets"],
  "Guided by Voices"        => ["Bee Thousand",
                                "Alien Lanes"],
  "Aesop Rock"              => ["The Impossible Kid",
                                "Labor",
                                "None Shall Pass"],
}

class ArtistInfo
  attr_accessor :mbID, :name, :sort_name
  attr_accessor :image_path, :thumb_path, :biography, :url

  def initialize(mbID, name, sort_name)
    @name = name
    @mbID = mbID
    @sort_name = sort_name

    @image_path = ""
    @thumb_path = ""
    @biography = "#{name} hails from his/her/their very own hometown. The interesting thing about #{name}'s music is that it is interesting. There are probably many more things you can learn about #{name}. Try Googling!"
    @url = "https://en.wikipedia.org/wiki/" + name.gsub(" ", "_")
  end

  def to_s
    "[#{@name}:#{@mbID}]"
  end

  def to_hash
    to_h
  end

  def to_h
    # "artists": [
    return  {
        "name"      => @name,
        "sortName"  => @sort_name,
        "image"     => @image_path,
        "thumbnail" => @thumb_path,
        "bioText"   => @biography,
        "link"      => @url,
        "id"        => @mbID
      }
  end
end

class AlbumInfo
  attr_accessor :title,
                :artist,
                :year,
                :genre,
                :tracks,
                :rating,
                :image_path,
                :thumb_path,
                :mbID

  def initialize()
    @title      = ""
    @artist     = "",
    @year       = "",
    @genre      = "",
    @tracks     = "",
    @rating     = "",
    @image_path = "",
    @thumb_path = "",
    @mbID       = ""
  end

  def to_hash
    to_h
  end

  def to_h
    return {
      "title"          => @title,
      "artist"         => @artist,
      "year"           => @year,
      "genre"          => @genre,
      "tracks"         => @tracks,
      "rating"         => @rating,
      "compilation"    => false,
      "coverImage"     => @image_path,
      "coverThumbnail" => @thumb_path,
      "id"             => @mbID
    }
  end
end

def setupDirs(dest_dir = ".")
  dirs = [
    "#{dest_dir}/img",
    "#{dest_dir}/json",
    "#{dest_dir}/WebContent/img/album/covers",
    "#{dest_dir}/WebContent/img/album/thumbs",
    "#{dest_dir}/WebContent/img/artist/covers",
    "#{dest_dir}/WebContent/img/artist/thumbs",
    "#{dest_dir}/WebContent/WEB-INF",
  ]

  dirs.each do |d|
    if(!File.exists?(d)) then
      FileUtils.mkdir_p(d)
    end
  end
end

def grab_uri(uri, dest_file, mode)
  puts "grabbing: " + uri
  #releaseID="76df3287-6cda-33eb-8e9a-044b5e15ffdd"
  #uri="http://coverartarchive.org/release/#{releaseID}/front"
  # mode = "wb"
  begin
    src_data = open(uri,
       "User-Agent" => "RecordBin/0.0.1 ( josh.given@gmail.com )")

    File.open(dest_file, mode) do |outs|
      outs.write(src_data.read())
    end
  rescue
    puts "grab_uri: failed"
  end

  sleep 2
end


setupDirs(".")

artists = {}
albums = []
i = 1000

# "http://musicbrainz.org/ws/2/artist/?The%20Hawk%20Is%20Howling&query=artist:%22Van%20Morrison%22"
# "http://musicbrainz.org/ws/2/artist/?limit=1&artist:%22Van%20Morrison%22"
input_data.keys.each do |input_artist|
  out_file = "./json/artist_#{input_artist}.json"
  uri = "http://musicbrainz.org/ws/2/artist/?fmt=json&limit=1&query=artist:%22#{input_artist.gsub(" ", "%20")}%22"

  if(!File.exists?(out_file)) then
    grab_uri(uri, out_file, "w")
  end

  data = JSON.parse(File.read(out_file))

  artists[input_artist] = ArtistInfo.new(
                                   i+=1,
                                   #data["artists"][0]["id"],
                                   data["artists"][0]["name"],
                                   data["artists"][0]["sort-name"])

  # break
end


title      = ""
date       = ""
tracks     = []
image_path = ""
releaseID  = ""
genre      = ""

i = 2000

artists.each do |input_artist, artist|
  puts input_artist

  input_data[input_artist].each do |album_title|
    puts album_title
    #http://musicbrainz.org/ws/2/release-group/?query=release:%22Abbey%20Road%22+AND+artist:%22The%20Beatles%22&limit=1
    uri = "http://musicbrainz.org/ws/2/release-group/?query=release:" +
          "%22#{album_title.gsub(' ', '%20')}%22" +
          "+AND+artist:" +
          "%22#{artist.name.gsub(' ', '%20')}%22" + "&fmt=json"
          # "%22#{artist.name.gsub(' ', '%20')}%22" + "&limit=1&fmt=json"

    rg_file = "./json/rg_#{input_artist}_#{album_title}.json"
    if(!File.exists?(rg_file)) then
      grab_uri(uri, rg_file, "w")
    end

    # genre/tag
    # ["release-groups"][0]["tags"][0]["name"]
    begin
      genre = data["release-groups"][0]["tags"][0]["name"].capitalize
    rescue
      genre = "Unknown"
    end

    # release-id
    # ["release-groups"][0]["releases"][0]["id"]

    ing_file = ""
    releaseID = nil
    data = JSON.parse(File.open(rg_file).read())
    data["release-groups"][0]["releases"].each do |release|  #[0]["id"]
      begin
        releaseID = release["id"]
        #genre = data["release-groups"][0]["tags"][0]["name"]

        uri = "http://musicbrainz.org/ws/2/release/#{releaseID}?inc=recordings&fmt=json"
        album_file = "json/album_#{input_artist}_#{album_title}.json"

        if(!File.exists?(album_file)) then
          grab_uri(uri, album_file, "w")
        end

        data = JSON.parse(File.open(album_file).read())
        title = data["title"]
        date = data["date"]
        tracks = []
        data["media"][0]["tracks"].each_with_index do |track, n|
          tracks << {
            "index"  => n+1,
            "title"  => track["title"],
            "length" => track["length"]
          }
        end

        uri = "http://coverartarchive.org/release/#{releaseID}/front"
        img_file = "./img/cover_#{artist.name}_#{album_title}.jpg"

        if(!File.exists?(img_file)) then
          grab_uri(uri, img_file, "wb")
        end

        if(File.exists?(img_file)) then
          image_path="./WebContent/img/album/covers/#{releaseID}.jpg"
          FileUtils.cp(img_file, image_path)
          image_path.sub!(/^WebContent\//,"")
          break
        end
      rescue
        puts "failed"
      end
    end

    album = AlbumInfo.new
    album.title      = title
    album.artist     = artists[input_artist].to_hash
    album.year       = date[0,4]
    album.genre      = ""
    album.tracks     = tracks
    #album.tracks     = nil
    album.rating     = ""
    album.image_path = image_path
    album.thumb_path = image_path.sub(/\/covers\//, "/thumbs/")
    # album.mbID       = releaseID
    album.mbID       = i+=1

    albums << album
  end

end

obj = {
  "artists" => artists.values.map {|a| a.to_hash},
  "albums"  => albums.map {|a| a.to_hash}
}

json_data_file = "./WebContent/WEB-INF/RecordBin-data.json"
File.open(json_data_file,"w").write(JSON.pretty_generate(obj))

# [release][id]
# [release][title]
# [release][date]
# [release][medium-list][0][medium][track-list][...][track][length]
# [release][medium-list][0][medium][track-list][...][track][recording][title]
# [release][medium-list][0][medium][track-list][...][track][recording][length]

#http://musicbrainz.org/ws/2/release/d6010be3-98f8-422c-a6c9-787e2e491e58?inc=recordings

#[release][medium-list][0][medium][track-list][track][recording][title]
