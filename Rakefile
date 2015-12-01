require 'yaml'
require 'mp3info'

class Mp3Details
  attr_accessor :file, :file_size, :audio_length, :episode_number, :date

  def initialize
    load_config
    set_file_data
  end

  def set_file_data
    self.file = find_latest_file
    puts "******* #{file} ********"

    regex = Regexp.new("#{@config['mp3_prefix']}?(\\d+)")

    self.episode_number = regex.match(file).captures[0].to_i
    puts "* Episode Number: #{self.episode_number}"

    self.file_size = File.size file
    puts "* File Size: #{file_size}"

    Mp3Info.open file do |f|
      self.audio_length = f.length.to_i
      puts "* Audio Length: #{audio_length}"
    end
    puts "************************"
  end

  private

  def find_latest_file
    path = @config["mp3_directory"]
    regex = @config["mp3_prefix"]

    files = Dir.glob(File.join(path, '*.*'))
    files.select! { |f| f.to_s.match(regex) != nil }
    files.max { |a,b| File.ctime(a) <=> File.ctime(b) }
  end

  def load_config
    @config = YAML.load_file(".config.yml")
  rescue
    puts "Error loading config file. Please make sure there's a .config.yml in the project's root directory."
  end
end

class EpisodeCreator
  attr_accessor :mp3details

  def initialize(details)
    self.mp3details = details
  end

  def create!
    ensure_file_exists
    update_next_episode_metadata
  end

  private

  def update_next_episode_metadata
    episode =  IO.read current_file_name

    set_value episode, "episode", mp3details.episode_number
    set_value episode, "date", (DateTime.now + 1).strftime('%Y-%m-%d')
    set_value episode, "title", "???????"
    set_value episode, "tags", "?????"
    set_value episode, "file_size", mp3details.file_size
    set_value episode, "seconds", mp3details.audio_length
    episode.gsub!(Regexp.new("-#{mp3details.episode_number-1}\\.mp3$"), "-#{mp3details.episode_number}\mp3")

    File.open(current_file_name, "wb") { |f| f.write(episode) }
  end

  def set_value(episode, name, value)
    episode.gsub!(Regexp.new("#{name}: (.)+$"),
                  "#{name}: #{value}")
  end

  def ensure_file_exists
    return if File.exists?(current_file_name)

    FileUtils.cp previous_file_name, current_file_name
  end

  def current_file_name
    "./source/episodes/#{mp3details.episode_number}.html.markdown"
  end

  def previous_file_name
    "./source/episodes/#{mp3details.episode_number - 1}.html.markdown"
  end
end

task :metadata do
  EpisodeCreator.new(Mp3Details.new).create!
end
