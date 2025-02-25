# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `ranked-model` gem.
# Please instead update this file by running `bin/tapioca gem ranked-model`.


# source://ranked-model//lib/ranked-model/ranker.rb#1
module RankedModel
  include GeneratedInstanceMethods

  mixes_in_class_methods GeneratedClassMethods
  mixes_in_class_methods ::RankedModel::ClassMethods

  private

  # source://ranked-model//lib/ranked-model.rb#31
  def handle_ranking; end

  class << self
    # @private
    #
    # source://ranked-model//lib/ranked-model.rb#13
    def included(base); end
  end

  module GeneratedClassMethods
    def rankers; end
    def rankers=(value); end
    def rankers?; end
  end

  module GeneratedInstanceMethods
    def rankers; end
    def rankers=(value); end
    def rankers?; end
  end
end

# source://ranked-model//lib/ranked-model.rb#37
module RankedModel::ClassMethods
  # source://ranked-model//lib/ranked-model.rb#39
  def ranker(name); end

  private

  # source://ranked-model//lib/ranked-model.rb#71
  def column_default(ranker); end

  # source://ranked-model//lib/ranked-model.rb#47
  def ranks(*args); end
end

# source://ranked-model//lib/ranked-model/ranker.rb#4
class RankedModel::InvalidField < ::StandardError; end

# source://ranked-model//lib/ranked-model/ranker.rb#3
class RankedModel::InvalidScope < ::StandardError; end

# Signed INT in MySQL
#
# source://ranked-model//lib/ranked-model.rb#10
RankedModel::MAX_RANK_VALUE = T.let(T.unsafe(nil), Integer)

# source://ranked-model//lib/ranked-model.rb#11
RankedModel::MIN_RANK_VALUE = T.let(T.unsafe(nil), Integer)

# source://ranked-model//lib/ranked-model.rb#6
class RankedModel::NonNilColumnDefault < ::StandardError; end

# source://ranked-model//lib/ranked-model/railtie.rb#6
class RankedModel::Railtie < ::Rails::Railtie; end

# source://ranked-model//lib/ranked-model/ranker.rb#6
class RankedModel::Ranker
  # @return [Ranker] a new instance of Ranker
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#9
  def initialize(name, options = T.unsafe(nil)); end

  # Returns the value of attribute class_name.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def class_name; end

  # Sets the attribute class_name
  #
  # @param value the value to set the attribute class_name to.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def class_name=(_arg0); end

  # Returns the value of attribute column.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def column; end

  # Sets the attribute column
  #
  # @param value the value to set the attribute column to.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def column=(_arg0); end

  # Returns the value of attribute name.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def name; end

  # Sets the attribute name
  #
  # @param value the value to set the attribute name to.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def name=(_arg0); end

  # Returns the value of attribute scope.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def scope; end

  # Sets the attribute scope
  #
  # @param value the value to set the attribute scope to.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def scope=(_arg0); end

  # Returns the value of attribute unless.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def unless; end

  # Sets the attribute unless
  #
  # @param value the value to set the attribute unless to.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def unless=(_arg0); end

  # source://ranked-model//lib/ranked-model/ranker.rb#19
  def with(instance); end

  # Returns the value of attribute with_same.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def with_same; end

  # Sets the attribute with_same
  #
  # @param value the value to set the attribute with_same to.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#7
  def with_same=(_arg0); end
end

# source://ranked-model//lib/ranked-model/ranker.rb#23
class RankedModel::Ranker::Mapper
  # @return [Mapper] a new instance of Mapper
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#26
  def initialize(ranker, instance); end

  # source://ranked-model//lib/ranked-model/ranker.rb#90
  def current_at_position(_pos); end

  # source://ranked-model//lib/ranked-model/ranker.rb#52
  def handle_ranking; end

  # @return [Boolean]
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#96
  def has_rank?; end

  # Returns the value of attribute instance.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#24
  def instance; end

  # Sets the attribute instance
  #
  # @param value the value to set the attribute instance to.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#24
  def instance=(_arg0); end

  # source://ranked-model//lib/ranked-model/ranker.rb#76
  def position; end

  # source://ranked-model//lib/ranked-model/ranker.rb#86
  def rank; end

  # Returns the value of attribute ranker.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#24
  def ranker; end

  # Sets the attribute ranker
  #
  # @param value the value to set the attribute ranker to.
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#24
  def ranker=(_arg0); end

  # source://ranked-model//lib/ranked-model/ranker.rb#80
  def relative_rank; end

  # source://ranked-model//lib/ranked-model/ranker.rb#72
  def reset_ranks!; end

  # source://ranked-model//lib/ranked-model/ranker.rb#64
  def update_rank!(value); end

  # source://ranked-model//lib/ranked-model/ranker.rb#33
  def validate_ranker_for_instance!; end

  private

  # source://ranked-model//lib/ranked-model/ranker.rb#183
  def assure_unique_position; end

  # source://ranked-model//lib/ranked-model/ranker.rb#288
  def current_first; end

  # source://ranked-model//lib/ranked-model/ranker.rb#296
  def current_last; end

  # source://ranked-model//lib/ranked-model/ranker.rb#280
  def current_order; end

  # source://ranked-model//lib/ranked-model/ranker.rb#329
  def find_next_two(_rank); end

  # source://ranked-model//lib/ranked-model/ranker.rb#341
  def find_previous_two(_rank); end

  # source://ranked-model//lib/ranked-model/ranker.rb#250
  def finder(order = T.unsafe(nil)); end

  # source://ranked-model//lib/ranked-model/ranker.rb#106
  def instance_class; end

  # source://ranked-model//lib/ranked-model/ranker.rb#308
  def neighbors_at_position(_pos); end

  # @return [Boolean]
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#124
  def new_record?; end

  # source://ranked-model//lib/ranked-model/ranker.rb#353
  def notify_ranks_updated(&block); end

  # source://ranked-model//lib/ranked-model/ranker.rb#110
  def position_at(value); end

  # source://ranked-model//lib/ranked-model/ranker.rb#115
  def rank_at(value); end

  # source://ranked-model//lib/ranked-model/ranker.rb#174
  def rank_at_average(min, max); end

  # @return [Boolean]
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#120
  def rank_changed?; end

  # @return [Boolean]
  #
  # source://ranked-model//lib/ranked-model/ranker.rb#304
  def rank_taken?; end

  # source://ranked-model//lib/ranked-model/ranker.rb#191
  def rearrange_ranks; end

  # source://ranked-model//lib/ranked-model/ranker.rb#218
  def rebalance_ranks; end

  # source://ranked-model//lib/ranked-model/ranker.rb#102
  def reset_cache; end

  # source://ranked-model//lib/ranked-model/ranker.rb#128
  def update_index_from_position; end
end
