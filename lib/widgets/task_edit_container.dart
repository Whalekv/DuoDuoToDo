import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
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
  //任务
  final TextEditingController locationController = TextEditingController();
  //地点
  final TextEditingController taskController = TextEditingController();


  //初始化
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
    //当from和to日期相等，但from的时间小于to的时间时，to的日期要+1
    if ((toSelectedTime!.hour < fromSelectedTime!.hour ||
        (toSelectedTime!.hour == fromSelectedTime!.hour &&
            toSelectedTime!.minute < fromSelectedTime!.minute))&&
        fromSelectedDate!.year == toSelectedDate!.year &&
        fromSelectedDate!.month == toSelectedDate!.month &&
        fromSelectedDate!.day == toSelectedDate!.day)
    {
      toSelectedDate = toSelectedDate!.add(Duration(days: 1)); // 保留时间部分
      print("to+1被执行");
    }
  }
  //当from和to日期相等时，调节from的时间，使from的时间大于to的时间时，使to的时间等于from的时间
  void toTimeEqualFromTime(){
    if ((toSelectedTime!.hour < fromSelectedTime!.hour ||
        (toSelectedTime!.hour == fromSelectedTime!.hour &&
            toSelectedTime!.minute < fromSelectedTime!.minute))&&
        fromSelectedDate!.year == toSelectedDate!.year &&
        fromSelectedDate!.month == toSelectedDate!.month &&
        fromSelectedDate!.day == toSelectedDate!.day)
    {
      toSelectedTime = fromSelectedTime;

    }
  }

  //先设置from的日期时，使to的日期始终>=from的日期
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
            //取消、保存按钮
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String taskContent = taskController.text;
                  String location = locationController.text;
                  //按保存按钮时，内容不为空是修改任务，内容为空是增加任务
                  if (widget.initialTask != null) {
                    await widget.listPageKey.currentState?.updateTask(
                        widget.initialTask!,
                        DateFormat('yyyy-MM-dd').format(fromSelectedDate!),
                        DateFormat('HH:mm').format(fromSelectedTime!),
                        DateFormat('yyyy-MM-dd').format(toSelectedDate!),
                        DateFormat('HH:mm').format(toSelectedTime!),
                        location,
                        taskContent
                    );
                  } else {
                    await widget.listPageKey.currentState?.addTask(
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
            //from日期和时间设置
            Row(
            children: [
            SizedBox(width: 10),
            Text("从:", style: TextStyle(fontSize: 20)),
            SizedBox(width: 10),
            //from日期
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
            //from时间
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
                      fromSelectedTime = DateTime(2024, 1, 1, time.hour, time.minute);
                      toTimeEqualFromTime();
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
            //to日期和时间设置
            Row(
              children: [
                SizedBox(width: 10),
                Text("到:", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10),
                //to日期
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

                          toSelectedTime = DateTime(2024, 1, 1, time.hour, time.minute);
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