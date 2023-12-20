// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/objectives/models/objective.dart';
import 'package:sobaca_mobile/objectives/screens/list_objective.dart';
import 'package:sobaca_mobile/objectives/widgets/update_objective.dart';

class ObjectiveCard extends StatelessWidget {
  final Objective objective;
  final VoidCallback refreshObjectives;

  const ObjectiveCard(this.objective,
      {required this.refreshObjectives, super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String description = objective.fields.description;
    if (description.length > 200) {
      description = "${description.substring(0, 200)}...";
    }

    String complete = "Mark as Complete";
    String status = "In Progress";
    if (objective.fields.isCompleted == true) {
      complete = "Completed";
      status = "Completed";
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10.0,
      child: InkWell(
        onTap: () async {
          _showObjective(context, request);
        },
        child: Container(
          width: screenWidth * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: screenHeight * 0.4,
                width: screenWidth * 0.6,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 184, 216, 190),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        objective.fields.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        status,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: SizedBox(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (!objective.fields.isCompleted) {
                                  await request.postJson(
                                      'https://tajri.raisyam.my.id/challenges/complete_objective_mobile/',
                                      jsonEncode({
                                        "id": objective.pk.toString(),
                                      }));
                                  refreshObjectives();
                                }
                              },
                              child: Text(complete)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.4,
                width: screenWidth * 0.3,
                child: const Icon(
                  Icons.notes_rounded,
                  size: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showObjective(BuildContext context, request) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String description = objective.fields.description;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: screenHeight * 0.6,
          width: screenWidth,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                objective.fields.title,
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight * 0.35,
                child: SingleChildScrollView(
                  child: Text(
                    description,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: screenWidth * 0.4,
                child: SizedBox(
                  child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return UpdateObjectiveModal(objective);
                          },
                        );
                      },
                      child: const Text("Edit")),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: screenWidth * 0.4,
                child: SizedBox(
                  child: ElevatedButton(
                      onPressed: () async {
                        await request.postJson(
                            'https://tajri.raisyam.my.id/challenges/delete_objective_mobile/',
                            jsonEncode({
                              "id": objective.pk.toString(),
                            }));
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ObjectivesPage(),
                          ),
                        );
                      },
                      child: const Text("Delete Notes")),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
