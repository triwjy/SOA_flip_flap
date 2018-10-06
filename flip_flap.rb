require_relative 'tsv_buddy'
require_relative 'yaml_buddy'

# Converts tabular data between storage formats
class FlipFlap
  # Do NOT create an initialize method
  include TsvBuddy
  include YamlBuddy

  attr_reader :data

  def self.input_formats
    outputs = method_that_starts_with('take')
    outputs ? outputs.map { |method| method[5..-1] } : []
  end

  def self.method_names
    instance_methods.map(&:to_s)
  end

  def self.method_that_starts_with(word)
    method_names.select { |kata| kata.match(Regexp.new("^#{word}_")) }
  end
end
