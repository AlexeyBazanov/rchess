require 'ostruct'
require 'json'

class Configuration
  def self.settings
    @settings ||= OpenStruct.new
  end

  def self.configure(from_hash: true)
    if from_hash
      @settings = {}
      yield(settings)
      json = @settings.to_json
      @settings = JSON.parse(json, object_class:OpenStruct)
    else
      yield(settings)
    end
  end

  def self.locale
    settings.dig(:locale)
  end

  def self.figures_notation
    settings.dig(:notation).dig(:figures)
  end

  def self.moves_notation
    settings.dig(:notation).dig(:moves)
  end
end