class TestHistory {
  final String time;
  final String result;
  final String date;

  TestHistory({required this.time, required this.result, required this.date});

  Map<String, dynamic> toJson() => {
    'time': time,
    'result': result,
    'date': date,
  };

  factory TestHistory.fromJson(Map<String, dynamic> json) => TestHistory(
    time: json['time'],
    result: json['result'],
    date: json['date'],
  );
}
