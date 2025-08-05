abstract class WelcomeEvent {}

final class OnContinueEvent extends WelcomeEvent {
  final String username;

  OnContinueEvent({required this.username});
}
