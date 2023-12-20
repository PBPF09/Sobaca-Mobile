import 'package:flutter/material.dart';

class DeskripsiBuku extends StatelessWidget {
  final String deskripsiBuku;
  const DeskripsiBuku(this.deskripsiBuku, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deskripsi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(deskripsiBuku),
      ),
    );
  }
}
