pragma solidity ^0.5.0;

contract TodoList {
  uint public taskCount = 0;

  struct Task {
    uint id;
    string content;
    bool completed;
    string description;
    uint createdAt;
    uint value;
    uint dueDate;
    bool completed;
    bool cleared;
    
  }

  mapping(uint => Task) public tasks; 

  event TaskCreated(
    uint id,
    string content,
    bool completed
  );

  event TaskCompleted(
    uint id,
    bool completed
  );

  constructor() public {
    createTask("Check out");
  }

  function createTask(string memory _content) public {
    taskCount ++;
    tasks[taskCount] = Task(taskCount, _content, false);
    emit TaskCreated(taskCount, _content, false);
 }

  function toggleCompleted(uint _id) public {
    Task memory _task = tasks[_id];
    _task.completed = !_task.completed;
    tasks[_id] = _task;
    emit TaskCompleted(_id, _task.completed);
  }

    // If task is completed
  modifier completed (uint _id) {
    require(getTask(_id).completed);
    _;
  }

  // If a task is not completed
  modifier incomplete (uint _id) {
    require(!getTask(_id).completed);
    _;
  }

  // If a due date is set for task
  modifier dueIsSet (uint _id) {
    require(getTask(_id).dueDate != 0);
    _;
  }

function _remove(uint _id)
  {
    uint userTasksLength = tasks[msg.sender].length;

    require(_id < userTasksLength);

    tasks[msg.sender][_id] = tasks[msg.sender][userTasksLength - 1];
    tasks[msg.sender].pop();

    emit LogTasksUpdated();
  }


}
