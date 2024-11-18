import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(0)) {
    on<HomeEvent>((event, emit) {
      on<NavigatorPage>((event, emit) {
        emit(HomeState(event.index));
      });
    });
  }
}
