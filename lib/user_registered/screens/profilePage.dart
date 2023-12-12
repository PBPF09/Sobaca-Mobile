// lib/screens/ProfilePage.dart
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sobaca_mobile/widgets/leftDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sobaca_mobile/user_registered/models/profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<List<Profile>> fetchProfile() async {
    final request = context.watch<CookieRequest>();
    var response =
        await request.get('http://localhost:8000/user_registered/get_profile/');

    var data = response;
    List<Profile> listProfile = [];

    for (var d in data) {
      if (d != null) {
        listProfile.add(Profile.fromJson(d));
      }
    }

    return listProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard Profile'),
        ),
        drawer: LeftDrawer(),
        body: FutureBuilder(
            future: fetchProfile(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  final profile = snapshot
                      .data![0].fields; // Assuming only one profile is returned

                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Dashboard Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Nama: ${profile.name}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Kota: ${profile.city}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Genre Favorit: ${profile.favGenre}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
            }));
  }
}
