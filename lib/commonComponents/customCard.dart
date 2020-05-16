import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../ui/task.dart';

class CustomCard extends StatelessWidget {
  CustomCard({this.id,@required this.title, this.description});

  final id;
  final title;
  final description;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.remove_circle),
                  onPressed: (){
                    try {
                      Firestore.instance
                          .collection('tasks')
                          .document(id)
                          .delete();
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                ),
                Column(
                  children: <Widget>[
                    Text(title),
                    FlatButton(
                        child: Text("See More"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskPage(
                                      title: title, description: description)));
                        }),
                  ],
                ),
              ],
            )));
  }
}
