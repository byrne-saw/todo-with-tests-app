require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
    it 'should switch complete to false if it began as true' do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
    it 'should switch complete to true if it began as false' do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#toggle_favorite!' do
    it 'should switch favorite to false if it began as true' do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
    it 'should switch favorite to true if it began as false' do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe '#overdue?' do
    it 'should return true if the current time is after than the deadline' do
      deadline = Time.now - 5.days
      task = Task.create(deadline: deadline)
      expect(task.overdue?).to eq(true)
    end
    it 'should return false if the current time is before than the deadline' do
      deadline = Time.now + 5.days
      task = Task.create(deadline: deadline)
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do
    it 'should increase priority by 1 if priority is less than 10' do
      task = Task.create(priority: 4)
      task.increment_priority!
      expect(task.priority).to eq(5)
    end    
    it 'should keep priority equal to 10 if priority is  10' do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#decrement_priority!' do
    it 'should decrease priority by 1 if priority is greater than 1' do
      task = Task.create(priority: 4)
      task.decrement_priority!
      expect(task.priority).to eq(3)
    end
    it 'should keep priority equal to 1 if priority is  1' do
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do
    it 'should increase the deadline by 1 hour' do
      time = Time.now
      task = Task.create(deadline: time)
      task.snooze_hour!
      expect(task.deadline).to eq(time + 1.hour)
    end
  end
end
