import 'package:cookbook_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

class LoginPage extends StatefulWidget {
  final ServerController _serverController;
  final BuildContext _context;

  LoginPage(this._serverController, this._context, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _password = '';
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 60),
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.cyan[300], Colors.cyan[800]])),
              child: Image.asset(
                'assets/images/logo.png',
                color: Colors.white,
                height: 200,
              ),
            ),
            Transform.translate(
              offset: Offset(0, -20),
              child: Center(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, top: 260),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'User'),
                            onSaved: (value) {
                              this._userName = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'The User is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            onSaved: (value) {
                              this._password = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'The Password is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          RaisedButton(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () => _login(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Log in'),
                                if (_loading)
                                  Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: CircularProgressIndicator(),
                                  )
                              ],
                            ),
                          ),
                          if (this._errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                this._errorMessage,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Are you registered?'),
                              FlatButton(
                                textColor: Theme.of(context).primaryColor,
                                child: Text('Register'),
                                onPressed: () {
                                  _showRegister(context);
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    if (!_loading) {
      if (this._formKey.currentState.validate()) {
        this._formKey.currentState.save();
        setState(() {
          this._loading = true;
          this._errorMessage = '';
        });
        User user = await widget._serverController
            .login(this._userName, this._password);
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home', arguments: user);
        } else {
          setState(() {
            this._errorMessage = 'User or password incorrect';
            this._loading = false;
          });
        }
      }
    }
  }

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }

  @override
  void initState() {
    super.initState();
    widget._serverController.init(widget._context);
  }
}
