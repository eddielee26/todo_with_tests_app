require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should mark all tasks belonging to this list as complete' do
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!

      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it "should add 1 hour to the deadline of all tasks" do
      list = List.create(name: "Chores")
      deadline = DateTime.new(2019, 10, 23)
      Task.create(deadline: deadline, list_id: list.id)
      Task.create(deadline: deadline, list_id: list.id)
      list.snooze_all_tasks!

      list.tasks.each do |task|
        expect(task.deadline).to eq(deadline + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it "should return the total duration of all tasks" do
      list = List.create(name: "Chores")
      Task.create(duration: 50, list_id: list.id)
      Task.create(duration: 60, list_id: list.id)
      expect(list.total_duration).to eq(110)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of all incomplete tasks' do
      list = List.create(name: "Chores")
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      incomplete_tasks = list.incomplete_tasks
      expect(incomplete_tasks.count).to eq(2)
      incomplete_tasks.each do |task|
        expect(task.complete).to eq(false)
      end
    end
  end

  describe '#favorite_tasks' do
    it 'should return an array of all favorite tasks' do
      list = List.create(name: "Chores")
      Task.create(favorite: true, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      favorite_tasks = list.favorite_tasks
      expect(favorite_tasks.count).to eq(1)
      favorite_tasks.each do |task|
        expect(task.favorite).to eq(true)
      end
    end
  end
end
