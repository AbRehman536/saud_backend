import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saud_backend/models/task.dart';
import 'package:saud_backend/services/task.dart';
import 'package:saud_backend/views/task/create_task.dart';
import 'package:saud_backend/views/task/update_task.dart';

class GetCompletedTask extends StatelessWidget {
  const GetCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Completed Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamProvider.value(
        value: TaskServices().getCompletedTask(),
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
