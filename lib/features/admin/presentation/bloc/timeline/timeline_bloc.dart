import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/timeline/timeline_event.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/timeline/timeline_state.dart';

import '../../../domain/usecases/timeline_usecase.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  final TimelineUseCase timelineUseCase;

  TimelineBloc({required this.timelineUseCase}) : super(TimelineInitial()) {
    on<GetTimeline>((event, emit) async {
      emit(TimelineLoading());
      try {
        final response = await timelineUseCase.getTimeline(
          employeeId: event.employeeId,
          date: event.date,
        );
        if (response != null && response.statusCode == 200) {
          emit(TimelineSuccess(timelineData: response.data));
        } else {
          emit(TimelineError(message: response.data['message']));
        }
      } catch (e) {
        emit(TimelineError(message: e.toString()));
      }
    });
  }
}
