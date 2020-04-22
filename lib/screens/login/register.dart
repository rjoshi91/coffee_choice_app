import 'package:flutter/material.dart';
import 'package:coffeechoiceapp/services/auth.dart';
import 'package:toast/toast.dart';
import 'package:coffeechoiceapp/themes/textFieldInputDecoration.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  // Authentication service instance
  final AuthService _registerService = AuthService();

  // Employee Name controller.
  final _nameController = TextEditingController();

  // Employee Code controller.
  final _employeeCodeController = TextEditingController();

  // Employee Mobile Number controller.
  final _mobileNumberController = TextEditingController();

  // Employee Set Number controller.
  final _seatNumberController = TextEditingController();

  // Employee Email Id controller.
  final _emailController = TextEditingController();

  // Password controller.
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    _seatNumberController.dispose();
    _nameController.dispose();
    _mobileNumberController.dispose();
    _employeeCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            Center(
              child: Image.asset(
                "images/coffeemakingbg.png",
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            ListView(
              children: <Widget>[
                ListTile(
                  title: Center(
                    child: Column(
                      children: <Widget>[


                        Container(
                          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
                          child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.brown,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
                          width: MediaQuery.of(context).size.width / 1.2,
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: _nameController,
                            decoration: textInputDecorationRegister.copyWith(hintText: 'Employee Name',),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Employee Name for Registeration';
                              }
                              return null;
                            },
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                          width: MediaQuery.of(context).size.width / 1.2,
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: _employeeCodeController,
                            decoration: textInputDecorationRegister.copyWith(hintText: 'Employee Code',),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Employee Code for Registeration';
                              }
                              return null;
                            },
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                          width: MediaQuery.of(context).size.width / 1.2,
                          alignment: Alignment.center,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _mobileNumberController,
                            decoration: textInputDecorationRegister.copyWith(hintText: 'Mobile Number',),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Mobile Number for Registration';
                              }
                              return null;
                            },
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                          width: MediaQuery.of(context).size.width / 1.2,
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: _seatNumberController,
                            decoration: textInputDecorationRegister.copyWith(hintText: 'Office Desk Seat Number',),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Office Desk Seat Number.';
                              }
                              return null;
                            },
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                          width: MediaQuery.of(context).size.width / 1.2,
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: textInputDecorationRegister.copyWith(hintText: 'Corporate Email Id',),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Email id for Registeration';
                              }
                              return null;
                            },
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                          width: MediaQuery.of(context).size.width / 1.2,
                          alignment: Alignment.center,
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: textInputDecorationRegister.copyWith(hintText: 'Password',),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter password for Registeration';
                              }
                              return null;
                            },
                          ),
                        ),

                        // Register Button
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(35.0),
                                  side: BorderSide(color: Colors.brown)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, right: 60, left: 60, bottom: 15),
                                child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ),
                              color: Colors.brown,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _registerWthEmail();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _registerWthEmail() async {
      String mailToAuth = _emailController.text;
      String passToAuth = _passwordController.text;
      String eCodeToAuth = _employeeCodeController.text;
      String eMobileToAuth = _mobileNumberController.text;
      String eNameToAuth = _nameController.text;
      String eSeatToAuth = _seatNumberController.text;

    dynamic result = await _registerService.registerWithEmailAndPassword(mailToAuth, passToAuth, eNameToAuth, eCodeToAuth, eMobileToAuth, eSeatToAuth);
    if (result == null) {
      Toast.show("Registration Failed", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Registered with Email: " + mailToAuth + "\n" + "Password: " + passToAuth, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      Navigator.of(context).pushNamed('/LoginScreen');
    }
    return null;
  }

}
