// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/objectives/models/objective.dart';
import 'package:sobaca_mobile/objectives/screens/list_objective.dart';

class UpdateObjectiveModal extends StatefulWidget {
  final Objective objective;
  const UpdateObjectiveModal(this.objective, {super.key});

  @override
  State<UpdateObjectiveModal> createState() => _UpdateObjectiveModalState();
}

class _UpdateObjectiveModalState extends State<UpdateObjectiveModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.objective.fields.title);
    _descriptionController =
        TextEditingController(text: widget.objective.fields.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
                    "Edit Objective",
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
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        alignLabelWithHint: true,
                      ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: screenWidth * 0.30,
                    child: ElevatedButton(
                      child: const Text('Cancel'),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.30,
                    child: ElevatedButton(
                      child: const Text('Edit Objective'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await request.postJson(
                              'https://tajri.raisyam.my.id/challenges/edit_objective_mobile/',
                              jsonEncode({
                                "id": widget.objective.pk.toString(),
                                "title": _titleController.text,
                                "description": _descriptionController.text,
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
