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
      val = val.strip
      es_options[en_options.index(val)] rescue val
    end

    school[key] = translated.join(', ')
    school.save!
  end

  puts "IMPORTED: #{row[2]}"
  sleep 0.2 # So we don't overwhelm the geocoding API
end

I18n.locale = :en
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

  {
    question: "What are high school shadow days?",
    answer: "A high school shadow day is an opportunity for a potential student, like yourself, to spend the day at a high school and attend classes as well as participate in school functions alongside a current high schooler. Most high schools have specific shadow days assigned on the their school calendar throughout the school year. We encourage you to contact schools directly to attend a shadow day. Fall shadow days are generally reserved for 8th graders while spring shadow days are reserved for 7th graders, and sometimes 6th graders."
  },

  {
    question: "How do I apply to a Catholic high school?",
    answer: "Most 8th graders apply to a Catholic high school by taking the high school entrance exam. Students should take the exam at the Catholic high school they wish to attend. You may take the high school entrance exam only once.<br><br>
             After taking the high school entrance exam, you will be asked to submit additional information to the high school where you took the exam to complete your application process. This information may include your report cards.<br><br>
             There are a few Catholic high schools that do not require you to take an entrance exam. Schools in the Cristo Rey network do not require an entrance exam. You may apply to these schools directly through the admissions office of the Cristo Rey high school you wish to apply to."
  },

  {
    question: "How many schools can I apply to?",
    answer: "You may apply to only one Catholic high school at a time.<br><br>
             For example, say you apply to school A by taking the high school entrance exam at School A. If you later want to apply to School B, you must request that your exam scores be sent from School A to School B. This means that you are now applying to School B and you are no longer applying to School A."
  },

  {
    question: "What is the high school entrance exam?",
    answer: "The high school entrance exam is a test offered to 8th graders who desire to attend a Catholic high school. The exam is given at all Catholic high schools, except Cristo Rey network schools, on the first Saturday in December of each year.<br><br>
             The High School Placement Test (HSPT) is the most common Catholic high school entrance exam. But each school controls their own test and test environment."
  },

  {
    question: "Do I register for the high school entrance exam?",
    answer: "Yes, we encourage you to register in advance for the entrance exam. Contact the Catholic high school you wish to attend for their registration process. If you do not register for the entrance exam in advance, you will be treated as a ‘walk-in’ on the morning of the test. Parents or guardians of ‘walk-ins’ will need to provide the school with their emergency contact information that morning.<br><br>
             You will need to bring $25, payable by cash or check, to pay the examination fee at the school administering the exam."
  },

  {
    question: "What else do I need to know about the high school entrance exam?",
    answer: "You will need to bring several #2 pencils to the exam.<br><br>
             Students may take the entrance exam only once as it serves as your application to attend Catholic high school. It is best to take the entrance exam at your top choice high school because the school where you take the entrance exam is where your scores for admission are sent. You may later have these scores sent from one high school to another at your request, but you may apply to only one Catholic high school at a time."
  },

  {
    question: "After I take the entrance exam, what happens next?",
    answer: "On the day of the test, the high school should provide you with information about completing the admissions process and if necessary, financial aid information. This information will contain deadlines for all important paperwork that schools need to receive. Before the beginning of February, you will receive communication from the high school letting you know if you have been accepted, waitlisted or declined. You will then need to decide whether to accept the spot at that high school or to have your test scores transferred to another high school."
  },

  {
    question: "Is every student that takes the entrance exam at a Catholic high school accepted at that school?",
    answer: "Because of school size, academic offerings, and other factors, every child may not always be accepted. It is important to research the different options during your selection process. Consider meeting with a teacher or a school administrator at the school you are currently enrolled in for support in the application process and to learn about acceptance rates.<br><br>
             If you are placed on a waitlist or declined, then you should request that the entrance exam test score be sent to another Catholic high school. This new Catholic high school will then make their own independent decision regarding your acceptance."
  },

  {
    question: "Do Catholic high schools offer scholarships and/or financial aid?",
    answer: "Yes! Catholic high schools are committed to making Catholic education as financially affordable as possible. Each Catholic high school has its own process for applying for financial aid. In general, you and your family fill out an application, submit it to the school and wait for the school to respond with a tuition amount.<br><br>
             In addition to need-based financial aid, schools also offer merit-based aid. Students that take the entrance exam at a school are eligible for that school’s merit-based scholarships."
  },

  {
    question: "How do Big Shoulders Fund scholarships work in high school?",
    answer: " There are two ways you may receive a Big Shoulders Fund (BSF) scholarship for high school:<br>
              If you have a BSF scholarship and currently attend a BSF-supported elementary school, you may be eligible to bring your BSF scholarship with you to Catholic high school. To find out if your BSF scholarship is eligible to support you in high school, please contact Big Shoulders Fund directly.<br><br>
              You may also receive a BSF scholarship if you are accepted to attend a BSF-supported Catholic high school and that school applies for a scholarship on your behalf. The Big Shoulders Fund-supported high schools include: St. Francis de Sales, Leo, Our Lady of Tepeyac, Mount Carmel, St. Rita, De la Salle, Cristo Rey, Holy Trinity, Christ the King, Josephinum, and DePaul."
  },

  {
    question: "I am not sure where I want to go to high school. Should I still take the entrance exam at a Catholic high school?",
    answer: "Absolutely. Even if a Catholic high school is not your overall first choice, it is wise to take the entrance exam at one that would be a top choice for you. By taking the entrance exam at a Catholic high school, you have a strong and safe option for high school. You also make yourself eligible for that high school’s merit-based scholarships and financial aid."
  },

  {
    question: "Do I need to be Catholic in order to attend a Catholic high school?",
    answer: "No, there is no religious rule or requirement that students must be Catholic to attend a Catholic high school."
  },

  {
    question: "What other options are there for high school besides Catholic high schools?",
    answer: "In Chicago, other high school options include public neighborhood high schools, magnet and selective enrollment high schools, military schools, charter schools and other independent private high schools. Each school or set of schools has its own admission process. It is important to research these other options to learn the particular advantages and disadvantages of each, learn if one is a good fit for you, and be aware of important deadlines as well as application steps."
  }
].each do |attrs|
  faq = FAQ.where(question: attrs[:question]).first_or_initialize
  faq.update_attributes!(attrs)
