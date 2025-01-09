import 'package:flutter/material.dart';
import '../models/task.dart';
import '../pages/list_page.dart';
import 'task_edit_container.dart';
import '../myFont.dart';

class TaskEditPage extends StatelessWidget {
  const TaskEditPage({
    super.key,
    required this.listPageKey,
    this.initialTask,
  });

  final GlobalKey<ListPageState> listPageKey;
  final Task? initialTask;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          builder: (BuildContext context) {
            return TaskEditContainer(
              listPageKey: listPageKey,
              initialTask: initialTask,
            );
          },
        );
      },
      child: Icon(myFont.xin_jian),
    );
  }
}