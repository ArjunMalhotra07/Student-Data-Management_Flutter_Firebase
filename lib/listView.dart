import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/addStudent.dart';
import 'package:test/display.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('student-details');
  late Stream? myStream = _collectionRef.snapshots();

  @override
  void initState() {
    super.initState();
    myStream = _collectionRef.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: StreamBuilder(
          stream: myStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              print("Inside");
              return Row(children: [
                Container(
                  height: height,
                  color: Colors.white,
                  width: width,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        var name = data['Name'];
                        var initials = data['Initials'];
                        var college = data['College'];
                        var branch = data['Branch'];
                        var id = data['Id'];

                        return SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 50),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const CircleAvatar(
                                    foregroundImage:
                                        AssetImage('assets/pic.jpg'),
                                    maxRadius: 20,
                                  ),
                                  Text(
                                    data['Name'],
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplayStudent(
                                                    sn: name,
                                                    cn: college,
                                                    ini: initials,
                                                    b: branch,
                                                  )),
                                        );
                                      },
                                      child: Icon(Icons.folder)),
                                  GestureDetector(
                                      onTap: () {
                                        deleteDialogBox(id);
                                      },
                                      child: const Icon(Icons.delete))
                                ]),
                          ),
                        );
                      }),
                ),
              ]);
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddStudent()),
            );
          }),
    );
  }

  deleteDialogBox(String id) {
    return showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: const Text(
              "Delete Student permanently?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            actions: [
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              ),
              TextButton(
                child: const Text(
                  "Ok",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () async {
                  FirebaseFirestore.instance
                      .collection('student-details')
                      .doc(id)
                      .delete();
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        });
  }
}
