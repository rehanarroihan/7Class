abstract class SplashEvent {}

class CheckUserConditionEvent extends SplashEvent {
  @override
  String toString() => 'CheckUserConditionEvent';
}

class ClearFirstTimeConditionEvent extends SplashEvent {
  @override
  String toString() => 'ClearFirstTimeConditionEvent';
}

class SetIntroCurrentPageEvent extends SplashEvent {
  int page;

  SetIntroCurrentPageEvent(this.page);

  @override
  String toString() => 'SetIntroCurrentPageEvent';
}