part of 'cubit.dart';

class HotelsDataProvider {
  static final firebase = FirebaseFirestore.instance;
  static final firebaseStorage = FirebaseStorage.instance;
  static final products = firebase.collection('products').doc('data');

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() {
    try {
      final raw = products.snapshots();
      return raw.asBroadcastStream();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> add(Hotel hotel, List<XFile>? images) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['hotels'] ?? [];

      List<String> urls = await uploadImages(hotel.name, images);
      hotel.images = urls;

      data.add(hotel.toMap());

      map['hotels'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> update(
      Hotel hotel, List<XFile>? images, int index) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['hotels'] ?? [];

      List<String> urls = await uploadImages(hotel.name, images);
      hotel.images = List.from(hotel.images)..addAll(urls);

      data.removeAt(index);
      data.insert(index, hotel.toMap());

      map['hotels'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> delete(int index) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['hotels'] ?? [];

      Hotel hotel = Hotel.fromMap(data[index]);
      deletImages(hotel.name, hotel.images);

      data.removeAt(index);

      map['hotels'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<String>> uploadImages(
      String hotelName, List<XFile>? files) async {
    try {
      List<String> urls = [];
      if (files != null) {
        for (var file in files) {
          Reference ref =
              firebaseStorage.ref('/hotels/$hotelName/').child(file.name);

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

  static Future<void> deletImages(String hotelName, List<String> urls) async {
    try {
      for (var url in urls) {
        firebaseStorage.ref(url).delete();
      }
      firebaseStorage.ref('/hotels/$hotelName/').delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
