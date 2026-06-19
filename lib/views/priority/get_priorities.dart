import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saud_backend/models/Priority.dart';
import 'package:saud_backend/models/task.dart';
import 'package:saud_backend/services/task.dart';

class GetPriorities extends StatelessWidget {
  final PriorityModel model;
  const GetPriorities({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.name} Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamProvider.value(
          value: TaskServices().getTaskByPriorityID(model.docId.toString()),
          initialData: [TaskModel()],
          builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task_alt),
                title: Text(taskList[index].title.toString()),
                subtitle: Text(taskList[index].description.toString()),
              );
            },);
          },

      ),
    );
  }
}
