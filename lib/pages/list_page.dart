import 'package:flutter/material.dart';
import '../widgets/task_edit_container.dart';
import '../models/task.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  List<Task> tasks = [];
  final TextEditingController _deleteReasonController = TextEditingController();
  Map<Task, bool> taskCompletionState = {};

  void addTask(String fromDate, String fromTime, String toDate, String toTime, String location, String taskContent) {
    setState(() {
      tasks.add(Task(fromDate, fromTime, toDate, toTime, location, taskContent));
    });
  }

  void updateTask(Task oldTask, String fromDate, String fromTime, String toDate, String toTime, String location, String taskContent) {
    setState(() {
      int index = tasks.indexOf(oldTask);
      if (index != -1) {
        tasks[index] = Task(fromDate, fromTime, toDate, toTime, location, taskContent);
      }
    });
  }

  @override
  void dispose() {
    _deleteReasonController.dispose();
    super.dispose();
  }

  void deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: tasks.map((task) => GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              builder: (context) => TaskEditContainer(
                listPageKey: widget.key as GlobalKey<ListPageState>,
                initialTask: task,
              ),
            );
          },
          onLongPress: () {
            _deleteReasonController.clear();
            showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                  builder: (context, setState) {
                    bool canDelete = _deleteReasonController.text.trim().isNotEmpty;
                    return AlertDialog(
                      title: const Text('确认删除'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('确定要删除这个任务吗？'),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _deleteReasonController,
                            decoration: const InputDecoration(
                              labelText: '删除原因',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _deleteReasonController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text('取消'),
                        ),
                        TextButton(
                          onPressed: canDelete ? () {
                            deleteTask(task);
                            Navigator.pop(context);
                          } : null,
                          style: TextButton.styleFrom(
                            foregroundColor: canDelete ? Colors.red : Colors.grey,
                          ),
                          child: const Text('删除'),
                        ),
                      ],
                    );
                  }
              ),
            );
          },
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: taskCompletionState[task] == true ? 0.0 : 1.0,
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('开始时间: ${task.fromDate} ${task.fromTime}'),
                        Text('结束时间: ${task.toDate} ${task.toTime}'),
                        Text("地点: ${task.location}"),
                        Text("任务内容: ${task.taskContent}"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          taskCompletionState[task] = true;
                          Future.delayed(const Duration(milliseconds: 500), () {
                            setState(() {
                              tasks.remove(task);
                            });
                          });
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                          color: taskCompletionState[task] == true
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }
}