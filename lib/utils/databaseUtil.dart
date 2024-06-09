import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/utils/constants.dart';

class Databaseutil {
  final fireStore = FirebaseFirestore.instance;
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  getFirestore() {
    return fireStore
        .collection(FirebaseConstants.pathUserCollection)
        .doc(currentUserUid)
        .collection(FirebaseConstants.pathTasksCollection);
  }

  addTask(Map<String, String> data) async {
    DocumentReference docRef = getFirestore().add(data);

    String taskId = docRef.id;
    await docRef.update(
      {'id': taskId},
    );
  }

  Stream<QuerySnapshot> readTask(userId) {
    return getFirestore().snapshots();
  }

  updateTask(String taskId, Map<String, String> data) {
    return getFirestore()
        .doc(taskId)
        .update(data)
        .then(
          (_) => Fluttertoast.showToast(
              msg: "Task updated successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        )
        .catchError(
          (error) => Fluttertoast.showToast(
              msg: "Failed: $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        );
    ;
  }

  deleteTask() {
    return getFirestore();
  }
}
