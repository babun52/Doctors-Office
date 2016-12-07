class Specialty
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_specialties = DB.exec("SELECT * FROM specialty;")
    specialties = []
    returned_specialties.each do |specialty|
      name = specialty.fetch('name')
      id = specialty.fetch('id').to_i()
      specialties.push(Specialty.new({:name => name, :id => id}))
    end
    specialties
  end

  define_singleton_method(:find) do |id|
    found_specialty = nil
    Specialty.all.each() do |specialty|
      if specialty.id().eql?(id)
        found_specialty = specialty
      end
    end
    found_specialty
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO specialty (name) Values ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_specialty|
    name().==(another_specialty.name()).&(self.id().==(another_specialty.id()))
  end
end
