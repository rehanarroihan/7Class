import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(bloc.toString() + " " + event.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print(bloc.toString() + " " + error.toString());
    print(stacktrace.toString());
    super.onError(bloc, error, stacktrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(bloc.toString() + " " + transition.toString());
    super.onTransition(bloc, transition);
  }
}
