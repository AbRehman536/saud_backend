import 'package:flutter/material.dart';

import 'package:saud_backend/services/priority.dart';

import '../../models/Priority.dart';

class CreateUpdatePriority extends StatefulWidget {
  final PriorityModel model;
  final bool isUpdatedMode;
  const CreateUpdatePriority({super.key, required this.model, required this.isUpdatedMode});

  @override
  State<CreateUpdatePriority> createState() => _CreateUpdatePriorityState();
}

class _CreateUpdatePriorityState extends State<CreateUpdatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    if(widget.isUpdatedMode == true)
    nameController = TextEditingController(
        text: widget.model.name.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdatedMode ? "Update Priority" : "Create Priority"),
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
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  if(widget.isUpdatedMode == true){
                    await PriorityServices().updatePriority(
                      PriorityModel(
                        docId: widget.model.docId.toString(),
                        name: nameController.text.toString(),
                        createdAt: DateTime.now().millisecondsSinceEpoch
                      )
                    ).then((val){
                      isLoading = false;
                      setState(() {});
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Priority Updated Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Ok"))
                          ],
                        );
                      },);
                      });
                  }
                  else{
                    await PriorityServices().createPriority(
                        PriorityModel(
                            name: nameController.text.toString(),
                            createdAt: DateTime.now().millisecondsSinceEpoch
                        )
                    ).then((val){
                      isLoading = false;
                      setState(() {});
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Priority Created Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Ok"))
                          ],
                        );
                      },);
                    });
                  }
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text(
            widget.isUpdatedMode ? "Update Priority" : "Create Priority"
          ))
        ],
      ),
    );
  }
}
