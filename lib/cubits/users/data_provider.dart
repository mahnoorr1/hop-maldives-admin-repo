part of 'cubit.dart';

class UsersDataProvider {
  static final userCollection = FirebaseFirestore.instance.collection('users');

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetch() {
    try {
      final requestsStream = userCollection.snapshots();
      return requestsStream.asBroadcastStream();
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
