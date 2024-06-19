import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MapFetch {
  final String location;

  MapFetch({
    required this.location,
  });

  factory MapFetch.fromJson(Map<String, dynamic> json) {
    return MapFetch(
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toString(),
    };
  }

  Future<void> navigateToPayPage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not logged in');
      return;
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Customer_Details')
        .where('user_ID', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        var data = documentSnapshot.data() as Map<String, dynamic>;
        if (data.containsKey('location')) {
          String location = data['location'];
        } else {
          print('location not found in document');
        }
      } else {
        print('Document does not exist');
      }
    } else {
      print('No documents found for the current user');
    }
  }
}
