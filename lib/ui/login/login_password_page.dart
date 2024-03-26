import 'package:flutter/material.dart';
import 'package:vault/data/global_variables.dart';
import 'package:vault/data/user.dart';
import 'package:vault/ui/home/home_page.dart';
import 'package:vault/ui/vault_eye.dart';
import 'package:vault/ui/vault_show_snackbar.dart';

class LoginPasswordPage extends StatefulWidget {
  const LoginPasswordPage({super.key});

  @override
  State<LoginPasswordPage> createState() => _LoginPasswordPageState();
}

class _LoginPasswordPageState extends State<LoginPasswordPage> {
  final passwordController = TextEditingController();
  var obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitwarden'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Text('主密碼'),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                ),
              ),
              VaultEye(
                visible: !obscurePassword,
                onChanged: (value) => setState(() => obscurePassword = !value),
              ),
            ],
          ),
          ElevatedButton(onPressed: login, child: Text('使用主密碼登入')),
        ],
      ),
    );
  }

  void login() async {
    final password = passwordController.text;
    if (password.isEmpty) {
      vaultShowSnackBar(context, '主密碼為空', isError: true);
      return;
    }
    final got = await database.query(
      'users',
      where: 'email = ?',
      whereArgs: [currentEmail],
    );
    if (!mounted) return;
    if (got.isEmpty || password != User.fromMap(got.first).password) {
      vaultShowSnackBar(context, '電子郵件地址或主密碼錯誤', isError: true);
      return;
    }
    Navigator.of(context)
      ..pop()
      ..pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    vaultShowSnackBar(context, '登入成功。');
  }
}
