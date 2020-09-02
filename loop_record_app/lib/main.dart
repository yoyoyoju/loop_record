import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loop_record_repository_impl/loop_record_repository_impl.dart';
import 'package:loop_record_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(
    RecordApp(
      repository: KeyValueStorage(
        'recordApp',
        FlutterKeyValueStore(await SharedPreferences.getInstance()),
      ),
    ),
  );
}
