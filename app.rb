
require('sinatra')
require('sinatra/reloader')
require('./lib/doctor')
require('./lib/patient')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'doctors_office_test'})

get('/') do
  @doctors = Doctor.all()
  @patients = Patient.all()
  erb(:index)
end

post('/new_doctor') do
  name = params.fetch('name')
  specialty = params.fetch('specialty')
  doctor = Doctor.new({:name => name, :specialty => specialty, :id => nil, :specialty_id => nil})
  doctor.save()
  @doctors = Doctor.all()
  @patients = Patient.all()
  erb(:index)
end

post('/new_patient') do
  name = params.fetch('patient')
  birthdate = params.fetch('birthdate')
  patient = Patient.new({:name => name, :birthdate => birthdate, :id => nil, :doctor_id => nil})
  patient.save()
  @doctors = Doctor.all()
  @patients = Patient.all()
  erb(:index)
end

post('/assign') do
  doctor_id = params.fetch('doctor_id')
  patient_id = params.fetch('assignment')
  patient = Patient.find(patient_id)
  DB.exec("UPDATE patients SET doctor_id = #{doctor_id} WHERE id = #{patient_id};")
  @doctors = Doctor.all()
  @patients = Patient.all()
  erb(:index)
end

get('/doctor/:id') do
  @doctor = Doctor.find(params.fetch('id').to_i())
  erb(:doctor)
end