end

# Scholarships
[
  {
    name: "Big Shoulders Fund",
    description: "Big Shoulders Fund (BSF) provides need-based scholarships to Catholic school students in Chicago neighborhoods.
                  Students may receive a scholarship in high school through one of two ways:
                  <ol>
                    <li>If you currently receive a renewable BSF scholarship in elementary school, then it stays with you through high school.</li>
                    <li>If you attend a BSF-supported high school and that school successfullly applies for a scholarship on your behalf.</li>
                  </ol>
                  Applications are due in October each year.",
    website: "http://www.bigshouldersfund.org/"
  },

  {
    name: "Chicago Lights",
    description: "Students must be in the Chicago Lights tutoring program in order to apply for these high school scholarships.",
    website: "https://www.chicagolights.org"
  },

  {
    name: "Daniel Murphy Scholarship Fund",
    description: "Daniel Murphy Scholarship Fund (DMSF) gives high school scholarship assistance and educational support to Chicago students from economically disadvantaged backgrounds. DMSF seeks to make a life-altering difference in the lives of its scholars by providing them with the best opportunity to succeed in high school and college.<br><br>
                  Application is normally due in mid-October.",
    website: "http://www.dmsf.org/"
  },

  {
    name: "HFS Chicago",
    description: "HFS provides financial assistance, one-to-one mentoring and guidance, academic enrichment and leadership opportunities to high-achieving high school students from underserved neighborhoods throughout Chicagoland. HFS Chicago helps develop well-rounded, college-prepared students ready to face the challenges of an ever-changing, global and diverse society.<br><br>
                  Application is normally due in mid-November.",
    website: "https://www.hfschicagoscholars.com/"
  },

  {
    name: "Highsight",
    description: "HighSight provides scholarships, tutoring, mentoring, leadership development, and college readiness programs that create new possibilities for Chicago high school students from low-income families. The HighSight experience empowers scholars to excel in high school and graduate from four-year colleges across the country.<br><br>
                  Application is normally due in February.",
    website: "http://www.highsight.org/"
  },

  {
    name: "LINK Unlimited",
    description: "LINK Unlimited connects economically disadvantaged African American high school students with mentors, resources, and foundational skills required for success as they advance into, through, and beyond college. Candidates must be academically motivated and exhibit a drive to succeed. From there, LINK can help them go anywhere.<br><br>
                  Application is normally due in mid-November.",
    website: "http://linkunlimited.org/web/"
  }
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
    starts_at: Time.zone.local(2018,12,12,9),
    ends_at:  Time.zone.local(2018,12,12,17)
  },
].each do |attrs|
  event = CalendarEvent.where(name: attrs[:name]).first_or_initialize
  event.update_attributes!(attrs)
end
