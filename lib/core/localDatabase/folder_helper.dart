import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:to_do_list/core/utils/design_utils.dart';

class Folder{

  Future<Directory> createDir() async {
    PermissionStatus status = await Permission.storage.status;
    Directory? dir;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if(Platform.isAndroid){
      dir = await getExternalStorageDirectory();
    }else if(Platform.isIOS){
      dir = await getApplicationDocumentsDirectory();
    }
    return dir!;
  }
  Future<String> createDBDirectory() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    String path = (await getApplicationDocumentsDirectory()).path;
    String savePath = '$path/$dbName';
    print("Database save path: $savePath");
    return savePath;
  }

  Future<String> getDBDirectoryPath() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    String savePath = '$path/$dbName';
    print("Database save path: $savePath");
    return savePath;
  }


}
