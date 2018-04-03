require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    sql = "PRAGMA table_info ('#{table_name}')"
    table_info = DB[:conn].execute(sql)
    col_names = []

    table_info.each do |col|
      col_names << col["name"]
    end
    col_names.compact
  end

  def initialize(options = {})
    options.each do |k, v|
      self.send("#{k}=", v)
    end
  end
end
