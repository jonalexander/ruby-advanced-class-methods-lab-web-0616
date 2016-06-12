class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    #self.class.all equivalent of Song.all
    self.class.all << self  
  end

  def self.create
    song = self.new   # song => Song.new
    self.all << song  # Song.all << song ||  @@all << song
    song              # => song
  end

  def self.new_by_name(song_name)
    song = self.new
    song.name = song_name
    song
    #returns a song instance with that name set as its name property
  end

  def self.create_by_name(song_name)
    song = self.new
    song.name = song_name
    self.all << song
    song
  end

  def self.find_by_name(song_name)
    self.all.detect { |song| song.name == song_name}
  end

  def self.find_or_create_by_name(song_name)
    #if find_by_name returns a result, return it
    #if not or =nil, create_by_name
    result = self.find_by_name(song_name)
    result.nil? ? self.create_by_name(song_name) : result
  end

  def self.alphabetical
    self.all.sort_by { |song| song.name }
  end

  def self.new_from_filename(file_name)
    #pass ("Taylor Swift - Blank Space.mp3")
    # => song=Song.new("Blank Space") // song.name = "Blank Space" // arist_name = "Taylor Swift"
    parsed_result = file_name.split(/[-.]/).collect { |string| string.strip.lstrip} 
    # => ["Taylor Swift ", "Blank Space" ".mp3"]
    artist_name = parsed_result[0]
    song_name = parsed_result[1]

    song = self.create_by_name(song_name)
    song.artist_name = artist_name
    song
  end

  def self.create_from_filename(file_name)
    file = file_name
    song = self.new_from_filename(file)
    self.all << song
  end 

  def self.destroy_all
    self.all.clear
  end
end
