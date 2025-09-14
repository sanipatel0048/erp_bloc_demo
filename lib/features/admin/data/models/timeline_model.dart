class Timeline {
  String? employeeId;
  String? date;
  String? totalWorkingHours;
  String? employeeName;

  Timeline({this.employeeId, this.date, this.totalWorkingHours});

  Timeline.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    date = json['date'];
    totalWorkingHours = json['totalWorkingHours'];
    employeeName = json['employeeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeId'] = employeeId;
    data['date'] = date;
    data['totalWorkingHours'] = totalWorkingHours;
    data['employeeName'] = employeeName;
    return data;
  }
}
