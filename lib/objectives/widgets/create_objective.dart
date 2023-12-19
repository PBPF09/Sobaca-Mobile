// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/objectives/screens/list_objective.dart';

class CreateObjectiveModal extends StatefulWidget {
  const CreateObjectiveModal({super.key});

  @override
  State<CreateObjectiveModal> createState() => _CreateObjectiveModalState();
}

class _CreateObjectiveModalState extends State<CreateObjectiveModal> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.8,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create New Objective",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Write the title of your objective here",
                        labelText: "Title",
                        alignLabelWithHint: true,
                      ),
                      onChanged: (value) => setState(() {
                        title = value;
                      }),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Write the content of your objective here",
                        labelText: "Description",
                        alignLabelWithHint: true,
                      ),
                      onChanged: (value) => setState(() {
                        description = value;
                      }),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Description cannot be empty!";
                        }
                        return null;
                      },
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.5,
                    child: ElevatedButton(
                      child: const Text('Cancel'),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    width: screenWidth * 0.5,
                    child: ElevatedButton(
                      child: const Text('Create Objective'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await request.postJson(
                              'https://tajri.raisyam.my.id/challenges/create_objective_mobile/',
                              jsonEncode({
                                "title": title,
                                "description": description,
                              }));
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ObjectivesPage()),
                          );
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
