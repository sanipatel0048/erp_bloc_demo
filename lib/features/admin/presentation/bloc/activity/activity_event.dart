abstract class ActivityEvent {}

class GetActivity extends ActivityEvent {
  final String employeeId;
  final String date;

  GetActivity({required this.employeeId, required this.date});
}

class UpdateCheckIn extends ActivityEvent {
  final String employeeId;
  final String date;
  final String checkIn;
  final String newCheckIn;

  UpdateCheckIn({
    required this.employeeId,
    required this.date,
    required this.checkIn,
    required this.newCheckIn,
  });
}

class UpdateCheckOut extends ActivityEvent {
  final String employeeId;
  final String date;
  final String checkOut;
  final String newCheckOut;

  UpdateCheckOut({
    required this.employeeId,
    required this.date,
    required this.checkOut,
    required this.newCheckOut,
  });
}
