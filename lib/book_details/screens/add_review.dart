import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddReview extends StatefulWidget {
  final int bookId;

  const AddReview({Key? key, required this.bookId}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController reviewController = TextEditingController();

  Future<void> submitReview() async {
    final int bookId = widget.bookId;
    final String apiUrl =
        'https://tajri.raisyam.my.id/book/add-review-flutter/$bookId/';
    final request = context.read<CookieRequest>();

    try {
      if (_formKey.currentState!.validate()) {
        final response = await request.postJson(
          apiUrl,
          jsonEncode(<String, dynamic>{
            'review': reviewController.text.trimRight(),
          }),
        );
        if (response['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Review submitted successfully'),
            ),
          );
          Navigator.pop(context, true); // Return to the previous page
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to submit review'),
            ),
          );
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error submitting review'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: reviewController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Your Review',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: submitReview,
                child: const Text('Submit Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
