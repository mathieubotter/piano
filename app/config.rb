require 'yaml'

module Piano
  def self.config
    OpenStruct.new \
      :twitter_key    => yaml['twitter_key'],
      :twitter_secret => yaml['twitter_secret'],
      :auth_token     => yaml['auth_token']
  end

private

  def self.yaml
    if File.exist?('config/config.yml')
      @yaml ||= YAML.load_file('config/config.yml')
    else
      {}
    end
  end
end
