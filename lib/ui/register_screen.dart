import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_app/services/controller/login_controller.dart';
import 'package:form_app/ui/login_screen.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<ScaffoldState>();

  final authController = Get.put(AuthController());

  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyPhone = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _contactController = TextEditingController();

  void _signUp(String email,String password,BuildContext context) async{
    if(_formKeyName.currentState!.validate() &&
        _formKeyPhone.currentState!.validate() &&
        _formKeyEmail.currentState!.validate() &&
        _formKeyPassword.currentState!.validate())
    {
      Map? userModel = {
        'name' : _nameController.text.trim(),
        'phone' : _contactController.text.trim(),
        'pwd' : _pwdController.text.trim(),
        'value' : 0
      };
      bool status = await authController.signUpUser(email, password, userModel);
      print('status');
      if(status)
      {
        showDialog(
            context: context,
            builder: (context)
            {
              return AlertDialog(
                content: Text('User Registration successfull'),
              );
            }
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      else
      {
        print('error');
      }
    }
  }

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
    return SafeArea(
      child: Container(
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
          key: _key,
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: width - 50,
                height: height - 180,
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('SIGN UP',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKeyName,
                          child: TextFormField(
                              validator: (value){
                                if (value!.isEmpty) {
                                  return 'Please enter Name';
                                }
                              },
                              keyboardType: TextInputType.name,
                              controller: _nameController,
                              decoration: InputDecoration(
                                  hintText: 'name',
                                  labelText: 'Enter name',
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
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKeyPhone,
                          child: TextFormField(
                              keyboardType: TextInputType.phone,
                              validator: (value){
                                if (value!.isEmpty) {
                                  return 'Please enter Phonenumber';
                                }
                              },
                              controller: _contactController,
                              // keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  labelText: 'Contact',
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
                        padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.all(14.0),
                        child: ElevatedButton(
                            onPressed: () {
                              // print('signin');
                              _signUp(_emailController.text, _pwdController.text, context);
                              // registerUser(_emailController.text, _pwdController.text, context);
                              // register();
                            },
                            child: Text('SignUp',style: TextStyle(color: Colors.white),)
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'already have an account?',
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                    text: 'Login',
                                    style: TextStyle(color: Colors.blue),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                      }
                                )
                              ]
                          )),
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
          ),
        ),
      ),
    );
  }

  bool validEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
