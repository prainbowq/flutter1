import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vault/data/global_variables.dart';
import 'package:vault/data/password.dart';
import 'package:vault/ui/generator/generator_page.dart';
import 'package:vault/ui/home/home_page.dart';
import 'package:vault/ui/vault_eye.dart';
import 'package:vault/ui/vault_show_snackbar.dart';

class AddingPage extends StatefulWidget {
  const AddingPage({super.key, this.password});

  final Password? password;

  @override
  State<AddingPage> createState() => _AddingPageState();
}

class _AddingPageState extends State<AddingPage> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var obscurePassword = true;

  @override
  void initState() {
    super.initState();
    if (widget.password != null) {
      nameController.text = widget.password!.name;
      usernameController.text = widget.password!.username;
      passwordController.text = widget.password!.password;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.password == null ? '新增項目' : '編輯項目'),
        actions: [
          TextButton(
            onPressed: save,
            child: Text('儲存', style: TextStyle(color: Colors.white)),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Text('名稱'),
          TextField(controller: nameController),
          Text('使用者名稱'),
          TextField(controller: usernameController),
          Text('密碼'),
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
              IconButton(
                onPressed: () async {
                  final got = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GeneratorPage()),
                  ) as String;
                  passwordController.text = got;
                },
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void save() async {
    final name = nameController.text;
    final username = usernameController.text;
    final password = passwordController.text;
    if (name.isEmpty) {
      vaultShowSnackBar(context, '名稱為空', isError: true);
      return;
    }
    await database.insert(
      'passwords',
      Password(
        id: widget.password?.id,
        email: currentEmail,
        name: name,
        username: username,
        password: password,
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
