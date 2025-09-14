import 'package:flutter/material.dart';

abstract class EmployeeEvent {}

class PageChangeEvent extends EmployeeEvent {
  final int index;

  PageChangeEvent(this.index);
}

class LogoutEvent extends EmployeeEvent {
  final BuildContext context;

  LogoutEvent({required this.context});
}
