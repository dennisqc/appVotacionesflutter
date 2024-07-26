import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamVotos extends StatelessWidget {
  CollectionReference userReference =
      FirebaseFirestore.instance.collection("candidatos");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: StreamBuilder(
        stream: userReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot userCollection = snapshot.data;
            List<QueryDocumentSnapshot> docs = userCollection.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(docs[index]["nombrePartido"]),
                  subtitle: Text(docs[index]["representante"]),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}
