import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: '登录'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildContainer(),
    );
  }

  Container buildContainer() {
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(children: [
        TextField(
          decoration: InputDecoration(
            hintText: "请输入用户名或者邮箱",
            hintStyle: TextStyle(color: Colors.black12),
          ),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "请输入密码",
            hintStyle: TextStyle(color: Colors.black12),
          ),
        ),
        RaisedButton(
          textColor: Color(0xFF),
        ),
      ]),
    );
  }
}
