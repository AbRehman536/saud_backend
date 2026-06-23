import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saud_backend/views/profile/update_profile.dart';

import '../../provider/user_provider.dart';

class GetProfile extends StatelessWidget {
  const GetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Text("Name : ${userProvider.getUser().name.toString()}"),
          Text("Name : ${userProvider.getUser().email.toString()}"),
          Text("Name : ${userProvider.getUser().phone.toString()}"),
          Text("Name : ${userProvider.getUser().address.toString()}"),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfile()));
          }, child: Text("Update Profile"))
        ],
      ),
    );
  }
}
