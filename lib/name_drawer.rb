# frozen_string_literal: true

# Generate list of names from groups
# params:
# @groups: Hash, Key value pairs (key is number, value is array of names)
class NameDrawer
  attr_accessor :groups, :names, :result

  def initialize(groups)
    @groups = groups
    @names = @groups.values.flatten
    @result = {}
  end

  def generate_groups
    @names = @groups.values.flatten

    @names.count.times do
      name = @names.sample
      name = @names.sample while @result.keys.include? name
      process(name)
    end

    @result = generate_groups if @result.values.include? nil

    @result
  end

  def process(name)
    group = @groups.select { |_g, values| values.include? name }
    group_names = group.values.flatten
    eligible_names = (@names - @result.values - group_names).compact

    target_name = eligible_names.sample
    @result[name] = target_name
  end
end
