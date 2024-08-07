import 'package:flutter/material.dart';
import 'package:todoey/widgets/tasks_tile.dart';
import 'package:todoey/models/task_data.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemCount: taskData.taskCount,
          itemBuilder: (context, int index) {
            return TaskTile(
              isChecked: taskData.getTasks[index].isDone,
              taskTitle: taskData.getTasks[index].name,
              checkboxCallback: (checkboxState) {
                // setState(() {
                //   Provider.of<TaskData>(context).tasks[index].toggleDone();
                // });
                Provider.of<TaskData>(context, listen: false)
                    .updateTask(taskData.getTasks[index]);
              },
              longPressCallback: () {
                showDialog(
                  //if set to true allow to close popup by tapping out of the popup
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text("Confirm"),
                    content: Text("Are you want to delete?"),
                    actions: [
                      TextButton(
                        child: Text("Yes"),
                        onPressed: () {
                          Provider.of<TaskData>(context, listen: false)
                              .deleteTask(taskData.getTasks[index]);
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                    elevation: 24,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
