import 'package:coffeechoiceapp/themes/textFieldInputDecoration.dart';
import 'package:flutter/material.dart';
import 'package:coffeechoiceapp/services/auth.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  // Authentication service instance
  final AuthService _loginService = AuthService();

  // TextField controller.
  final _emailController = TextEditingController();

  // Password controller.
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[

            Container(
              height: MediaQuery.of(context).size.height/2.15,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "images/logincart.png",
                fit: BoxFit.scaleDown,
              ),
            ),

            ListTile(
              title: Center(

                child: Column(

                  children: <Widget>[

                    Container(
                      margin: const EdgeInsets.only(top: 5, left: 20, right: 25),
                      width: MediaQuery.of(context).size.width/1.2,
                      alignment: Alignment.center,
                      child: TextFormField(
                        autofocus: false,
                        controller: _emailController,
                        decoration: textInputDecoration.copyWith(hintText:'Email address or Mobile number.',),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Registered id / Mobile No. for login';
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 5, left: 20, right: 25),
                      width: MediaQuery.of(context).size.width/1.2,
                      alignment: Alignment.center,
                      child: TextFormField(
                        obscureText: true,
                        autofocus: false,
                        controller: _passwordController,
                        decoration: textInputDecoration.copyWith(hintText:'Password'),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid password for login';
                          }
                          return null;
                        },
                      ),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        // Register Button
                        Container(
                          margin: const EdgeInsets.only(top: 10, right: 5),
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(35.0),
                                side: BorderSide(color: Colors.brown)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0, right: 30, left: 30, bottom: 15),
                              child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  )
                              ),
                            ),
                            color: Colors.brown,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/RegistrationScreen');
                            },
                          ),
                        ),

                        // Login Button
                        Container(
                          margin: const EdgeInsets.only(top: 10, right: 0, left: 0),
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(35.0),
                                side: BorderSide(color: Colors.brown)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0, right: 35, left: 35, bottom: 15),
                              child: Text(
                                  'Log in',
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  )
                              ),
                            ),
                            color: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _signInEmailAndPassword();
                              }
                            },
                          ),
                        ),

                      ],
                    ),

                    // Anonymous Login Button
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(35.0),
                              side: BorderSide(color: Colors.blue)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0, right: 30, left: 30, bottom: 15),
                            child: Text(
                                'Sign-in Anonymously',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                )
                            ),
                          ),
                          color: Colors.blue,
                          onPressed: () async {
                            _signInRandom();
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
      ),
    );
  }

  void _signInEmailAndPassword() async {
    String mailToAuth = _emailController.text;
    String passToAuth = _passwordController.text;

    dynamic result = await _loginService.signInEmailAndPassword(_emailController.text, _passwordController.text);
    if(result == null){
      Toast.show("Login Failed", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }else{
      Toast.show("Login with Email: " + mailToAuth + "\n" + "Password: " + passToAuth, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      print("Logged-in with Email & Password");
      print(result.uid);
      Navigator.of(context).pushNamed('/HomeScreen');
    }
  }

  void _signInRandom() async {
    dynamic result = await _loginService.signInAnony();
    if(result == null){
      Toast.show("Login Failed", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }else{
      Toast.show("Logged-in Anonymously", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      print("Logged-in Anonymously");
      print(result.uid);
      Navigator.of(context).pushNamed('/HomeScreen');
    }
  }

}
