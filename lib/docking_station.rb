require_relative 'bike'

class DockingStation
  attr_reader :bikes, :capacity
  DEFAULT_CAPACITY = 20
  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    raise "No bikes available" if empty?
    find_unbroken_bike
  end

  def dock(bicycle)
    raise "Docking Station full" if full?
    @bikes.push(bicycle)
  end

  private
  def full?
    @bikes.length == @capacity
  end

  def empty?
    @bikes == []
  end

  def find_unbroken_bike
    broken_count = 0
    @bikes.each_with_index do |bike, index|
      if bike.broken?
        broken_count += 1
      else
        @bikes.delete_at(index)
        break
      end
      raise "Bike Broken"  if @bikes.length == broken_count
    end
  end

end
