import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermission() async {
  final status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
  }
}