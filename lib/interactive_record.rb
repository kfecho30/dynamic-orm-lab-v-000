require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def table_name_for_insert
    self.class.table_name
  end

  def col_names_for_insert
    binding.pry
    self.class.column_names
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
end
