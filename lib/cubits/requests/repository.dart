part of 'cubit.dart';

class RequestsRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> fetch() =>
      RequestsDataProvider.fetch();

  Future<void> approveRequest(Request request, int index) =>
      RequestsDataProvider.approveRequest(request, index);
}
