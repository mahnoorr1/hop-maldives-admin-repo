part of 'cubit.dart';

class UsersRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> fetch() =>
      UsersDataProvider.fetch();
}
