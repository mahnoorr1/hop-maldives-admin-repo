import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hop_maldives_admin/models/request.dart';

class BookingRequests {
  final String uid;
  final List<Request> requests;
  BookingRequests({
    required this.uid,
    required this.requests,
  });

  BookingRequests copyWith({
    String? uid,
    List<Request>? requests,
  }) {
    return BookingRequests(
      uid: uid ?? this.uid,
      requests: requests ?? this.requests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'requests': requests.map((x) => x.toMap()).toList(),
    };
  }

  factory BookingRequests.fromMap(Map<String, dynamic> map) {
    return BookingRequests(
      uid: map['uid'] as String,
      requests: List<Request>.from(
        (map['requests'] as List<Request>).map<Request>(
          (x) => x,
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingRequests.fromJson(String source) =>
      BookingRequests.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BookingRequests(uid: $uid, requests: $requests)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingRequests &&
        other.uid == uid &&
        listEquals(other.requests, requests);
  }

  @override
  int get hashCode => uid.hashCode ^ requests.hashCode;
}
