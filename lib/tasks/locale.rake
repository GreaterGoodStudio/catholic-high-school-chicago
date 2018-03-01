require "yaml2csv"

namespace :locale do
  desc "Exports en.yml to CSV"

  task :export do
    yaml = File.open(File.join(Rails.root, "config", "locales", "en.yml")).read
    puts Yaml2csv::yaml2csv yaml
  end

  task :import do
  end
end