abstract class TimelineEvent {}

class GetTimeline extends TimelineEvent {
  final String employeeId;
  final String date;

  GetTimeline({required this.employeeId, required this.date});
}
