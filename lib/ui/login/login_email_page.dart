import 'package:flutter/material.dart';
import 'package:vault/data/global_variables.dart';
import 'package:vault/ui/login/login_password_page.dart';
import 'package:vault/ui/signup/signup_page.dart';
import 'package:vault/ui/vault_show_snackbar.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({super.key});

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  final emailController = TextEditingController();
  var remember = false;

  @override
  void initState() {
    super.initState();
    final got = sharedPreferences.getString('rememberedEmail');
    if (got != null) {
      emailController.text = got;
      remember = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bitwarden')),
      body: ListView(
        children: [
          Text('電子郵件地址'),
          TextField(controller: emailController),
          Row(
            children: [
              Expanded(child: Text('記住我')),
              Switch(
                value: remember,
                onChanged: (value) => setState(() => remember = value),
              ),
            ],
          ),
          ElevatedButton(onPressed: continue_, child: Text('繼續')),
          Row(
            children: [
              Text('第一次使用？'),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignupPage()),
                ),
                child: Text('建立帳戶'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void continue_() {
    currentEmail = emailController.text;
    if (currentEmail.isEmpty) {
      vaultShowSnackBar(context, '電子郵件地址為空', isError: true);
      return;
    }
    if (remember) {
      sharedPreferences.setString('rememberedEmail', currentEmail);
    } else {
      sharedPreferences.remove('rememberedEmail');
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoginPasswordPage()),
    );
  }
}
