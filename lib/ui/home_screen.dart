import 'package:flutter/material.dart';
import 'package:form_app/services/controller/login_controller.dart';
import 'package:form_app/ui/login_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.put(AuthController());

  final _key = GlobalKey<ScaffoldState>();
  
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyfssai = GlobalKey<FormState>();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyPhone = GlobalKey<FormState>();
  final _formKeyAddress = GlobalKey<FormState>();
  final _formKeyDescription = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _fssaiController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();


  String name = '';
  String uid = '';
  String email = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Partner With Us'),
        actions: [
          myPopMenu()
        ],
      ),
      body: addReview(context),
    );
  }

  addReview(BuildContext context)
  {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add Review: $uid', style: TextStyle(color: Colors.blue, fontSize: 20),),
            Text('Fill the details',style: TextStyle(color: Colors.blue, fontSize: 16)),
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
                key: _formKeyAddress,
                child: TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'Please enter Address';
                      }
                    },
                    controller: _addressController,
                    // keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Enter Address',
                        labelText: 'Address',
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
                key: _formKeyfssai,
                child: TextFormField(
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'Please enter FSSAI No';
                      }
                    },
                    controller: _fssaiController,
                    decoration: InputDecoration(
                        hintText: 'FSSAI',
                        labelText: 'FSSAI',
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
                key: _formKeyDescription,
                child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'Please enter Description';
                      }
                    },
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        labelText: 'Description',
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
                    review();
                    // print('signin');
                    // registerUser(_emailController.text, _pwdController.text, context);
                    // register();
                  },
                  child: Text('Review',style: TextStyle(color: Colors.white),)
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  review() {
    if(_formKeyName.currentState!.validate() &&
        _formKeyPhone.currentState!.validate() &&
        _formKeyEmail.currentState!.validate() &&
        _formKeyAddress.currentState!.validate() &&
        _formKeyfssai.currentState!.validate() &&
        _formKeyDescription.currentState!.validate())
      {
        Map<String,dynamic> model = {
          'uid': uid,
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': _contactController.text.trim(),
          'address': _addressController.text.trim(),
          'fssai': _contactController.text.trim(),
          'description': _contactController.text.trim()
        };
        authController.updateUserData(uid, model).whenComplete(() {
          showSnackbar('success', 'reviewed successfully');
        }).onError((error, stackTrace) {
          print(error);
          showSnackbar('error', error.toString());
        });
      }
    
  }

  bool validEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
  getUserDetails() async
  {

    var data = await authController.getUserName();
    if(data != null) {
      name=data['name'];
      email = data['email'];
      uid = data['uid'];
    }
    print('data: $data');
    print('name: ${data['name']}');
    setState(() {
    });
  }

  // updateDetails() async
  // {
  //   print(model);
  //   print(providerState?.getUid);
  //   var val = await providerState?.updateUserData(providerState?.getUid, model);
  //   isUpdated = val;
  //   print('val: $isUpdated');
  //
  //
  // }

  Widget myPopMenu() {
    return PopupMenuButton(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: CircleAvatar(
            backgroundColor: Colors.black26,
            child: Text(name == '' ? '' : name.substring(0,2),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        onSelected: (value) {
          switch(value)
          {
            case 1: _onLogoutPressed();
            break;
          }
        },
        itemBuilder: (context) => [
          // PopupMenuItem(
          //     value: 1,
          //     child: Text('Profile')
          // ),
          PopupMenuItem(
              value: 1,
              child: Container(
                  height: 30,
                  width: 50,
                  child: Text('Logout'))
          ),
        ]);
  }

  _onLogoutPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to Logout'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text('Logout'),
            onPressed: () {
              authController.signout().whenComplete(() {
                clearSession();
                Get.offAll(LoginScreen());
              })
              .onError((error, stackTrace) {
                return showSnackbar('error', error.toString());
              });

            },
          ),
        ],
      ),
    );
  }
  clearSession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  showSnackbar(String title, String message)
  {
    Get.snackbar(title, message,snackPosition: SnackPosition.BOTTOM);
  }

}
