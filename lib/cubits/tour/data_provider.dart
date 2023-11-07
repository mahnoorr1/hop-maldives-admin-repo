part of 'cubit.dart';

class TourDataProvider {
  static final firebase = FirebaseFirestore.instance;
  static final firebaseStorage = FirebaseStorage.instance;
  static final tours = firebase.collection('tours');

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetch() {
    try {
      final stream = tours.snapshots();
      return stream.asBroadcastStream();
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<void> add(Tour tour, List<XFile>? images) async {
    try {
      List<String> urls = await uploadImages(tour.name, images);
      tour.images = urls;

      await tours.doc(tour.id).set(tour.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> update(Tour tour, List<XFile>? images) async {
    try {
      if (images != null) {
        List<String> urls = await uploadImages(tour.name, images);
        tour.images = List.from(tour.images)..addAll(urls);
      }

      await tours.doc(tour.id).update(tour.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> delete(Tour tour) async {
    try {
      deletImages(tour.name, tour.images);
      await tours.doc(tour.id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<String>> uploadImages(
      String tourName, List<XFile>? files) async {
    try {
      List<String> urls = [];
      if (files != null) {
        for (var file in files) {
          Reference ref =
              firebaseStorage.ref('/tours/$tourName/').child(file.name);

          final bytes = await file.readAsBytes();

          await ref.putData(bytes);

          String url = await ref.getDownloadURL();

          urls.add(url);
        }
      }

      return urls;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> deletImages(String tourName, List<String> urls) async {
    try {
      for (var url in urls) {
        firebaseStorage.ref(url).delete();
      }
      firebaseStorage.ref('/tours/$tourName/').delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
