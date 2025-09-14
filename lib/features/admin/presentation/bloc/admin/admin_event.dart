import 'package:flutter/cupertino.dart';

abstract class AdminEvent {}

class ChangePageEvent extends AdminEvent {
  final int index;

  ChangePageEvent(this.index);
}

class LogoutEvent extends AdminEvent {
  final BuildContext context;

  LogoutEvent({required this.context});
}
