require('spec_helper')

describe(Patient) do
    describe(".all") do
    it("starts off with no patients") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe('#name') do
    it("tells you patient's name") do
      patient = Patient.new({:name => "McMurphy", :id => nil, :birthdate => "1983-10-11 00:00:00", :doctor_id => 1})
      expect(patient.name()).to(eq('McMurphy'))
    end
  end

  describe("#birthdate") do
    it("tells you patient's birthdate") do
      patient = Patient.new({:name => "McMurphy", :id => nil, :birthdate => "1983-10-11 00:00:00", :doctor_id => 1})
      expect(patient.birthdate()).to(eq('1983-10-11 00:00:00'))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      patient = Patient.new({:name => "McMurphy", :id => nil, :birthdate => "1983-10-11 00:00:00", :doctor_id => 1})
      patient.save()
      expect(patient.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save patients to the database") do
      patient = Patient.new({:name => "McMurphy", :id => nil, :birthdate => "1983-10-11 00:00:00", :doctor_id => 1})
      patient.save()
      expect(Patient.all()).to(eq([patient]))
    end
  end

  describe("#==") do
    it("is the same patient if it has the same name") do
      patient1 = Patient.new({:name => "McMurphy", :id => nil, :birthdate => "1983-10-11 00:00:00", :doctor_id => 1})
      patient2 = Patient.new({:name => "McMurphy", :id => nil, :birthdate => "1983-10-11 00:00:00", :doctor_id => 1})
      expect(patient1).to(eq(patient2))
    end
  end
end
