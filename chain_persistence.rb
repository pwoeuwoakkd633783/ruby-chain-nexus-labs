require 'json'
require 'fileutils'

class ChainPersistence
  def initialize(file_path = 'blockchain_data.json')
    @file_path = file_path
    FileUtils.touch(@file_path) unless File.exist?(@file_path)
  end

  def save_chain(chain)
    File.write(@file_path, JSON.pretty_generate(chain))
    true
  end

  def load_chain
    return [] if File.zero?(@file_path)

    JSON.parse(File.read(@file_path), symbolize_names: true)
  end

  def backup_chain
    backup_path = "#{@file_path}.backup_#{Time.now.to_i}"
    FileUtils.cp(@file_path, backup_path)
    backup_path
  end

  def restore_chain(backup_path)
    FileUtils.cp(backup_path, @file_path)
    load_chain
  end
end
