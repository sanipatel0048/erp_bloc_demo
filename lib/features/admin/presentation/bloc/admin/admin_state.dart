abstract class AdminState {}

class AdminInitial extends AdminState {}

class PageChanged extends AdminState {
  final int currentIndex;

  PageChanged(this.currentIndex);
}

class LogoutSuccess extends AdminState{

}

