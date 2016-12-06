class Patient
  attr_reader(:name, :birthdate, :doctor_id, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @birthdate = attributes.fetch(:birthdate)
    @doctor_id = attributes.fetch(:doctor_id)
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each do |patient|
      name = patient.fetch('name')
      birthdate = patient.fetch('birthdate')
      id = patient.fetch('id').to_i()
      doctor_id = patient.fetch('doctor_id').to_i()
      patients.push(Patient.new({:name => name, :id => id, :birthdate => birthdate, :doctor_id => doctor_id}))
    end
    patients
  end

  define_singleton_method(:find) do |id|
    found_patient = nil
    Patient.all.each() do |patient|
      if patient.id().eql?(id)
        found_patient = patient
      end
    end
    found_patient
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patients (name, birthdate) Values ('#{@name}', '#{@birthdate}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_patient|
    name().==(another_patient.name()).&(self.id().==(another_patient.id()))
  end
end
