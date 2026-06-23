import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saud_backend/models/task.dart';
import 'package:saud_backend/services/task.dart';
import 'package:saud_backend/views/priority/get_all_priority.dart';
import 'package:saud_backend/views/profile/get_profile.dart';
import 'package:saud_backend/views/task/create_task.dart';
import 'package:saud_backend/views/task/get_saved_task.dart';
import 'package:saud_backend/views/task/update_task.dart';

import 'get_completed.dart';
import 'get_incompleted.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetCompletedTask()));
          }, icon: Icon(Icons.circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetInCompletedTask()));
          }, icon: Icon(Icons.incomplete_circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetSavedTask()));
          }, icon: Icon(Icons.bookmark)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllPriority()));
          }, icon: Icon(Icons.priority_high)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetProfile()));
          }, icon: Icon(Icons.person)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTask()));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: TaskServices().getAllTask(),
          initialData: [TaskModel()],
          builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[index].title.toString()),
                subtitle: Text(taskList[index].description.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()async{
                      if(taskList[index].saved!.contains("101")){
                        await TaskServices().removeFromSaved(
                            taskID: taskList[index].docId.toString(),
                            userID: "101");
                      }
                      else{
                        await TaskServices().addToSaved(
                            taskID: taskList[index].docId.toString(),
                            userID: "101");
                      }
                    }, icon: Icon(taskList[index].saved!.contains("101") ? Icons.bookmark : Icons.bookmark_border_outlined)),
                    Checkbox(
                        value: taskList[index].isCompleted,
                        onChanged: (value)async{
                          try{
                            await TaskServices().markAsCompletedTask(
                                taskList[index].docId.toString(),
                                value!);
                          }catch(e){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                        }),
                    IconButton(onPressed: ()async{
                      try{
                        await TaskServices().deleteTask(
                          taskList[index].docId.toString()
                        );
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=> UpdateTask(model: taskList[index],)));
                    }, icon: Icon(Icons.edit))
                  ],
                ),
              );
            },);
          },
      ),
    );
  }
}
