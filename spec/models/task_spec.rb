require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "#toggle_complete!" do
    it "should switch complete to false if it was true" do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it "should switch complete to true if it was false" do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe "toggle_favorite!" do
    it "should switch favorite to false if it was true" do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it "should switch favorite to false if it was true" do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end    
  end

  describe "overdue?" do
    it "should return true if deadline of task is earlier than now" do
      task = Task.create(deadline: 1.day.ago)
      task.overdue?
      expect(task.overdue?).to eq(true)
    end

    it "should return false if deadline of task is later than now" do
      task = Task.create(deadline: 1.day.from_now)
      task.overdue?
      expect(task.overdue?).to eq(false)
    end
  end  

  describe "increment_priority!" do
    it "should increase the priority by one" do
      task = Task.create(priority: 3)
      task.increment_priority!
      expect(task.priority).to eq(4)
    end
    it "should not increment priority beyond 10" do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe "decrement_priority!" do
    it "should decrease the priority by one" do
      task = Task.create(priority: 3)
      task.decrement_priority!
      expect(task.priority).to eq(2)
    end
    it "should not decrement priority beyond 1" do
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end  
  describe "snooze_hour!" do
    it "should push deadline off by 1 hour" do
      deadline = DateTime.new(2019, 10, 23)
      task = Task.create(deadline: deadline)
      task.snooze_hour!
      expect(task.deadline).to eq(deadline + 1.hour)
    end
  end
end