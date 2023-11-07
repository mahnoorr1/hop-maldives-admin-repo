part of 'cubit.dart';

class ResortsRepository {
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() =>
      ResortsDataProvider.fetch();

  Future<void> add(Resort resort, List<XFile>? images) =>
      ResortsDataProvider.add(resort, images);

  Future<void> update(Resort resort, List<XFile>? images, int index) =>
      ResortsDataProvider.update(resort, images, index);

  Future<void> delete(int index) => ResortsDataProvider.delete(index);
}
