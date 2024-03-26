import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vault/data/global_variables.dart';
import 'package:vault/data/password.dart';
import 'package:vault/data/user.dart';
import 'package:vault/ui/login/login_email_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await openDatabase(
    join(await getDatabasesPath(), "vault.db"),
    onCreate: (database, version) => database
      ..execute(User.createSql)
      ..execute(Password.createSql),
    version: 1,
  );
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(VaultApp());
}

class VaultApp extends StatelessWidget {
  const VaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: LoginEmailPage(),
    );
  }
}
