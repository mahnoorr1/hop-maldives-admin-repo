part of 'cubit.dart';

class ChatDataProvider {
  static final firestore = FirebaseFirestore.instance;
  static final chatCollection = firestore.collection('chats');

  static Future<void> send(Message message) async {
    try {
      final ref = firestore.collection('chats/${message.to}/messages');

      await ref.add(message.toMap());
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetch() {
    try {
      final messagesStream = firestore.collection('chats').snapshots();

      return messagesStream.asBroadcastStream();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> openChat(String doc) {
    try {
      final messagesStream = firestore
          .collection('chats/$doc/messages')
          .orderBy('createdAt', descending: true)
          .snapshots();

      return messagesStream.asBroadcastStream();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> clean(String doc) async {
    try {
      final data = await firestore.collection('chats/$doc/messages').get();

      for (var d in data.docs) {
        await d.reference.delete();
      }

      await firestore.collection('chats').doc(doc).delete();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
