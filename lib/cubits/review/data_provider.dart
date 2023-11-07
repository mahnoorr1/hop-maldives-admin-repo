part of 'cubit.dart';

class ReviewDataProvider {
  static final firebase = FirebaseFirestore.instance;
  static final products = firebase.collection('products').doc('data');

  static Future<void> update(
    String id,
    Review review,
    int index, [
    bool? isHotel,
    bool? isResort,
    bool? isIsland,
  ]) async {
    try {
      List<Hotel> hotels = [];
      List<Resort> resorts = [];
      List<Island> islands = [];

      final raw = await products.get();
      if (isHotel!) {
        List data = raw.data()!['hotels'];
        hotels =
            List.generate(data.length, (index) => Hotel.fromMap(data[index]));

        for (var h in hotels) {
          if (h.id.contains(id)) {
            h.reviews.removeAt(index);
            h.reviews.insert(index, review);
          }
        }

        data = List.generate(hotels.length, (index) => hotels[index].toMap());
        await products.update({'hotels': data});
      } else if (isResort!) {
        List data = raw.data()!['resorts'];
        resorts =
            List.generate(data.length, (index) => Resort.fromMap(data[index]));
        for (var r in resorts) {
          if (r.id.contains(id)) {
            r.reviews.removeAt(index);
            r.reviews.insert(index, review);
          }
        }

        data = List.generate(resorts.length, (index) => resorts[index].toMap());
        await products.update({'resorts': data});
      } else if (isIsland!) {
        List data = raw.data()!['islands'];
        islands =
            List.generate(data.length, (index) => Island.fromMap(data[index]));
        for (var i in islands) {
          if (i.id.contains(id)) {
            i.reviews.removeAt(index);
            i.reviews.insert(index, review);
          }
        }

        data = List.generate(islands.length, (index) => islands[index].toMap());
        await products.update({'islands': data});
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
