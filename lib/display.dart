import 'package:flutter/material.dart';
import 'package:test/customField.dart';

class DisplayStudent extends StatelessWidget {
  DisplayStudent({Key? key, this.sn, this.ini, this.cn, this.b})
      : super(key: key);
  var sn, ini, cn, b;
  @override
  Widget build(BuildContext context) {
    var _timer;
    const box = SizedBox(
      height: 50,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Student Details"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 50, 50, 10),
          child: SingleChildScrollView(
            child: Column(children: [
              CustomFieldReadOnly(
                hintText: sn.toString(),
              ),
              box,
              CustomFieldReadOnly(
                hintText: ini.toString(),
              ),
              box,
              CustomFieldReadOnly(
                hintText: cn.toString(),
              ),
              box,
              CustomFieldReadOnly(
                hintText: b.toString(),
              ),
              box,
            ]),
          ),
        ),
      ),
    );
  }
}
