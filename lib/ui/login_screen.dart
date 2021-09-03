import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_app/services/controller/google_signin.dart';
import 'package:form_app/services/controller/login_controller.dart';
import 'package:form_app/ui/register_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GoogleSignInController googleController = Get.put(GoogleSignInController());
  final loginController = Get.put(AuthController());

  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  bool obscure = true;
  obscureText()
  {
    setState(() {
      obscure = !obscure;
    });
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple, Colors.orange
          ]
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: width - 50,
            height: height - 200,
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('SIGN IN',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Form(
                      key: _formKeyEmail,
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            else if (!validEmail(value))
                              return 'Please enter valid email';
                          },
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              labelText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.black26,
                                fontStyle: FontStyle.italic,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey, //this has no effect
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              )
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Form(
                      key: _formKeyPassword,
                      child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Please enter Password';
                            }
                            else if (value.toString().length < 8)
                              return 'Password shoud be 8 characters';
                          },
                          obscureText: obscure,
                          controller: _pwdController,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(obscure == true ? Icons.visibility : Icons.visibility_off),
                                onPressed: obscureText,
                              ),
                              hintText: 'Password',
                              labelText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.black26,
                                fontStyle: FontStyle.italic,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey, //this has no effect
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              )
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: ElevatedButton(
                        onPressed: (){
                          _Login(_emailController.text, _pwdController.text, context);
                        },
                        child: Text('Login',style: TextStyle(color: Colors.white),)
                    ),
                  ),
                  TextButton(
                    child: Text('create new account',
                        style: TextStyle(color: Colors.blue)
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                    },
                  ),
                  Text('OR', style:  TextStyle(color: Colors.grey),),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(
                          height: 2,
                          color: Colors.black,
                        ),
                        Divider(
                          height: 2,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.black,
                      minimumSize: Size(double.infinity, 50)
                    ),
                    icon: FaIcon(FontAwesomeIcons.google),
                    label: Text('Login with Google',
                        style: TextStyle(color: Colors.white)
                    ),
                    onPressed: () {
                      googleController.googleLogin().whenComplete(() =>
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => HomeScreen()))
                      ).onError((error, stackTrace) {
                        showSnackbar('Error',error.toString());
                      });
                    },
                  ),

                ],
              ),
            ),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )],
              borderRadius: BorderRadius.circular(36),
              color: Colors.white,
            ),
          ),
        ),
      )
    );
  }

  showSnackbar(String title, String message)
  {
    Get.snackbar(title, message,snackPosition: SnackPosition.BOTTOM);
  }

  void _Login(String email,String password,BuildContext context) async{
    if (_formKeyEmail.currentState!.validate() &&
        _formKeyPassword.currentState!.validate()){
      try{
        bool loginStatus = await loginController.LoginUser(email, password);
        print(loginStatus);
        if(loginStatus == true)
        {
          showSnackbar('success','login successfull');
          storeSession();
          Future.delayed(Duration(seconds: 2));
          Get.offAll(() => HomeScreen());
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(
          //     builder: (context)=>HomeScreen()));
        }
        else
        {
          return showDialog(
              context: context,
              builder: (context)
              {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('something went wrong!'),
                );
              }
          );
        }
      }catch(e)
      {
        print(e);
      }
    }
  }

  storeSession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isLogin', true);
  }

  bool validEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
