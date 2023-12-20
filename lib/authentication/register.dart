import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('https://tajri.raisyam.my.id/auth/register_flutter/'),
        body: {
          'username': username,
          'password': password,
        },
      );

      // Check if the response is JSON
      if (response.headers['content-type']?.contains('application/json') ??
          false) {
        final result = json.decode(response.body);
        if (response.statusCode == 201) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Registration Successful'),
              content: Text(result['message']),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context); // Dismiss dialog
                    Navigator.pop(context); // Back to login page
                  },
                ),
              ],
            ),
          );
        } else {
          // Handle other statuses
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Registration Failed'),
              content: Text(result['message'] ?? 'Unknown error'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
      } else {
        throw Exception('Received invalid response format from the server');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Failed'),
          content: SingleChildScrollView(
            child: Text(
              'An error occurred: ${e.toString()}',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context); // Dismiss dialog
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff8dc26f),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/images/sobaca_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'SOBACA',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Sobat Membaca Inspire your Literacy',
              style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff8dc26f), 
                onPrimary: Colors.white,
              ),
              onPressed: () {
                registerUser();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}