import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loop_record_repository_impl/loop_record_repository_impl.dart';
import 'package:loop_record_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // - Show status bar
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//  - Hide status bar
//  SystemChrome.setEnabledSystemUIOverlays([]);
//  - Change the status bar color
//  SystemChrome.setSystemUIOverlayStyle(
//      SystemUiOverlayStyle(statusBarColor: Colors.white));

  runApp(
    RecordApp(
      repository: KeyValueStorage(
        'recordApp',
        FlutterKeyValueStore(await SharedPreferences.getInstance()),
      ),
    ),
  );
}
