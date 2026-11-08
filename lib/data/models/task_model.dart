/// Represents a scheduled task item.
class Task {
  int? id;
  String? title;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  int? isCompleted;

  Task({
    this.id,
    this.title,
    this.note,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
    this.isCompleted,
  });

  /// Factory constructor to deserialize from Map (e.g. SQLite / JSON).
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int?,
      title: json['title'] as String?,
      note: json['note'] as String?,
      date: json['date'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      color: json['color'] as int?,
      remind: json['remind'] as int?,
      repeat: json['repeat'] as String?,
      isCompleted: json['isCompleted'] as int?,
    );
  }

  /// Converts the instance to Map for database storage and JSON serialization.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['color'] = color;
    data['remind'] = remind;
    data['repeat'] = repeat;
    data['isCompleted'] = isCompleted;
    return data;
  }

  /// Creates a copy of this task with modified fields.
  Task copyWith({
    int? id,
    String? title,
    String? note,
    String? date,
    String? startTime,
    String? endTime,
    int? color,
    int? remind,
    String? repeat,
    int? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      remind: remind ?? this.remind,
      repeat: repeat ?? this.repeat,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, date: $date, startTime: $startTime, endTime: $endTime, isCompleted: $isCompleted)';
  }
}
