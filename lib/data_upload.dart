import 'package:alumni2/common/reusable_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataUpload extends StatefulWidget {
  const DataUpload({super.key});

  @override
  State<DataUpload> createState() => _DataUploadState();
}

class _DataUploadState extends State<DataUpload> {
  bool _isLoading = false;

  Future<void> uploadData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    setState(() {
      _isLoading = true;
    });
    List<Map<String, dynamic>> students = [
      {
        "id": "20204012",
        "name": "Md Ohiduzaman Pranto",
        "dept": "cse",
        "batch": "12th",
        "email": "ohid.prantofake@gmail.com"
      },
      {
        "id": "20204006",
        "name": "Md Sahahrear Khan",
        "dept": "cse",
        "batch": "12th",
        "email": "refatabc@gmail.com"
      }
    ];

    Map<String, Set<String>> departmentBatches = {};

    for (var student in students) {
      String dept = student['dept'];
      String batch = student['batch'];
      String id = student['id'];

      // Track batches for each department
      if (!departmentBatches.containsKey(dept)) {
        departmentBatches[dept] = {};
      }
      departmentBatches[dept]!.add(batch);

      DocumentReference deptDoc = firestore.collection('studentss').doc(dept);
      DocumentReference batchDoc = deptDoc.collection(batch).doc(id);

      // Set student data
      await batchDoc.set(student);
    }

    // Update availableBatches field for each department
    for (var entry in departmentBatches.entries) {
      String dept = entry.key;
      List<String> batches = entry.value.toList();
      List<String> newBatches = entry.value.toList();

      DocumentReference deptDoc = firestore.collection('studentss').doc(dept);

      // Retrieve existing batches
      DocumentSnapshot snapshot = await deptDoc.get();
      List<String> existingBatches = [];

      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('availableBatches')) {
          existingBatches = List<String>.from(data['availableBatches']);
        }
      }

      // Merge existing and new batches
      Set<String> mergedBatches = {...existingBatches, ...newBatches};

      // Update Firestore

      await deptDoc.set({'availableBatches': mergedBatches.toList()},
          SetOptions(merge: true));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: MaterialButton(
          onPressed: uploadData,
          color: Colors.blue,
          height: 80,
          minWidth: 300,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
          child: _isLoading
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : const ReusableText(
                  'Upload Data',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
        ),
      ),
    );
  }
}
