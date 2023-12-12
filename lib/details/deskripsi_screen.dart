import 'package:flutter/material.dart';
import 'package:sobaca_mobile/details/details_screen.dart';

class DeskripsiBuku extends StatelessWidget {
  const DeskripsiBuku({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deskripsi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(const DetailBuku().deskripsiBuku),
      ),
    );
  }
}
