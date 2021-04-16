require "yaml"

IRB.conf[:USE_MULTILINE] = false

data = YAML.load_file('docs/category_conversion.yml').with_indifferent_access

# Step 1: Convert data
I18n.locale = :en
School.find_each do |school|
  ap = school.programming_academic.split(",").any? { |p| data[:en][:remove].include?(p) }
  puts ap
end