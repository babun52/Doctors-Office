class Doctor
  attr_reader(:name, :specialty, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each do |doctor|
      name = doctor.fetch('name')
      specialty = doctor.fetch('specialty')
      id = doctor.fetch('id').to_i()
      doctors.push(Doctor.new({:name => name, :id => id, :specialty => specialty}))
    end
    doctors
  end

  define_singleton_method(:find) do |id|
    found_doctor = nil
    Doctor.all.each() do |doctor|
      if doctor.id().eql?(id)
        found_doctor = doctor
      end
    end
    found_doctor
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (name, specialty) Values ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_doctor|
    name().==(another_doctor.name()).&(self.id().==(another_doctor.id()))
  end
end
