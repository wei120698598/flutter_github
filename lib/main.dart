import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/i18n.dart';

void main() {
  debugDumpLayerTree();
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      onGenerateTitle: (context) {
        return S.of(context).page_title_login;
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _umEdtCtr = TextEditingController();
  final _pwdEdtCtr = TextEditingController();
  final userNameFocusNode = FocusNode();
  final pwdFocusNode = FocusNode();
  var _btnEnabled = false;

  @override
  Widget build(BuildContext context) {
    var listener = () {
      setState(() {
        _btnEnabled = _umEdtCtr.text.trim().isNotEmpty && _pwdEdtCtr.text.trim().isNotEmpty;
      });
    };
    _umEdtCtr.addListener(listener);
    _pwdEdtCtr.addListener(listener);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_title_login),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        //点击隐藏键盘
        onTap: () {
          print("shuxin");
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          margin: EdgeInsets.only(top: 100, left: 30, right: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _LoginInput(
                hintText: S.of(context).user_name_input_hint,
                editingController: _umEdtCtr,
                focusNode: userNameFocusNode,
                onSubmit: () {
                  FocusScope.of(context).autofocus(pwdFocusNode);
                },
              ),
              _LoginInput(
                hintText: S.of(context).password_input_hint,
                editingController: _pwdEdtCtr,
                focusNode: pwdFocusNode,
                isPwd: true,
                onSubmit: _onSubmit,
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: double.infinity,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  disabledColor: Theme.of(context).accentColor.withOpacity(0.5),
                  disabledTextColor: Colors.white.withOpacity(0.5),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  onPressed: _btnEnabled ? _onSubmit() : null,
                  child: Text(S.of(context).page_title_login),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit() {
    //隐藏键盘
    FocusScope.of(context).requestFocus(new FocusNode());
    //todo 提交表单
  }
}

/// 登录输入框
class _LoginInput extends StatefulWidget {
  final String hintText;
  final bool isPwd;
  final TextEditingController editingController;
  final focusNode;
  final onSubmit;

  _LoginInput({Key key, this.hintText, this.isPwd = false, this.editingController, this.focusNode, this.onSubmit}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginInputState();
  }
}

class _LoginInputState extends State<_LoginInput> {
  bool _visibility = false;
  bool _isEmpty = true;
  final TextStyle _hintTextStyle = const TextStyle(
    color: Colors.black12,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    widget.editingController.addListener(() {
      setState(() {
        _isEmpty = widget.editingController.text.isEmpty;
      });
    });
    return TextFormField(
      textInputAction: widget.isPwd ? TextInputAction.done : TextInputAction.next,
      obscureText: widget.isPwd && !_visibility,
      controller: widget.editingController,
      focusNode: widget.focusNode,
      validator: (text) {
        if (text.isEmpty) {
          return widget.isPwd ? "密码不能为空" : "用户名不能空";
        } else {
          return "";
        }
      },
      onFieldSubmitted: widget.onSubmit,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: _hintTextStyle,
        labelStyle: _hintTextStyle,
        prefixIcon: Icon(widget.isPwd ? Icons.account_circle : Icons.lock),
        suffixIcon: Visibility(
          visible: !_isEmpty,
          child: IconButton(
            onPressed: () {
              if (!widget.isPwd) {
                widget.editingController.clear();
              } else {
                setState(() {
                  _visibility = !_visibility;
                });
              }
            },
            icon: Icon(widget.isPwd ? (_visibility ? Icons.visibility_off : Icons.visibility) : Icons.clear),
          ),
        ),
      ),
    );
  }
}
