import 'package:flutter/cupertino.dart';
import 'package:saud_backend/models/user.dart';

class UserProvider extends ChangeNotifier{
  UserModel userModel = UserModel();


  ///set User
  void setUser(UserModel model){
    userModel = model;
    notifyListeners();
  }

  ///get User
  UserModel getUser()=> userModel;
}