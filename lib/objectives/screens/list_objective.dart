// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/objectives/models/objective.dart';
import 'package:sobaca_mobile/objectives/widgets/card_objective.dart';
import 'package:sobaca_mobile/objectives/widgets/create_objective.dart';
import 'package:sobaca_mobile/screens/left_drawer.dart';

class ObjectivesPage extends StatefulWidget {
  const ObjectivesPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ObjectivesPageState createState() => _ObjectivesPageState();
}

class _ObjectivesPageState extends State<ObjectivesPage> {
  List<String> filterOptions = ["--", "completed", "noncompleted"];
  String filter = "";

  Future<List<Objective>>? objectives;

  Future<List<Objective>>? fetchObjectives(request, filter) async {
    var response = await request.postJson(
        "http://127.0.0.1:8000//challenges/get_objectives_mobile/",
        jsonEncode({
          "status": filter,
        }));

    List<Objective> listObjective = [];
    for (var d in response) {
      if (d != null) {
        listObjective.add(Objective.fromJson(d));
      }
    }
    return listObjective;
  }

  void refreshObjectives() {
    setState(() {
      objectives = fetchObjectives(context.read<CookieRequest>(), filter);
    });
  }

  @override
  void initState() {
    super.initState();
    filter = filterOptions.first;
    refreshObjectives();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User's Objective",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 184, 216, 190),
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: width * 0.98,
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CreateObjectiveModal();
                    },
                  );
                },
                child: const Text("Create New Objective"),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton(context, "All", "--"),
                _buildFilterButton(context, "Non-Completed", "noncompleted"),
                _buildFilterButton(context, "Completed", "completed"),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder<List<Objective>>(
                future: objectives,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 1,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ObjectiveCard(snapshot.data![index],
                            refreshObjectives: refreshObjectives);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(
      BuildContext context, String buttonText, String filterValue) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              filter = filterValue;
              refreshObjectives();
            });
          },
          child: Text(buttonText),
        ),
      ),
    );
  }
}
