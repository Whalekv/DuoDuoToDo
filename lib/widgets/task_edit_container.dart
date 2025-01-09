import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../pages/list_page.dart';

class TaskEditContainer extends StatefulWidget {
  const TaskEditContainer({
    super.key,
    required this.listPageKey,
    this.initialTask,
  });

  final GlobalKey<ListPageState> listPageKey;
  final Task? initialTask;

  @override
  State<TaskEditContainer> createState() => _TaskEditContainerState();
}

class _TaskEditContainerState extends State<TaskEditContainer> {
  DateTime? fromSelectedDate;
  DateTime? fromSelectedTime;
  DateTime? toSelectedDate;
  DateTime? toSelectedTime;

  final TextEditingController taskController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialTask != null) {
      fromSelectedDate = DateFormat('yyyy-MM-dd').parse(widget.initialTask!.fromDate);
      fromSelectedTime = DateFormat('HH:mm').parse(widget.initialTask!.fromTime);
      toSelectedDate = DateFormat('yyyy-MM-dd').parse(widget.initialTask!.toDate);
      toSelectedTime = DateFormat('HH:mm').parse(widget.initialTask!.toTime);
      locationController.text = widget.initialTask!.location;
      taskController.text = widget.initialTask!.taskContent;
    } else {
      fromSelectedDate = DateTime.now().toUtc().add(const Duration(hours: 8));
      toSelectedDate = DateTime.now().toUtc().add(const Duration(hours: 8));
      fromSelectedTime = DateTime.now().toUtc().add(const Duration(hours: 8));
      toSelectedTime = DateTime.now().toUtc().add(const Duration(hours: 8));
    }
  }

  void adjustEndTime() {
    if (fromSelectedTime != null && toSelectedTime != null) {
      if (toSelectedTime!.isBefore(fromSelectedTime!) &&
          fromSelectedDate!.year == toSelectedDate!.year &&
          fromSelectedDate!.month == toSelectedDate!.month &&
          fromSelectedDate!.day == toSelectedDate!.day) {
        toSelectedDate = DateTime(
          fromSelectedDate!.year,
          fromSelectedDate!.month,
          fromSelectedDate!.day + 1,
        );
      }
    }
  }

  void adjustEndDate(DateTime newFromDate) {
    if (toSelectedDate != null && toSelectedDate!.isBefore(newFromDate)) {
      toSelectedDate = DateTime(
        newFromDate.year,
        newFromDate.month,
        newFromDate.day,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                String taskContent = taskController.text;
                String location = locationController.text;
                if (widget.initialTask != null) {
                  widget.listPageKey.currentState?.updateTask(
                      widget.initialTask!,
                      DateFormat('yyyy-MM-dd').format(fromSelectedDate!),
                      DateFormat('HH:mm').format(fromSelectedTime!),
                      DateFormat('yyyy-MM-dd').format(toSelectedDate!),
                      DateFormat('HH:mm').format(toSelectedTime!),
                      location,
                      taskContent
                  );
                } else {
                  widget.listPageKey.currentState?.addTask(
                      DateFormat('yyyy-MM-dd').format(fromSelectedDate!),
                      DateFormat('HH:mm').format(fromSelectedTime!),
                      DateFormat('yyyy-MM-dd').format(toSelectedDate!),
                      DateFormat('HH:mm').format(toSelectedTime!),
                      location,
                      taskContent
                  );
                }
              },
              child: Text('保存'),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
            children: [
            SizedBox(width: 10),
        Text("从:", style: TextStyle(fontSize: 20)),
        SizedBox(width: 10),
        Card(
        color: Theme.of(context).colorScheme.inversePrimary,
    child: TextButton(
    onPressed: () async {
    final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: fromSelectedDate!,
    firstDate: DateTime(2024),
    lastDate: DateTime(2100),
    );
    if (picked != null) {
    setState(() {
    fromSelectedDate = picked;
    adjustEndDate(picked);
    adjustEndTime();
    });
    }
    },
    child: Text(
    DateFormat('yyyy-MM-dd').format(fromSelectedDate!),
    style: TextStyle(fontSize: 25),
    ),
    ),
        ),
              SizedBox(width: 20),
              Card(
                color: Theme.of(context).colorScheme.inversePrimary,
                child: TextButton(
                  onPressed: () async {
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(fromSelectedTime!),
                    );
                    if (time != null) {
                      setState(() {
                        fromSelectedTime = DateTime(
                            2024, 1, 1, time.hour, time.minute);
                        adjustEndTime();
                      });
                    }
                  },
                  child: Text(
                    DateFormat('HH:mm').format(fromSelectedTime!),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ],
        ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10),
                Text("到:", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10),
                Card(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  child: TextButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: toSelectedDate!,
                        firstDate: fromSelectedDate!,
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          toSelectedDate = picked;
                          adjustEndTime();
                        });
                      }
                    },
                    child: Text(
                      DateFormat('yyyy-MM-dd').format(toSelectedDate!),
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Card(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  child: TextButton(
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(toSelectedTime!),
                      );
                      if (time != null) {
                        setState(() {
                          toSelectedTime = DateTime(
                              2024, 1, 1, time.hour, time.minute);
                          adjustEndTime();
                        });
                      }
                    },
                    child: Text(
                      DateFormat('HH:mm').format(toSelectedTime!),
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: '地点',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: taskController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: '任务',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.mic),
              ),
            ),
          ],
        ),
    );
  }
}