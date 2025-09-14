import 'package:ssvl_erp_system_bloc/features/admin/domain/resositories/dashboard_repository.dart';

class DashboardUseCase {
  final DashboardRepository dashboardRepository;

  DashboardUseCase(this.dashboardRepository);

  Future<dynamic> getEmployees() async {
    return await dashboardRepository.getEmployees();
  }
}
