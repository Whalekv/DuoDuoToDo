class Task {
  final int? id;
  String fromDate;
  String fromTime;
  String toDate;
  String toTime;
  String location;
  String taskContent;

  Task({
    this.id,
    required this.fromDate,
    required this.fromTime,
    required this.toDate,
    required this.toTime,
    required this.location,
    required this.taskContent,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromDate': fromDate,
      'fromTime': fromTime,
      'toDate': toDate,
      'toTime': toTime,
      'location': location,
      'taskContent': taskContent,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      fromDate: map['fromDate'] as String,
      fromTime: map['fromTime'] as String,
      toDate: map['toDate'] as String,
      toTime: map['toTime'] as String,
      location: map['location'] as String,
      taskContent: map['taskContent'] as String,
    );
  }
}