import 'package:dotoon_todo_app/bloc/welcome/welcome_events.dart';
import 'package:dotoon_todo_app/bloc/welcome/welcome_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState()) {
    on<OnContinueEvent>((event, emit) async {
      emit(WelcomeLoadingState());

      try {
        final username = event.username;
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('USERNAME', username);
        await prefs.setBool('ONBOARDING', true);

        if (username.isEmpty) {
          emit(WelcomeFailureState('please enter your name'));
          return;
        }
        await Future.delayed(Duration(seconds: 1));

        emit(WelcomeSuccessState());
      } catch (e) {
        emit(WelcomeFailureState('Failed to save data: ${e.toString()}'));
      }
    });
  }
}
