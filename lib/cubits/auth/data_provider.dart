part of 'cubit.dart';

class AuthDataProvider {
  static final cache = Hive.box('users');
  static final firebaseFirestore = FirebaseFirestore.instance;
  static final userCollection = firebaseFirestore.collection('users');

  static Future<User> login(String email, String password) async {
    try {
      User user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user!;

      cache.put(user.uid, user.uid);

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          throw Exception(
              "Invalid password or email address. Please Try again!");

        case "user-not-found":
          throw Exception(
              "Account not found against this email address, please sign up!");

        case "invalid-email":
          throw Exception(
              "Invalid password or email address. Please Try again!");

        case "account-exists-with-different-credential":
          throw Exception(
              "Account already logged in via social login. Please try alternative way.");

        default:
          throw Exception(
            e.message,
          );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> logout() async {
    try {
      FirebaseAuth.instance.currentUser!.providerData;

      await cache.delete(FirebaseAuth.instance.currentUser!.uid);

      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
