abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivitySuccess extends ActivityState {
  final String error;
  final List<dynamic> activityDataList;

  final Duration? totalWorkingHours;

  final String employeeId;

  ActivitySuccess({
    required this.error,
    required this.activityDataList,
    required this.totalWorkingHours,
    required this.employeeId,
  });
}

class ActivityError extends ActivityState {
  final String error;

  ActivityError({required this.error});
}

class ActivityCheckInUpdateSuccess extends ActivityState {
  final String employeeId;
  final String date;

  ActivityCheckInUpdateSuccess({required this.employeeId, required this.date});
}

class ActivityCheckOutUpdateSuccess extends ActivityState {
  final String employeeId;
  final String date;

  ActivityCheckOutUpdateSuccess({required this.employeeId, required this.date});
}
