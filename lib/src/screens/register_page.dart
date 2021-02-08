import 'dart:io';

import 'package:cookbook_app/src/components/image_picker_widget.dart';
import 'package:cookbook_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

class RegisterPage extends StatefulWidget {
  final ServerController _serverController;
  final BuildContext _context;

  RegisterPage(this._serverController, this._context, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _password = '';
  String _errorMessage = '';
  File imageFile;
  Genrer genrer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            ImagePickerWidget(
                imageFile: this.imageFile,
                onImageSelected: (File file) {
                  setState(() {
                    imageFile = file;
                  });
                }),
            SizedBox(
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              height: kToolbarHeight + 25,
            ),
            Center(
              child: Transform.translate(
                offset: Offset(0, -20),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 260),
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
                          height: 20,
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
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Genrer',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile(
                                    activeColor: Colors.blue,
                                    value: Genrer.MALE,
                                    groupValue: this.genrer,
                                    onChanged: (value) {
                                      setState(() {
                                        this.genrer = value;
                                      });
                                    },
                                    title: Text(
                                      'Male',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  RadioListTile(
                                    activeColor: Colors.blue,
                                    value: Genrer.FEMALE,
                                    groupValue: this.genrer,
                                    onChanged: (value) {
                                      setState(() {
                                        this.genrer = value;
                                      });
                                    },
                                    title: Text(
                                      'Female',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () => _register(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Register'),
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
                      ],
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

  void _register(BuildContext context) {
    
  }
}
