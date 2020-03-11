import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {

   Future<bool> isCameraPermissionGranted() async {
     PermissionStatus permissionCamera = await PermissionHandler()
         .checkPermissionStatus(PermissionGroup.camera);
     print(permissionCamera == PermissionStatus.granted);
     return permissionCamera == PermissionStatus.granted;
   }

   Future<Null> requestCameraPermission() async {
     /*List<PermissionGroup> askPermissionList = List<PermissionGroup>();
     Map<PermissionGroup, PermissionStatus> permissions =
                await PermissionHandler().requestPermiss  ions([PermissionGroup.camera]);*/

     ServiceStatus serviceStatus = await PermissionHandler().checkServiceStatus(PermissionGroup.camera);
     print(serviceStatus);
   }
}