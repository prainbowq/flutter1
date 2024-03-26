import 'package:flutter/material.dart';
import 'package:vault/ui/adding/adding_page.dart';
import 'package:vault/ui/home/home_generator.dart';
import 'package:vault/ui/home/home_vault.dart';
import 'package:vault/ui/vault_show_snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[index])),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() => index = value),
        items: List.generate(
          4,
          (i) => BottomNavigationBarItem(
            icon: Icon(icons[i]),
            label: titles[i],
          ),
        ),
      ),
      floatingActionButton: index == 0
          ? FloatingActionButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                await navigator.push(
                  MaterialPageRoute(builder: (context) => AddingPage()),
                );
                navigator.pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                if (!context.mounted) return;
                vaultShowSnackBar(context, '新增成功。');
              },
              child: Icon(Icons.add),
            )
          : null,
      body: widgets[index],
    );
  }

  static const titles = ['我的密碼庫', 'Send', '產生器', '設定'];
  static const icons = [Icons.lock, Icons.send, Icons.refresh, Icons.settings];
  static const widgets = [
    HomeVault(),
    Placeholder(),
    HomeGenerator(),
    Placeholder(),
  ];
}
