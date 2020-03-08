require 'faker'

def create_user
  name = Faker::Name.name
  email = Faker::Internet.unique.email
  passwd = 'passwd'
  gender = Faker::Gender.type
  branch = UserDetail::DEPARTMENTS.sample
  course = UserDetail::COURSES.sample
  year = rand(4) + 1
  cgpa = rand(3) + 7
  section = if year == 1
              rand(12) + 1
            else
              nil
            end
  opt_in = false
  residence = Faker::Address.street_name

  user = User.create(
    email: email,
    password: 'passwd',
    password_confirmation: 'passwd',
    name: name
  )

  roll_number = "18-#{user.id}"

  user.create_user_detail(
    gender: gender,
    branch: branch,
    year: year,
    roll_number: roll_number,
    course: course,
    section: section,
    opt_in: opt_in,
    residence: residence,
    cgpa: cgpa
  )
  user
end

### Users ###

# Create admin account

admin = User.create(
  email: 'admin@test.com',
  password: 'passwd',
  password_confirmation: 'passwd',
  name: 'Administrator',
  admin: true
)

puts "Admin Created"

# Create 100 user accounts
100.times do
  create_user
end

puts "User accounts created"

# Create 15 candidates
15.times do |id|
  user = create_user
  candidate = Candidate.new(
    affilation: Candidate::PARTIES.sample,
    past_experiences: '',
    about_me: "Hi! I am awesome candidate number #{id}",
    link: ''
  )
  user.candidate = candidate
end

puts "Candidate accounts created"

### Elections ###

session = "2018-19"

elections = Array.new

# Two elections which have finished by now

elections << Election.create(
  position: "Past Election 1",
  deadline: DateTime.now - 1.month,
  start_time: DateTime.now - 3.week,
  end_time: DateTime.now - 2.week,
  session: session
)

elections << Election.create(
  position: "Past Election 2",
  deadline: DateTime.now - 2.month,
  start_time: DateTime.now - 6.week,
  end_time: DateTime.now - 4.week,
  session: session
)

# An election currently in progress

elections << Election.create(
  position: "Present Election",
  deadline: DateTime.now - 1.week,
  start_time: DateTime.now - 2.day,
  end_time: DateTime.now + 1.week,
  session: session
)

# Two elections in future

elections << Election.create(
  position: "Future Election 1",
  deadline: DateTime.now + 1.month,
  start_time: DateTime.now + 5.week,
  end_time: DateTime.now + 6.week,
  session: session
)

elections << Election.create(
  position: "Future Election 2",
  deadline: DateTime.now + 1.week,
  start_time: DateTime.now + 2.week,
  end_time: DateTime.now + 15.day,
  session: session
)

puts "Elections created"

### Nominations ###

candidate_ids = Candidate.pluck(:id)
elections.select { |election| election.nominations_over? }.each do |election|
  5.times do
    id = candidate_ids.sample
    election.nominate(id)
  end
end

elections.reject { |election| election.nominations_over? }.each do |election|
  3.times do
    id = candidate_ids.sample
    election.nominate(id)
  end
end

puts "Nominations created"

### Voting ###

elections.select { |election| election.voting_over? }.each do |election|
  candidate_ids = election.candidate_ids
  (2...User.count).each do |voter_id|
    candidate_id = candidate_ids.sample
    election.vote(voter_id, candidate_id)
  end
  puts "Votes for #{election.position} added"
end

elections.select { |election| election.in_progress? }.each do |election|
  candidate_ids = election.candidate_ids
  (2...((User.count)/2)).each do |voter_id|
    candidate_id = candidate_ids.sample
    election.vote(voter_id, candidate_id)
  end
  puts "Votes for #{election.position} added"
end

puts "Votes added"
