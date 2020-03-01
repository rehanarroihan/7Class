abstract class SplashState {}

class SplashInit extends SplashState {}

class InitialSplashState extends SplashState {
  @override
  List<Object> get props => [];
}

class LaunchedFirstTime extends SplashState {}

class Authenticated extends SplashState {}

class NotAuthenticated extends SplashState {}

class ClearFirstTimeConditionState extends SplashState {}

class SetIntroCurrentPageState extends SplashState {
  int page;

  SetIntroCurrentPageState(this.page);
}