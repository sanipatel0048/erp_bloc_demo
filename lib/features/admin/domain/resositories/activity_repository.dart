abstract class ActivityRepository {
  Future<dynamic> getActivity({
    required String employeeId,
    required String date,
  });

  Future<dynamic> updateCheckIn({
    required String employeeId,
    required String date,
    required String checkIn,
    required String newCheckIn,
  });

  Future<dynamic> updateCheckout({
    required String employeeId,
    required String date,
    required String checkOut,
    required String newCheckOut,
  });
}
