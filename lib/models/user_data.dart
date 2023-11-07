import 'dart:convert';

class UserData {
  final String uid;
  final String fullName;
  final String email;
  UserData({
    required this.uid,
    required this.fullName,
    required this.email,
  });

  UserData copyWith({
    String? uid,
    String? fullName,
    String? email,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': uid,
      'fullName': fullName,
      'email': email,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['id'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserData(id: $uid, fullName: $fullName, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.uid == uid &&
        other.fullName == fullName &&
        other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ fullName.hashCode ^ email.hashCode;
}
