import 'package:flutter/material.dart';
import 'package:vault/data/global_variables.dart';
import 'package:vault/data/password.dart';
import 'package:vault/ui/item/item_page.dart';

class HomeVault extends StatelessWidget {
  const HomeVault({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database.query(
        'passwords',
        where: 'email = ?',
        whereArgs: [currentEmail],
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final passwords = snapshot.data!.map(Password.fromMap).toList();
        return ListView.builder(
          itemCount: passwords.length,
          itemBuilder: (context, index) => ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ItemPage(password: passwords[index]),
              ),
            ),
            title: Text(passwords[index].name),
            subtitle: passwords[index].username.isNotEmpty
                ? Text(passwords[index].username)
                : null,
          ),
        );
      },
    );
  }
}
