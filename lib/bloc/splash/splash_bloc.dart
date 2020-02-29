import 'package:bloc/bloc.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

import '../../app.dart';
import 'bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  @override
  // TODO: implement initialState
  SplashState get initialState => InitialSplashState();

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is LoadAuthData) {
      yield AuthDataLoading();

      String isLoggedIn = App().sharedPreferences.get(ConstantHelper.IS_LOGGED_IN_PREF);

      yield NotAuthenticated();
    }
  }

}