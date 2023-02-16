import 'package:flutter/material.dart';

class HomeDetailsScreen extends StatelessWidget {
  const HomeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("home screen detils")),
      body: const Text("I am home screen detils body"),
    );
  }
}
