class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
     includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
     includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
     includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
    #pluck selects one or more attributes without loading a bunch of records
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
