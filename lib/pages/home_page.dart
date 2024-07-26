import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // const HomePage({super.key});
  CollectionReference userReference =
      FirebaseFirestore.instance.collection("candidatos");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(),
    );
  }
}
