import 'dart:convert';

import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future _submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      var url = Uri.parse('http://localhost:3000/ja/api/v1/mobile/users');
      var res = await http.post(url, body: {
        'name': _nameController.text,
        'email': _idController.text,
        'password': _passwordController.text
      });
      if (res.statusCode == 200) {
        Map resMap = json.decode(res.body);
        // トークンを格納
        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: resMap['token']);
        await storage.write(
            key: 'publicUid', value: resMap['user']['public_uid']);
        await storage.write(key: 'remindersCount', value: '0');
        await storage.write(key: 'notificationsCount', value: '0');
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      } else {
        _nameController.text = '';
        _idController.text = '';
        _passwordController.text = '';
        const snackBar = SnackBar(
            content: Text('登録できませんでした。指定メールアドレスのユーザーはすでに存在しているか、パスワードが短すぎます。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    // IDとパスワードのフォーム https://flutterawesome.com/basic-login-and-signup-screen-designed-in-flutter/
    Widget _entryField(String title, controller, {bool isPassword = false}) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '入力してください。';
                }
                return null;
              },
            )
          ],
        ),
      );
    }

    Widget _submitButton() {
      return InkWell(
        onTap: () {
          _submit();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: const Text(
            '登録する',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _entryField("ユーザー名", _nameController),
          _entryField("メールアドレス", _idController),
          _entryField("パスワード", _passwordController, isPassword: true),
          const SizedBox(height: 20),
          _submitButton(),
        ],
      ),
    );
  }
}
