class EmployeeModel {
  final String sId;
  final String employeeId;
  final String name;
  final String mobileNo;
  final String email;
  final String password;
  final String date;

  EmployeeModel({
    required this.sId,
    required this.employeeId,
    required this.name,
    required this.mobileNo,
    required this.email,
    required this.password,
    required this.date,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      sId: json['_id'],
      employeeId: json['employeeId'],
      name: json['name'],
      mobileNo: json['mobileNo'],
      email: json['email'],
      password: json['password'],
      date: json['date'],
    );
  }
}
