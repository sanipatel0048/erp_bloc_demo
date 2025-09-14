import '../resositories/activity_repository.dart';

class ActivityUseCase {
  final ActivityRepository activityRepository;

  ActivityUseCase(this.activityRepository);

  Future<dynamic> getActivity({
    required String employeeId,
    required String date,
  }) async {
    return await activityRepository.getActivity(
      employeeId: employeeId,
      date: date,
    );
  }

  Future<dynamic> updateCheckIn({
    required String employeeId,
    required String date,
    required String checkIn,
    required String newCheckIn,
  }) async {
    return await activityRepository.updateCheckIn(
      employeeId: employeeId,
      date: date,
      checkIn: checkIn,
      newCheckIn: newCheckIn,
    );
  }

  Future<dynamic> updateCheckOut({
    required String employeeId,
    required String date,
    required String checkOut,
    required String newCheckOut,
  }) async {
    return await activityRepository.updateCheckout(
      employeeId: employeeId,
      date: date,
      checkOut: checkOut,
      newCheckOut: newCheckOut,
    );
  }
}
