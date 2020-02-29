abstract class SplashState {}

class SplashInit extends SplashState {}

class InitialSplashState extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashStart extends SplashState {}

class AuthDataLoading extends SplashState {}

class Authenticated extends SplashState {}

class NotAuthenticated extends SplashState {}