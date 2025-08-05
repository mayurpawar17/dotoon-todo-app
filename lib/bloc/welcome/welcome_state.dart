abstract class WelcomeState {}

final class WelcomeInitialState extends WelcomeState {}

final class WelcomeLoadingState extends WelcomeState {}

final class WelcomeSuccessState extends WelcomeState {}

final class WelcomeFailureState extends WelcomeState {
  final String error;

  WelcomeFailureState(this.error);
}
