part of 'cubit.dart';

class ChatRepository {
  Future<void> send(Message message) => ChatDataProvider.send(message);

  Future<void> clean(String doc) => ChatDataProvider.clean(doc);

  Stream<QuerySnapshot<Map<String, dynamic>>> fetch() =>
      ChatDataProvider.fetch();

  Stream<QuerySnapshot<Map<String, dynamic>>> openChat(String doc) =>
      ChatDataProvider.openChat(doc);
}
