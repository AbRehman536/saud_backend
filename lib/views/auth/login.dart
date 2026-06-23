import 'package:flutter/material.dart';
import 'package:saud_backend/services/auth.dart';
import 'package:saud_backend/services/user.dart';
import 'package:saud_backend/views/auth/register.dart';
import 'package:saud_backend/views/auth/reset_password.dart';
import 'package:saud_backend/views/task/get_all_task.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hint: Text("Email")
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
                  await AuthService().loginUser(
                      email: emailController.text,
                      password: passwordController.text)
                  .then((value)async{
                   await UserServices().getUserByID(
                     value.uid.toString()
                   )
                   .then((value) {
                     Navigator.push(context, MaterialPageRoute(
                         builder: (context) => GetAllTask()));
                   });
                  });
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text("Login")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
          }, child: Text("Register")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword()));
          }, child: Text("Reset Password")),
        ],
      ),
    );
  }
}
