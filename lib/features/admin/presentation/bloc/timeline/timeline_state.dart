abstract class TimelineState {}

class TimelineInitial extends TimelineState {}

class TimelineLoading extends TimelineState {}

class TimelineSuccess extends TimelineState {
  final List<dynamic> timelineData;

  TimelineSuccess({required this.timelineData});
}

class TimelineError extends TimelineState {
  final String message;

  TimelineError({this.message = 'Something went wrong'});
}
