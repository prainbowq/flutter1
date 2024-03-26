import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

late final Database database;
late final SharedPreferences sharedPreferences;
late String currentEmail;
late String currentPassword;
