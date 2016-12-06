require('spec_helper')

describe(Doctor) do
    describe(".all") do
    it("starts off with no doctors") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe('#name') do
    it("tells you doctor's name") do
      doctor = Doctor.new({:name => "Dr. Strangelove", :id => nil, :specialty => "oncology"})
      expect(doctor.name()).to(eq('Dr. Strangelove'))
    end
  end

  describe("#specialty") do
    it("tells you doctor's specialty") do
      doctor = Doctor.new({:name => "Dr. Strangelove", :id => nil, :specialty => "oncology"})
      expect(doctor.specialty()).to(eq('oncology'))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      doctor = Doctor.new({:name => "Dr. Strangelove", :id => nil, :specialty => "oncology"})
      doctor.save()
      expect(doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save doctors to the database") do
      doctor = Doctor.new({:name => "Dr. Strangelove", :id => nil, :specialty => "oncology"})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end

  describe("#==") do
    it("is the same doctor if it has the same name") do
      doctor1 = Doctor.new({:name => "Dr. Strangelove", :id => nil, :specialty => "oncology"})
      doctor2 = Doctor.new({:name => "Dr. Strangelove", :id => nil, :specialty => "oncology"})
      expect(doctor1).to(eq(doctor2))
    end
  end
end
