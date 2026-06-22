import 'package:flutter/material.dart';
import 'package:saud_backend/services/auth.dart';
import 'package:saud_backend/services/user.dart';

import '../../models/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hint: Text("Name")
            ),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hint: Text("Email")
            ),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              hint: Text("Phone")
            ),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              hint: Text("Address")
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hint: Text("Password")
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  await AuthService().registerUser(
                      email: emailController.text,
                      password: passwordController.text)
                  .then((val)async{
                    await UserServices().createUser(
                      UserModel(
                        docId: val.uid,
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                        createdAt: DateTime.now().millisecondsSinceEpoch
                      )
                    ).then((value){
                      isLoading = false;
                      setState(() {});
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("User Created Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Ok"))
                          ],
                        );
                      });
                    });
                  });
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text("Register"))

        ],
      ),
    );
  }
}
