import 'dart:io';

import 'package:flutter/material.dart';


  Future<bool> internetIsAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('Internet connection result: $result');
        return true;
      }
    } on SocketException catch (exception) {
      debugPrint('Internet connection exception: $exception');
      return false;
    }
    return false;
  }

