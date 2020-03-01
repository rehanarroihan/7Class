abstract class SplashEvent {}

class CheckUserConditionEvent extends SplashEvent {
  @override
  String toString() => 'CheckUserConditionEvent';
}

class ClearFirstTimeConditionEvent extends SplashEvent {
  @override
  String toString() => 'ClearFirstTimeConditionEvent';
}
