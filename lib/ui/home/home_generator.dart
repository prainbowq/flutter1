import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vault/data/global_variables.dart';
import 'package:vault/data/user.dart';

class HomeGenerator extends StatefulWidget {
  const HomeGenerator({super.key, this.onGenerate});

  final ValueChanged<String>? onGenerate;

  @override
  State<HomeGenerator> createState() => _HomeGeneratorState();
}

class _HomeGeneratorState extends State<HomeGenerator> {
  String? result;
  late int length;
  late bool uppercase;
  late bool lowercase;
  late bool numbers;
  late bool special;
  late User user;

  @override
  void initState() {
    super.initState();
    database.query(
      'users',
      where: 'email = ?',
      whereArgs: [currentEmail],
    ).then((value) {
      user = User.fromMap(value.first);
      length = user.length;
      uppercase = user.uppercase;
      lowercase = user.lowercase;
      numbers = user.numbers;
      special = user.special;
      generate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return result != null
        ? ListView(
            children: [
              Text(result!),
              Row(
                children: [
                  Text('長度'),
                  SizedBox(width: 50),
                  Text(length.toString()),
                  Expanded(
                    child: Slider(
                      value: length.toDouble(),
                      onChanged: (value) {
                        setState(() => length = value.round());
                        generate();
                      },
                      min: 5,
                      max: 128,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(child: Text('A-Z')),
                  Text('大寫 (A-Z)'),
                  Switch(
                    value: uppercase,
                    onChanged: (value) {
                      setState(() => uppercase = value);
                      generate();
                    },
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(child: Text('a-z')),
                  Text('小寫 (a-z)'),
                  Switch(
                    value: lowercase,
                    onChanged: (value) {
                      setState(() => lowercase = value);
                      generate();
                    },
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(child: Text('0-9')),
                  Text('數字 (0-9)'),
                  Switch(
                    value: numbers,
                    onChanged: (value) {
                      setState(() => numbers = value);
                      generate();
                    },
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(child: Text('!@#\$%^&*')),
                  Text('特殊字元 (!@#\$%^&*)'),
                  Switch(
                    value: special,
                    onChanged: (value) {
                      setState(() => special = value);
                      generate();
                    },
                  ),
                ],
              ),
              Divider(),
            ],
          )
        : CircularProgressIndicator();
  }

  void generate() {
    const uppercaseString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const lowercaseString = "abcdefghijklmnopqrstuvwxyz";
    const numbersString = '0123456789';
    const specialString = '!@#\$%^&*';
    final random = Random();
    pick(String string) => string[random.nextInt(string.length)];
    if (!uppercase && !lowercase && !numbers && !special) {
      setState(() => lowercase = true);
    }
    database.update(
      'users',
      User(
        email: user.email,
        password: user.password,
        hint: user.hint,
        length: length,
        uppercase: uppercase,
        lowercase: lowercase,
        numbers: numbers,
        special: special,
      ).toMap(),
      where: 'email = ?',
      whereArgs: [user.email],
    );
    var newResult = '';
    while (newResult.length < length) {
      switch (random.nextInt(4)) {
        case 0:
          if (uppercase) {
            newResult += pick(uppercaseString);
          }
          break;
        case 1:
          if (lowercase) {
            newResult += pick(lowercaseString);
          }
          break;
        case 2:
          if (numbers) {
            newResult += pick(numbersString);
          }
          break;
        case 3:
          if (special) {
            newResult += pick(specialString);
          }
      }
    }
    widget.onGenerate?.call(newResult);
    setState(() => result = newResult);
  }
}
