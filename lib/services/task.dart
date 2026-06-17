import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saud_backend/models/task.dart';

class TaskServices{
  String taskCollection = "TaskCollection";
  ///Create Task
  Future createTask(TaskModel model)async{
    DocumentReference documentReference =
     await FirebaseFirestore.instance
      .collection(taskCollection)
      .doc();
   return await FirebaseFirestore.instance
       .collection(taskCollection)
        .doc(documentReference.id)
       .set(model.toJson(documentReference.id));
  }
  ///Update Task
  Future updateTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .update({"title" : model.title , "description" : model.description,});
  }
  ///Delete Task
  Future deleteTask(String taskID)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .delete();
  }
  ///Mark As Completed
  Future markAsCompletedTask(String taskID, bool isCompleted)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .update({"isCompleted" : isCompleted});
  }
  ///Get All Task
  Stream<List<TaskModel>> getAllTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())
    ).toList());
  }
  ///Get Completed Task
  Stream<List<TaskModel>> getCompletedTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("isCompleted" , isEqualTo: true)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())
    ).toList());
  }
  ///Get InCompleted Task
  Stream<List<TaskModel>> getInCompletedTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("isCompleted" , isEqualTo: false)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())
    ).toList());
  }
  ///Get All Saved Task
  Stream<List<TaskModel>> getAllSavedTask(String userID){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("saved" , arrayContains: userID)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())
    ).toList());
  }
  ///add To Saved
  Future addToSaved({
    required String taskID,
    required String userID
})async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .update({"saved": FieldValue.arrayUnion([userID])});
  }
  ///Remove From Saved
  Future removeFromSaved({
    required String taskID,
    required String userID
})async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .update({"saved": FieldValue.arrayRemove([userID])});
  }
}