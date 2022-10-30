import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/customField.dart';

import 'model/userModel.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController idController = TextEditingController();
  TextEditingController initialsController = TextEditingController();
  TextEditingController cnController = TextEditingController();
  TextEditingController snController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController ctController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _timer;
    const box = SizedBox(
      height: 50,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Add Student"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 50, 50, 10),
          child: SingleChildScrollView(
            child: Column(children: [
              CustomField(hintText: "Student's Name", controller: snController),
              box,
              CustomField(hintText: "Initials", controller: initialsController),
              box,
              CustomField(hintText: "College Name", controller: cnController),
              box,
              CustomField(hintText: "Branch", controller: branchController),
              box,
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                child: const Text(
                  "Add Student",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
                onPressed: () async {
                  createUser(snController.text, initialsController.text,
                      cnController.text, branchController.text);
                  snController.clear();
                  cnController.clear();
                  initialsController.clear();
                  branchController.clear();

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        _timer = Timer(const Duration(seconds: 2), () {
                          Navigator.of(context).pop();
                        });
                        return const AlertDialog(
                          content: Text("Data Added"),
                        );
                      }).then((value) {
                    if (_timer.isActive) {
                      _timer.cancel();
                    }
                  });
                },
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future createUser(String sn, ini, cn, b) async {
    final docUser =
        FirebaseFirestore.instance.collection('student-details').doc();
    final json = User(id: docUser.id, sn: sn, ini: ini, cn: cn, b: b);
    final jsonBody = json.toJson();
    await docUser.set(jsonBody);
  }
}
