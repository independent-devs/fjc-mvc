# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `yaml_db` gem.
# Please instead update this file by running `bin/tapioca gem yaml_db`.


# source://yaml_db//lib/yaml_db/rake_tasks.rb#1
module YamlDb; end

# source://yaml_db//lib/yaml_db.rb#35
class YamlDb::Dump < ::YamlDb::SerializationHelper::Dump
  class << self
    # source://yaml_db//lib/yaml_db.rb#37
    def dump_table_columns(io, table); end

    # source://yaml_db//lib/yaml_db.rb#42
    def dump_table_records(io, table); end

    # source://yaml_db//lib/yaml_db.rb#53
    def table_record_header(io); end
  end
end

# source://yaml_db//lib/yaml_db.rb#10
module YamlDb::Helper
  class << self
    # source://yaml_db//lib/yaml_db.rb#15
    def dumper; end

    # source://yaml_db//lib/yaml_db.rb#19
    def extension; end

    # source://yaml_db//lib/yaml_db.rb#11
    def loader; end
  end
end

# source://yaml_db//lib/yaml_db.rb#59
class YamlDb::Load < ::YamlDb::SerializationHelper::Load
  class << self
    # source://yaml_db//lib/yaml_db.rb#60
    def load_documents(io, truncate = T.unsafe(nil)); end
  end
end

# source://yaml_db//lib/yaml_db.rb#70
class YamlDb::Railtie < ::Rails::Railtie; end

# source://yaml_db//lib/yaml_db/rake_tasks.rb#2
module YamlDb::RakeTasks
  class << self
    # source://yaml_db//lib/yaml_db/rake_tasks.rb#7
    def data_dump_dir_task; end

    # source://yaml_db//lib/yaml_db/rake_tasks.rb#3
    def data_dump_task; end

    # source://yaml_db//lib/yaml_db/rake_tasks.rb#16
    def data_load_dir_task; end

    # source://yaml_db//lib/yaml_db/rake_tasks.rb#12
    def data_load_task; end

    # source://yaml_db//lib/yaml_db/rake_tasks.rb#27
    def db_dump_data_file(extension = T.unsafe(nil)); end

    # source://yaml_db//lib/yaml_db/rake_tasks.rb#23
    def default_dir_name; end

    # source://yaml_db//lib/yaml_db/rake_tasks.rb#31
    def dump_dir(dir = T.unsafe(nil)); end

    # source://yaml_db//lib/yaml_db/rake_tasks.rb#35
    def helper; end
  end
end

# source://yaml_db//lib/yaml_db/serialization_helper.rb#4
module YamlDb::SerializationHelper; end

# source://yaml_db//lib/yaml_db/serialization_helper.rb#6
class YamlDb::SerializationHelper::Base
  # @return [Base] a new instance of Base
  #
  # source://yaml_db//lib/yaml_db/serialization_helper.rb#9
  def initialize(helper); end

  # source://yaml_db//lib/yaml_db/serialization_helper.rb#50
  def disable_logger; end

  # source://yaml_db//lib/yaml_db/serialization_helper.rb#15
  def dump(filename); end

  # source://yaml_db//lib/yaml_db/serialization_helper.rb#23
  def dump_to_dir(dirname); end

  # Returns the value of attribute extension.
  #
  # source://yaml_db//lib/yaml_db/serialization_helper.rb#7
  def extension; end

  # source://yaml_db//lib/yaml_db/serialization_helper.rb#35
  def load(filename, truncate = T.unsafe(nil)); end

  # source://yaml_db//lib/yaml_db/serialization_helper.rb#41
  def load_from_dir(dirname, truncate = T.unsafe(nil)); end

  # source://yaml_db//lib/yaml_db/serialization_helper.rb#55
  def reenable_logger; end
end

# source://yaml_db//lib/yaml_db/serialization_helper.rb#150
class YamlDb::SerializationHelper::Dump
  class << self
    # source://yaml_db//lib/yaml_db/serialization_helper.rb#163
    def after_table(io, table); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#151
    def before_table(io, table); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#155
    def dump(io); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#171
    def dump_table(io, table); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#183
    def each_table_page(table, records_per_page = T.unsafe(nil)); end

    # Return the first column as sort key unless the table looks like a
    # standard has_and_belongs_to_many join table, in which case add the second "ID column"
    #
    # source://yaml_db//lib/yaml_db/serialization_helper.rb#203
    def sort_keys(table); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#178
    def table_column_names(table); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#197
    def table_record_count(table); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#167
    def tables; end
  end
end

# source://yaml_db//lib/yaml_db/serialization_helper.rb#60
class YamlDb::SerializationHelper::Load
  class << self
    # source://yaml_db//lib/yaml_db/serialization_helper.rb#61
    def load(io, truncate = T.unsafe(nil)); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#84
    def load_records(table, column_names, records); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#75
    def load_table(table, data, truncate = T.unsafe(nil)); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#96
    def reset_pk_sequence!(table_name); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#67
    def truncate_table(table); end
  end
end

# source://yaml_db//lib/yaml_db/serialization_helper.rb#104
module YamlDb::SerializationHelper::Utils
  class << self
    # source://yaml_db//lib/yaml_db/serialization_helper.rb#132
    def boolean_columns(table); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#128
    def convert_boolean(value); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#118
    def convert_booleans(records, columns); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#137
    def is_boolean(value); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#145
    def quote_column(column); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#141
    def quote_table(table); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#106
    def unhash(hash, keys); end

    # source://yaml_db//lib/yaml_db/serialization_helper.rb#110
    def unhash_records(records, keys); end
  end
end

# source://yaml_db//lib/yaml_db.rb#25
module YamlDb::Utils
  class << self
    # source://yaml_db//lib/yaml_db.rb#26
    def chunk_records(records); end
  end
end

# source://yaml_db//lib/yaml_db/version.rb#2
YamlDb::VERSION = T.let(T.unsafe(nil), String)
