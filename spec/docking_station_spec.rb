require 'docking_station'

describe DockingStation do
  it 'has a bike method' do
      is_expected.to respond_to(:bikes)
  end

describe '#initialize' do
  it 'should have a capacity' do
    is_expected.to respond_to(:capacity)
  end
  it 'should have a capacity of DefaultCapacity if no capacity is given' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end
  it 'should allow the maintainer to set the capacity' do
    station = DockingStation.new(10)
    expect(station.capacity).to eq 10
  end
end

  describe '#release_bike' do
    it 'releases a bike' do
      bike = Bike.new
      subject.dock(bike)
      subject.release_bike
      expect(subject.bikes).to eq []

    end
    it 'raises an error when no bikes available' do
      expect { subject.release_bike }.to raise_error "No bikes available"
    end
    it 'does not release bike if bike is broken' do
      bike = Bike.new
      bike.report_broken
      subject.dock(bike)
      expect{subject.release_bike}.to raise_error "Bike Broken"

    end
    it 'Should release all bikes that are working' do
      bike1 = Bike.new
      bike2 = Bike.new
      bike1.report_broken
      bike2.report_broken
      subject.dock(bike1)
      10.times {subject.dock Bike.new}
      subject.dock(bike2)
      10.times {subject.release_bike}
      expect(subject.bikes.length).to eq 2
    end

  end

  describe '#dock' do
    it 'raises an error when docking station is full' do
      station = DockingStation.new(30)
      station.capacity.times {station.dock Bike.new} # No need to declare bike instance seprately bike = Bike.new
      expect { station.dock Bike.new }.to raise_error "Docking Station full" #bike2 = Bike.new
    end
    it 'returns bike when its docked' do
      bicycle = Bike.new
      subject.dock(bicycle)
      expect(subject.bikes).to eq [bicycle]
    end
  end
end
