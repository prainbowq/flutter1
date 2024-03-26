import 'package:flutter/material.dart';
import 'package:vault/data/global_variables.dart';
import 'package:vault/data/user.dart';
import 'package:vault/ui/vault_eye.dart';
import 'package:vault/ui/vault_show_snackbar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final hintController = TextEditingController();
  var agree = false;
  var obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('建立帳戶'),
        actions: [
          TextButton(
            onPressed: signUp,
            child: Text('送出', style: TextStyle(color: Colors.white)),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Text('電子郵件地址'),
          TextField(controller: emailController),
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
          Text('再次輸入主密碼'),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: confirmController,
                  obscureText: obscurePassword,
                ),
              ),
              VaultEye(
                visible: !obscurePassword,
                onChanged: (value) => setState(() => obscurePassword = !value),
              ),
            ],
          ),
          Text('主密碼提示（可省略）'),
          TextField(controller: hintController),
          Row(
            children: [
              Switch(
                value: agree,
                onChanged: (value) => setState(() => agree = value),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('開啟此開關代表您同意下列項目：'),
                  Row(
                    children: [
                      Text('服務條款', style: TextStyle(color: Colors.blue)),
                      Text(', '),
                      Text('隱私權政策', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void signUp() async {
    if (!agree) {
      vaultShowSnackBar(context, '未同意服務條款及隱私權政策', isError: true);
      return;
    }
    final email = emailController.text;
    final password = passwordController.text;
    final confirm = confirmController.text;
    final hint = hintController.text;
    if (email.isEmpty) {
      vaultShowSnackBar(context, '電子郵件地址為空', isError: true);
      return;
    }
    if (password.isEmpty) {
      vaultShowSnackBar(context, '主密碼為空', isError: true);
      return;
    }
    if (confirm != password) {
      vaultShowSnackBar(context, '確認密碼不符', isError: true);
      return;
    }
    final got = await database.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (got.isNotEmpty && mounted) {
      vaultShowSnackBar(context, '此帳號已存在', isError: true);
      return;
    }
    await database.insert(
      'users',
      User(
        email: email,
        password: password,
        hint: hint,
      ).toMap(),
    );
    if (!mounted) return;
    Navigator.of(context).pop();
    vaultShowSnackBar(context, '帳號建立成功。');
  }
}
