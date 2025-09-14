import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssvl_erp_system_bloc/core/utils/helper_functions.dart';

import '../../../domain/usecases/activity_usecase.dart';
import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityUseCase activityUseCase;

  ActivityBloc({required this.activityUseCase}) : super(ActivityInitial()) {
    on<GetActivity>((event, emit) async {
      emit(ActivityLoading());
      try {
        final response = await activityUseCase.getActivity(
          employeeId: event.employeeId,
          date: event.date,
        );
        if (response != null &&
            response.statusCode == 200 &&
            response.data['err'] == 'N') {
          List<dynamic> inOutList = response.data['InOut'] ?? [];
          if (inOutList.isNotEmpty) {
            List<dynamic> timings = inOutList[0]['timings'] ?? [];
            String employeeId = inOutList[0]['employeeId'] ?? '';
            Duration totalHours = timings.isNotEmpty
                ? HelperFunctions.getTotalDuration(timings)
                : Duration.zero;
            emit(
              ActivitySuccess(
                activityDataList: inOutList,
                error: response.data['err'],
                totalWorkingHours: totalHours,
                employeeId: employeeId,
              ),
            );
          } else {
            emit(ActivityError(error: 'No records found'));
          }
        } else {
          emit(ActivityError(error: response.data['err']));
        }
      } catch (e) {
        emit(ActivityError(error: e.toString()));
      }
    });

    ///Update Check In
    on<UpdateCheckIn>((event, emit) async {
      emit(ActivityLoading());
      try {
        final response = await activityUseCase.updateCheckIn(
          employeeId: event.employeeId,
          date: event.date,
          checkIn: event.checkIn,
          newCheckIn: event.newCheckIn,
        );
        if (response != null &&
            response.statusCode == 200 &&
            response.data['err'] == 'N') {
          emit(
            ActivityCheckInUpdateSuccess(
              employeeId: event.employeeId,
              date: event.date,
            ),
          );
        } else {
          emit(ActivityError(error: response.data['err']));
        }
      } catch (e) {
        emit(ActivityError(error: e.toString()));
      }
    });

    ///Update Check Out
    on<UpdateCheckOut>((event, emit) async {
      emit(ActivityLoading());
      try {
        final response = await activityUseCase.updateCheckOut(
          employeeId: event.employeeId,
          date: event.date,
          checkOut: event.checkOut,
          newCheckOut: event.newCheckOut,
        );
        if (response != null &&
            response.statusCode == 200 &&
            response.data['err'] == 'N') {
          emit(
            ActivityCheckOutUpdateSuccess(
              employeeId: event.employeeId,
              date: event.date,
            ),
          );
        } else {
          emit(ActivityError(error: response.data['err']));
        }
      } catch (e) {
        emit(ActivityError(error: e.toString()));
      }
    });
  }
}
