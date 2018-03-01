require "csv"

# Admin user
User.where(email: "admin@example.com").first_or_initialize.tap do |user|
  user.update_attributes(
    name: "Admin User",
    password: "password",
    password_confirmation: "password",
    admin: true
  )
end if Rails.env.development?

# Import questionnaire
seeds_csv = File.join(Rails.root, "db", "seeds", "questionnaire.csv")
CSV.foreach(seeds_csv, headers: true) do |row|
  I18n.locale = :en
  school = School.where(name: row[2].to_s.strip).first_or_initialize
  school.assign_attributes(
    address: row[3].to_s.strip,
    phone: row[4].to_s.strip,
    website: row[5].to_s.strip,
    application: row[6].to_s.strip,
    description: row[7].to_s.strip,
    population_total: row[8].to_s.strip,
    population_yearly: row[9].to_s.strip,
    population_makeup: row[10].to_s.strip,
    tuition_cost: row[11].to_s.strip,
    tuition_merit: row[12].to_s.strip,
    tuition_assistance: row[13].to_s.strip,
    tuition_private: row[14].to_s.strip,
    tuition_link: row[15].to_s.strip,
    transportation_public: row[16].to_s.strip,
    transportation_bus: row[17].to_s.strip,
    transportation_l: row[18].to_s.strip,
    transportation_metra: row[19].to_s.strip,
    transportation_provided: row[20].to_s.strip,
    programming_support: row[21].to_s.strip,
    programming_academic: row[22].to_s.strip,
    programming_ap: row[23].to_s.strip,
    programming_extracurricular: row[24].to_s.strip,
    programming_athletic: row[25].to_s.strip,
    shadowing_link: row[27].to_s.strip,
    transportation_options: row[28].to_s.strip,
  )

  # Translations
  [ :population_total, 
    :population_makeup, 
    :programming_support, 
    :programming_academic,
    :programming_extracurricular,
    :programming_athletic,
    :transportation_options
  ].each do |key|
    I18n.locale = :en
    en_values = school[key].scan(/(?:\([^()]*\)|[^,])+/)
    en_options = I18n.t("search_filters.#{key}.options")

    I18n.locale = :es
    es_options = I18n.t("search_filters.#{key}.options")

    translated = en_values.map do |val|
      es_options[en_options.index(val.strip)] rescue val
    end

    school[key] = translated.join(', ')
    school.save!
  end

  puts "IMPORTED: #{row[2]}"
  sleep 0.2 # So we don't overwhelm the geocoding API
end

# FAQ
[
  {
    question: "How can I learn more about my Catholic school options?",
    answer: "Learning what a school offers and what the environment is like is very important. We highly recommended that all 8th graders interested in attending high school go to open houses and participate in shadow days to get a true sense of that school. Talking with admissions officers, school administrators and teachers, plus current students and families is a helpful way to get to know each school and see whether it is a good match for you.<br><br>
             We also offer school profiles and a match tool on this website to help you discover which Catholic high schools have programs and offerings that are a match for you. "
  },

  {
    question: "What are high school open houses?",
    answer: "High school open houses are events where school staff and students showcase the school’s programs, curriculum, clubs, and sports. It is an opportunity for you to speak with members of the school community and gather information on what the school has to offer. Open houses are open to all students and parents or guardians."
  },
].each do |attrs|
  faq = FAQ.where(question: attrs[:question]).first_or_initialize
  faq.update_attributes!(attrs)
end

# Scholarships
[
  {
    name: "Big Shoulders Fund",
    description: "Big Shoulders Fund (BSF) provides need-based scholarships to Catholic school students in Chicago neighborhoods.",
    website: "http://www.bigshouldersfund.org/"
  },

  {
    name: "Chicago Lights",
    description: "Students must be in the Chicago Lights tutoring program in order to apply for these high school scholarships.",
    website: "https://www.chicagolights.org"
  },
].each do |attrs|
  scholarship = Scholarship.where(name: attrs[:name]).first_or_initialize
  scholarship.update_attributes!(attrs)
end

# Calendar Events
[
  {
    name: "Big Shoulders Fund HS Fair",
    starts_at: Time.zone.local(2018,10,18,18),
    ends_at:  Time.zone.local(2018,10,18,20)
  },

  {
    name: "Test Date",
    starts_at: Time.zone.local(2018,12,12),
    ends_at:  Time.zone.local(2018,12,12)
  },
].each do |attrs|
  event = CalendarEvent.where(name: attrs[:name]).first_or_initialize
  event.update_attributes!(attrs)
end
