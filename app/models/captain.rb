class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # binding.pry
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.motorboat
    includes(boats: :classifications).where("classifications.name = ?", "Motorboat")
  end

  def self.talented_seafarers
    where("id in (?)",sailors.pluck(:id) & motorboat.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", sailors.pluck(:id))
  end
end
