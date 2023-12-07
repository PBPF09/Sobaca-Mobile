// import 'package:flutter/material.dart';
// import 'package:sobaca_mobile/models/thread.dart';
// import 'package:sobaca_mobile/screens/forumPage.dart';
// // import 'package:sobaca_mobile/widgets/left_drawer.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

// class ThreadFormPage extends StatefulWidget {
//   const ThreadFormPage({super.key});

//   @override
//   State<ThreadFormPage> createState() => _ThreadFormPageState();
// }

// class _ThreadFormPageState extends State<_ThreadFormPageState> {
//   final _formKey = GlobalKey<FormState>();
//   String _title = "";
//   String _content = "";
//   int _bookId = -1;
//   DateTime dateAdded = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     final request = context.watch<CookieRequest>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text(
//             'Start Discussion',
//           ),
//         ),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: "Discussion Title",
//                     labelText: "Discussion Title",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   onChanged: (String? value) {
//                     setState(() {
//                       _title = value!;
//                     });
//                   },
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return "Discussion Title Required";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: "Discussion Contents",
//                     labelText: "Discussion Contents",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   onChanged: (String? value) {
//                     setState(() {
//                       _content = value!;
//                     });
//                   },
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return "Discussion Content Required";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
