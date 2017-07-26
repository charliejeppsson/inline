
puts 'Cleaning database...'

Appointment.destroy_all
Administrator.destroy_all
Line.destroy_all
User.destroy_all


puts 'Creating users...'

# Line hosts
User.create(
  email: "doctor@house.com",
  first_name: "Doctor",
  last_name: "House",
  age: 50,
  password: "12345678",
  facebook_picture_url: "house_avatar.jpg"
)
User.create(
  email: "elon@musk.com",
  first_name: "Elon",
  last_name: "Musk",
  age: 42,
  password: "12345678",
  facebook_picture_url: "elon_avatar.jpg"
)
User.create(
  email: "branch@manager.com",
  first_name: "Gordon",
  last_name: "Gekko",
  age: 45,
  password: "12345678",
  facebook_picture_url: "gordon_avatar.jpg"
)
User.create(
  email: "leo@dicaprio.com",
  first_name: "Frank",
  last_name: "Abagnale",
  age: 45,
  password: "12345678",
  facebook_picture_url: "frank_avatar.jpg"
)

# Patients
User.create(
  email: "sick@patient1.com",
  first_name: "Donald",
  last_name: "Trump",
  age: 70,
  password: "12345678",
  facebook_picture_url: "donald_avatar.jpg"
)
User.create(
  email: "sick@patient2.com",
  first_name: "Stephen",
  last_name: "Hawking",
  age: 62,
  password: "12345678",
  facebook_picture_url: "stephen_avatar.jpg"
)
User.create(
  email: "sick@patient3.com",
  first_name: "Warren",
  last_name: "Buffett",
  age: 82,
  password: "12345678",
  facebook_picture_url: "warren_avatar.jpg"
)

# Airport clients
User.create(
  email: "jack@lost.com",
  first_name: "Jack",
  last_name: "Lost",
  age: 24,
  password: "12345678",
  facebook_picture_url: "jack_avatar.jpg"
)
User.create(
  email: "kate@lost.com",
  first_name: "Kate",
  last_name: "Lost",
  age: 27,
  password: "12345678",
  facebook_picture_url: "kate_avatar.jpg"
)
User.create(
  email: "sawyer@lost.com",
  first_name: "Sawyer",
  last_name: "Lost",
  age: 27,
  password: "12345678",
  facebook_picture_url: "sawyer_avatar.jpg"
)

# Journalists
User.create(
  email: "journalist@media1.com",
  first_name: "Peter",
  last_name: "Parker",
  age: 24,
  password: "12345678",
  facebook_picture_url: "peter_avatar.jpg"
)
User.create(
  email: "journalist@media2.com",
  first_name: "Clark",
  last_name: "Kent",
  age: 27,
  password: "12345678",
  facebook_picture_url: "clark_avatar.jpg"
)
User.create(
  email: "journalist@media3.com",
  first_name: "Lois",
  last_name: "Lane",
  age: 27,
  password: "12345678",
  facebook_picture_url: "lois_avatar.jpg"
)

# Bank clients
User.create(
  email: "bank@client1.com",
  first_name: "Danny",
  last_name: "Ocean",
  age: 49,
  password: "12345678",
  facebook_picture_url: "danny_avatar.jpg"
)
User.create(
  email: "bank@client2.com",
  first_name: "Night",
  last_name: "Fox",
  age: 49,
  password: "12345678",
  facebook_picture_url: "fox_avatar.jpg"
)
User.create(
  email: "bank@client3.com",
  first_name: "Mr",
  last_name: "Pink",
  age: 31,
  password: "12345678",
  facebook_picture_url: "pink_avatar.jpg"
)


puts 'Creating lines...'

line = Line.create(
  title: "Doctor House's Patient Line",
  organization_name: "Hospital XYZ",
  location: "Wall Street 100, Manhattan, New York, USA",
  start_time: "2017-06-24 09:00:00",
  avg_service_time: 20,
  user_id: User.where(email: "doctor@house.com").first.id
)
line.save!
url = "app/assets/images/house.jpg"
line.remote_photo_url = url
line.save!

line = Line.create(
  title: "LAX Airport Line",
  organization_name: "LAX Aiport",
  location: "LAX, California, USA",
  start_time: "2017-06-24 09:00:00",
  avg_service_time: 5,
  user_id: User.where(email: "leo@dicaprio.com").first.id
)
line.save!
url = "app/assets/images/airport-line-phone.jpg"
line.remote_photo_url = url
line.save!

line = Line.create(
  title: "Elon Musk's Interviewer Line",
  organization_name: "SpaceX",
  location: "Rocket Road, Hawthorne, California, USA",
  start_time: "2017-06-24 13:00:00",
  avg_service_time: 10,
  user_id: User.where(email: "elon@musk.com").first.id
)
line.save!
url = "app/assets/images/elon.jpg"
line.remote_photo_url = url
line.save!

line = Line.create(
  title: "Chase Bank Williamsburg's Customer Service Line",
  organization_name: "Chase Bank",
  location: "110 S 8th St, Brooklyn, New York, USA",
  start_time: "2017-06-24 11:00:00",
  avg_service_time: 30,
  user_id: User.where(email: "branch@manager.com").first.id
)
line.save!
url = "app/assets/images/bank.jpg"
line.remote_photo_url = url
line.save!

puts 'Creating appointments...'

# Patient appointments
Appointment.create(
  user_id: User.where(email: "sick@patient1.com").first.id,
  line_id: Line.where(title: "Doctor House's Patient Line").first.id
)
Appointment.create(
  user_id: User.where(email: "sick@patient2.com").first.id,
  line_id: Line.where(title: "Doctor House's Patient Line").first.id
)
Appointment.create(
  user_id: User.where(email: "sick@patient3.com").first.id,
  line_id: Line.where(title: "Doctor House's Patient Line").first.id
)

# Airport appointments
Appointment.create(
  user_id: User.where(email: "jack@lost.com").first.id,
  line_id: Line.where(title: "LAX Airport Line").first.id
)
Appointment.create(
  user_id: User.where(email: "kate@lost.com").first.id,
  line_id: Line.where(title: "LAX Airport Line").first.id
)
Appointment.create(
  user_id: User.where(email: "sawyer@lost.com").first.id,
  line_id: Line.where(title: "LAX Airport Line").first.id
)

# Interviewer appointments
Appointment.create(
  user_id: User.where(email: "journalist@media1.com").first.id,
  line_id: Line.where(title: "Elon Musk's Interviewer Line").first.id
)
Appointment.create(
  user_id: User.where(email: "journalist@media2.com").first.id,
  line_id: Line.where(title: "Elon Musk's Interviewer Line").first.id
)
Appointment.create(
  user_id: User.where(email: "journalist@media3.com").first.id,
  line_id: Line.where(title: "Elon Musk's Interviewer Line").first.id
)

# Bank appointments
Appointment.create(
  user_id: User.where(email: "bank@client1.com").first.id,
  line_id: Line.where(title: "Chase Bank Williamsburg's Customer Service Line").first.id
)
Appointment.create(
  user_id: User.where(email: "bank@client2.com").first.id,
  line_id: Line.where(title: "Chase Bank Williamsburg's Customer Service Line").first.id
)
Appointment.create(
  user_id: User.where(email: "bank@client3.com").first.id,
  line_id: Line.where(title: "Chase Bank Williamsburg's Customer Service Line").first.id
)

puts 'Finished!'
