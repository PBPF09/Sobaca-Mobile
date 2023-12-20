import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/book_details/models/reviews.dart';
import 'package:sobaca_mobile/user_registered/models/profile.dart';
import 'package:sobaca_mobile/user_registered/screens/profilePage.dart';

class AllReviews extends StatefulWidget {
  final int bookId;

  const AllReviews({Key? key, required this.bookId}) : super(key: key);

  @override
  _AllReviewsState createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  late Future<List<Reviews>> reviews;

  @override
  void initState() {
    super.initState();
    reviews = fetchReviews();
  }

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

  Future<List<Reviews>> fetchReviews() async {
    final int bookId = widget.bookId;
    final String apiUrl =
        'https://tajri.raisyam.my.id/book/get-reviews/$bookId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse and return the list of reviews
        final List<dynamic> data = json.decode(response.body);
        return List<Reviews>.from(
            data.map((review) => Reviews.fromJson(review)));
      } else {
        // Handle error
        print('Failed to fetch reviews. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch reviews');
      }
    } catch (error) {
      // Handle network error
      print('Error fetching reviews: $error');
      throw Exception('Error fetching reviews');
    }
  }

  Future<Map<String, dynamic>> fetchReviewById(int reviewId) async {
    final String apiUrl =
        'https://tajri.raisyam.my.id/book/get-review/$reviewId/';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse and return the review data
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        // Handle error
        print('Failed to fetch review. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch review');
      }
    } catch (error) {
      // Handle network error
      print('Error fetching review: $error');
      throw Exception('Error fetching review');
    }
  }

  Future<void> showEditReviewForm(BuildContext context, int reviewId) async {
    final reviewData = await fetchReviewById(reviewId);
    TextEditingController reviewController =
        TextEditingController(text: reviewData['review']);

    // Show the popup form
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Review'),
          content: Column(
            children: [
              TextFormField(
                controller: reviewController,
                decoration: const InputDecoration(labelText: 'Review'),
                maxLines: 5,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final String apiUrl =
                    'https://tajri.raisyam.my.id/book/edit-review/$reviewId/';
                final request = context.read<CookieRequest>();

                try {
                  final response = await request.postJson(
                    apiUrl,
                    jsonEncode(<String, dynamic>{
                      'review': reviewController.text.trimRight(),
                    }),
                  );

                  if (response['status'] == 'success') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Review berhasil diperbarui'),
                      ),
                    );
                    Navigator.of(context).pop();
                    setState(() {
                      reviews = fetchReviews();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Gagal memperbarui review'),
                      ),
                    );
                  }
                } catch (error) {
                  print('Error updating review: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gagal memperbarui review'),
                    ),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup form
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Review'),
      ),
      body: FutureBuilder<List<Reviews>>(
        future: reviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Belum ada review.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final review = snapshot.data![index];

                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECF2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: Center(
                              child: Text(
                                review.username[0],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.username,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                review.waktu.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF327957),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        review.review,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF327957),
                        ),
                      ),
                      if (context.watch<UserProvider>().loggedInUserName ==
                          review.username)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () async {
                                final String apiUrl =
                                    'https://tajri.raisyam.my.id/book/delete-review/${review.reviewId}/';

                                try {
                                  final response =
                                      await http.delete(Uri.parse(apiUrl));

                                  if (response.statusCode == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Review dihapus'),
                                      ),
                                    );
                                    setState(() {
                                      reviews = fetchReviews();
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Gagal menghapus review'),
                                      ),
                                    );
                                  }
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Error deleting review'),
                                    ),
                                  );
                                }
                              },
                              child: const Text('Hapus'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await showEditReviewForm(
                                    context, review.reviewId);
                              },
                              child: const Text('Edit'),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
