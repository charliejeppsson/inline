
puts 'Cleaning database...'

Appointment.destroy_all
Administrator.destroy_all
Line.destroy_all
User.destroy_all


puts 'Creating users...'

# line hosts
User.create(
  email: "doctor@house.com",
  first_name: "Doctor",
  last_name: "House",
  age: 50,
  password: "12345678"
)
User.create(
  email: "elon@musk.com",
  first_name: "Elon",
  last_name: "Musk",
  age: 42,
  password: "12345678"
)
User.create(
  email: "branch@manager.com",
  first_name: "Bank",
  last_name: "Clerk",
  age: 45,
  password: "12345678"
)

# line host coworkers
User.create(
  email: "bank@clerk.com",
  first_name: "Bank",
  last_name: "Clerk",
  age: 32,
  password: "12345678"
)

# patients
User.create(
  email: "sick@patient1.com",
  first_name: "Donald",
  last_name: "Trump",
  age: 70,
  password: "12345678"
)
User.create(
  email: "sick@patient2.com",
  first_name: "Stephen",
  last_name: "Hawking",
  age: 62,
  password: "12345678"
)
User.create(
  email: "sick@patient3.com",
  first_name: "Warren",
  last_name: "Buffett",
  age: 82,
  password: "12345678"
)

# journalists
User.create(
  email: "journalist@media1.com",
  first_name: "Peter",
  last_name: "Parker",
  age: 24,
  password: "12345678"
)
User.create(
  email: "journalist@media2.com",
  first_name: "Clark",
  last_name: "Kent",
  age: 27,
  password: "12345678"
)
User.create(
  email: "journalist@media3.com",
  first_name: "Lois",
  last_name: "Lane",
  age: 27,
  password: "12345678"
)

# bank clients
User.create(
  email: "bank@client1.com",
  first_name: "Danny",
  last_name: "Ocean",
  age: 49,
  password: "12345678"
)
User.create(
  email: "bank@client2.com",
  first_name: "Night",
  last_name: "Fox",
  age: 49,
  password: "12345678"
)
User.create(
  email: "bank@client3.com",
  first_name: "Mr",
  last_name: "Pink",
  age: 31,
  password: "12345678"
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
line.photo_url = url

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
line.photo_url = url

line = Line.create(
  title: "Chase Bank Williamsburg's Customer Service Line",
  organization_name: "Chase Bank",
  location: "110 S 8th St, Brooklyn, New York, USA",
  start_time: "2017-06-24 11:00:00",
  avg_service_time: 15,
  user_id: User.where(email: "branch@manager.com").first.id
)
line.save!
url = "app/assets/images/bank.jpg"
line.photo_url = url


puts 'Creating appointments...'

# patient appointments
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

# interviewer appointments
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

# bank appointments
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
