import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saud_backend/models/task.dart';

class TaskServices{
  String taskCollection = "TaskCollection";
  ///Create Task
  Future createTask(TaskModel model)async{
   return await FirebaseFirestore.instance
       .collection(taskCollection)
       .add(model.toJson());
  }
  ///Update Task
  Future updateTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .update({"title" : model.title , "description" : model.description,});
  }
  ///Delete Task
  Future deleteTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .delete();
  }
  ///Mark As Completed
  Future markAsCompletedTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .update({"isCompleted" : model.isCompleted});
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
}