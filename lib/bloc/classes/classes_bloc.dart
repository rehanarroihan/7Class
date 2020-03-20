import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sevenclass/models/default_model.dart';
import 'package:sevenclass/services/classes_service.dart';
import 'package:sevenclass/services/permission_handler_service.dart';

import './bloc.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  ClassesServices _classesServices = ClassesServices();

  PermissionHandlerService _permissionHandlerService = PermissionHandlerService();
  bool isCameraPermissionGranted = false;
  bool isClassCodeValid = false;

  bool isEnrollLoading = false;

  @override
  ClassesState get initialState => InitialClassesState();

  @override
  Stream<ClassesState> mapEventToState(ClassesEvent event) async* {
    if (event is IsCameraPermissionGrantedEvent) {
      yield* _checkCameraPermission();
    } else if (event is RequestPermissionEvent) {
      yield* _requestCameraPermission();
    } else if (event is ClassCodeValidEvent) {
      yield* _toggleClassCodeValid(event);
    } else if (event is EnrollClassEvent) {
      yield* _enrollClass(event);
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

  Stream<ClassesState> _toggleClassCodeValid(ClassCodeValidEvent event) async* {
    yield InitialClassesState();
    this.isClassCodeValid = event.isClassCodeValid;
    yield ClassCodeValidState();
  }

  Stream<ClassesState> _enrollClass(EnrollClassEvent event) async* {
    this.isEnrollLoading = true;
    yield InitialClassesState();

    Map<String, dynamic> payload = {
      "class_code": event.classCode
    };
    DefaultModel response = await _classesServices.classEnroll(payload);
    this.isEnrollLoading = false;
    if (!response.success) {
      if (response.message == "Already joined") {
        yield EnrollClassJoinedState();
      } else if (response.message == "Class not found") {
        yield EnrollClassNotFoundState();
      } else {
        yield EnrollClassFailedState(
          message: response.message
        );
      }
    } else {
      yield EnrollClassResultState();
    }
  }
}
