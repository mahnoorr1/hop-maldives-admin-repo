part of 'cubit.dart';

class RequestsDataProvider {
  static final requestsCollection =
      FirebaseFirestore.instance.collection('requests');

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetch() {
    try {
      final requestsStream = requestsCollection.snapshots();
      return requestsStream.asBroadcastStream();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> approveRequest(Request request, int index) async {
    try {
      final raw = await requestsCollection.doc(request.userId).get();
      List data = raw.data()!['requests'];

      data.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));

      data.removeAt(index);

      data.insert(
        index,
        request.toMap(),
      );

      await requestsCollection.doc(request.userId).set(
        {'requests': data},
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
