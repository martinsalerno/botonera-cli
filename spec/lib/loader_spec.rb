require 'spec_helper'

describe Loader do
  subject(:loader) { Loader.new }

  around(:each) do |example|
    buttons = loader.buttons.dup

    example.run

    loader.instance_variable_set('@buttons', buttons)
    loader.send(:save!)
  end

  describe '#buttons' do
    it 'returns the existing buttons' do
      expect(loader.buttons).to include('a' => { 'name' => 'test', 'source' => 'test' })
    end
  end

  describe '#add_button!' do
    it 'adds a new button' do
      loader.add_button!('b', 'test_b', 'test_b')

      expect(loader.buttons).to include('b' => { 'name' => 'test_b', 'source' => 'test_b' })
    end
  end

  describe '#remove_button!' do
    it 'removes a button' do
      loader.remove_button!('a')

      expect(loader.buttons).not_to include('a' => { 'name' => 'test', 'source' => 'test' })
    end
  end
end
