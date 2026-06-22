import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';



class UserServices{
  String UserCollection = "UserCollection";
  ///Create User
  Future createUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(model.docId)
        .set(model.toJson());
  }
  ///Update User
  Future updateUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(model.docId)
        .update({"name" : model.name,"phone" : model.phone, "address" : model.address});
  }
  ///Delete User
  Future deleteUser(String userID)async{
    return await FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(userID)
        .delete();
  }
  /// Get User By ID
  Future<UserModel> getUserByID(String userID)async{
    return await FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(userID)
        .get()
        .then((user)=> UserModel.fromJson(user.data()!));
  }

}