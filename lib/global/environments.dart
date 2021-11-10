import 'dart:io';

class Environments {
  static String serverUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://127.0.0.1:3000';
}
