import 'package:flutter/material.dart';
import 'package:vault/data/global_variables.dart';
import 'package:vault/data/password.dart';
import 'package:vault/ui/adding/adding_page.dart';
import 'package:vault/ui/vault_copy.dart';
import 'package:vault/ui/vault_eye.dart';
import 'package:vault/ui/vault_show_snackbar.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key, required this.password});

  final Password password;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var obscurePassword = true;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.password.name;
    usernameController.text = widget.password.username;
    passwordController.text = widget.password.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('檢視項目'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddingPage(password: widget.password),
            ),
          );
          final got = await database.query(
            'passwords',
            where: 'id = ?',
            whereArgs: [widget.password.id],
          );
          if (!context.mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ItemPage(
                password: Password.fromMap(got.first),
              ),
            ),
          );
          vaultShowSnackBar(context, '編輯成功。');
        },
        child: Icon(Icons.edit),
      ),
      body: ListView(
        children: [
          Text('名稱'),
          TextField(controller: nameController, enabled: false),
          Text('使用者名稱'),
          TextField(controller: usernameController, enabled: false),
          Text('密碼'),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  enabled: false,
                ),
              ),
              VaultEye(
                visible: !obscurePassword,
                onChanged: (value) => setState(() => obscurePassword = !value),
              ),
              VaultCopy(text: passwordController.text),
            ],
          ),
        ],
      ),
    );
  }
}
