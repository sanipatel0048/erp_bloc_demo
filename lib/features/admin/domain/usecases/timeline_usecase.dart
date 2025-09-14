import 'package:ssvl_erp_system_bloc/features/admin/domain/resositories/timeline_repository.dart';

class TimelineUseCase {
  final TimelineRepository timelineRepository;

  TimelineUseCase(this.timelineRepository);

  Future<dynamic> getTimeline({
    required String employeeId,
    required String date,
  }) async {
    return await timelineRepository.getTimeline(
      employeeId: employeeId,
      date: date,
    );
  }
}
