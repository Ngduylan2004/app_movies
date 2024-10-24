part of 'home_bloc.dart';

sealed class HomeEvent {}

class NavigatorPage extends HomeEvent {
  final int index;

  NavigatorPage(this.index);
}
