// lib/screens/ProfilePage.dart
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/widgets/leftDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sobaca_mobile/user_registered/models/profile.dart';

class UserProvider with ChangeNotifier {
  String? loggedInUserName;

  void setLoggedInUserName(String userName) {
    loggedInUserName = userName;
    notifyListeners();
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<List<Profile>> fetchProfile() async {
    final request = context.watch<CookieRequest>();
    var response = await request
        .get('https://tajri.raisyam.my.id/user_registered/get_profile/');

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
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Center(
                child: Text(
                  "Belum ada profile.",
                  style: TextStyle(color: Color(0xff00a18c), fontSize: 20),
                ),
              );
            } else {
              final profile = snapshot.data![0].fields;

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
                          'Username: ${context.watch<UserProvider>().loggedInUserName}',
                          style: TextStyle(fontSize: 16.0),
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
                        ElevatedButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EditProfileModal();
                              },
                            );
                            setState(() {});
                          },
                          child: Text('Edit Profile'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class EditProfileModal extends StatefulWidget {
  @override
  _EditProfileModalState createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _favGenreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return SimpleDialog(
      title: Text('Edit Profile'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Kota'),
              ),
              TextField(
                controller: _favGenreController,
                decoration: InputDecoration(labelText: 'Genre Favorit'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Validate data (add your own validation logic)
                      if (_nameController.text.isEmpty ||
                          _cityController.text.isEmpty ||
                          _favGenreController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill in all fields')),
                        );
                        return;
                      }

                      // Send data to Django
                      final response = await request.post(
                          'https://tajri.raisyam.my.id/user_registered/edit_profile_flutter/',
                          jsonEncode(
                            <String, String>{
                              'name': _nameController.text,
                              'city': _cityController.text,
                              'fav_genre': _favGenreController.text,
                            },
                          ));
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Profil berhasil diubah!"),
                        ));
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
