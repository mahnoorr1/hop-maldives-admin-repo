part of 'cubit.dart';

class ExcursionRepository {
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() =>
      ExcursionDataProvider.fetch();

  Future<void> add(Excursion exc, List<XFile>? images) =>
      ExcursionDataProvider.add(exc, images);

  Future<void> update(Excursion exc, List<XFile>? images, int index) =>
      ExcursionDataProvider.update(exc, images, index);

  Future<void> delete(int index) => ExcursionDataProvider.delete(index);
}
