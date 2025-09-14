abstract class TimelineRepository {
  Future<dynamic> getTimeline({
    required String employeeId,
    required String date,
  });
}
