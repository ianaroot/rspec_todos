require "rspec"

require_relative "list"
require_relative "task"

describe List do
  # Your specs here
  let(:task0) { Task.new("drink honey") }
  let(:task1) { Task.new("design final pitch") }
  let(:task2) { Task.new("find job") }
  let(:list) { List.new("spec_list", [task0, task1, task2] ) }

  describe "#initialize" do
    it "takes a title for it's first argument" do
      List.new("beards").should be_an_instance_of List
    end

    it "requires one argument" do
      expect { List.new }.to raise_error(ArgumentError)
    end

    it "accepts an optional array of tasks for it's second argument" do
      List.new("spec_list", [Task.new("drink honey"), Task.new("design final pitch"), Task.new("find job") ] ).should be_an_instance_of List
    end
  end

  describe "#add_task" do

    it "should add one task to the lists tasks array" do
      expect { list.add_task(Task.new("sake bombing") ) }.to change{ list.tasks.count }.by(1)
    end

    it "should cause task to persist as attribute of list" do
      list.add_task(Task.new("kill pigeon"))
      list.tasks.last.description == "kill pigeon"
    end
  end

  describe "#complete_task" do
    it "should require one argument" do
      expect{ list.complete_task }.to raise_error(ArgumentError)
    end

    it "should complete a task" do
      list.complete_task(0)
      list.tasks[0].should be_complete
    end
  end

  describe "#delete_task" do
    it "should delete the task" do
      expect{ list.delete_task(0) }.to change{ list.tasks.count }.by(-1)
    end

    it "should require an argument" do
      expect{ list.delete_task }.to raise_error(ArgumentError)
    end
  end

  describe "#completed_tasks" do
    it "should return an array of tasks" do
      list.complete_task(1)
      list.completed_tasks.first.should be_an_instance_of Task
    end

    it "should only return only completed tasks" do
      list.complete_task(0)
      list.completed_tasks.should eql [task0]
    end
  end

  describe "#incomplete_tasks" do
    it "should return an array of tasks" do
      list.incomplete_tasks.first.should be_an_instance_of Task
    end

    it "should return only incomplete tasks" do
      list.complete_task(0)
      list.incomplete_tasks.should_not include(task0)
    end
  end
end