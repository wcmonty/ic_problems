class Merger
  attr_accessor :old_array, :new_array

  def initialize(array)
    @old_array = array
    @new_array = []
  end

  def run
    old_array.sort {|a, b| a <=> b}
      .each {|tuple| add(tuple)}
    new_array
  end

  private

  def add(tuple)
    last = new_array.last
    tlast = tuple.last
    
    if new_array.empty? || last.last < tuple.first 
      new_array.push(tuple)
    else
      set_last_element(tuple.last)
    end    
  end

  def set_last_element(number)
    new_array.last[1] = number if number > new_array.last[1]
  end
end

require 'rspec'

describe Merger do
  describe '#run' do
    it 'outputs the correct things' do
      input = [[0, 1], [3, 5], [4, 8], [10, 12], [9, 10]]
      output = [[0, 1], [3, 8], [9, 12]]
      expect(Merger.new(input).run).to match_array output
    end

	it 'handles cases where there are no tuples' do
      input = []
      output = []
      expect(Merger.new(input).run).to match_array output
	end

    it 'handles cases where there is only one tuple' do
      input = [[1, 7]]
      output = [[1, 7]]
      expect(Merger.new(input).run).to match_array output
    end

    it 'handles cases where the times touch' do
      input = [[1, 2], [2, 3]] 
      output = [[1, 3]]
      expect(Merger.new(input).run).to match_array output
	end

    it 'handles cases where the times completely overlap' do
      input = [[1, 5], [2, 3]]
      output = [[1, 5]]
      expect(Merger.new(input).run).to match_array output
    end

    it 'handles cases where there are multiple merges' do
      input = [[1, 10], [2, 6], [3, 5], [7, 9]] 
      output = [[1, 10]]
      expect(Merger.new(input).run).to match_array output
    end
  end	
end
