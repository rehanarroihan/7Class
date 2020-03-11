import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sevenclass/services/permission_handler_service.dart';

import './bloc.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  PermissionHandlerService _permissionHandlerService = PermissionHandlerService();
  bool isCameraPermissionGranted = false;

  @override
  ClassesState get initialState => InitialClassesState();

  @override
  Stream<ClassesState> mapEventToState(ClassesEvent event) async* {
    if (event is IsCameraPermissionGrantedEvent) {
      yield* _checkCameraPermission();
    } else if (event is RequestPermissionEvent) {
      yield* _requestCameraPermission();
    }
  }

  Stream<ClassesState> _checkCameraPermission() async* {
    yield InitialClassesState();
    this.isCameraPermissionGranted = await _permissionHandlerService
        .isCameraPermissionGranted();
    yield IsCameraPermissionGrantedState();
  }

  Stream<ClassesState> _requestCameraPermission() async* {
    yield InitialClassesState();
    await _permissionHandlerService.requestCameraPermission();
    yield IsCameraPermissionGrantedState();
  }
}
