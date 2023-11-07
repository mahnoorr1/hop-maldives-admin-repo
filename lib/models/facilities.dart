import 'dart:convert';

class Facilities {
  final bool wifi;
  final bool pool;
  final bool beach;
  final bool medkit;
  final bool passengerLift;
  final bool airportTransfers;
  final bool parking;
  final bool restaurant;
  final bool carRental;
  final bool laundry;
  final bool tv;

  Facilities({
    required this.wifi,
    required this.pool,
    required this.beach,
    required this.medkit,
    required this.passengerLift,
    required this.airportTransfers,
    required this.parking,
    required this.restaurant,
    required this.carRental,
    required this.laundry,
    required this.tv,
  });

  Facilities copyWith({
    bool? wifi,
    bool? pool,
    bool? beach,
    bool? medkit,
    bool? passengerLift,
    bool? airportTransfers,
    bool? parking,
    bool? restaurant,
    bool? carRental,
    bool? laundry,
    bool? tv,
  }) {
    return Facilities(
      wifi: wifi ?? this.wifi,
      pool: pool ?? this.pool,
      beach: beach ?? this.beach,
      medkit: medkit ?? this.medkit,
      passengerLift: passengerLift ?? this.passengerLift,
      airportTransfers: airportTransfers ?? this.airportTransfers,
      parking: parking ?? this.parking,
      restaurant: restaurant ?? this.restaurant,
      carRental: carRental ?? this.carRental,
      laundry: laundry ?? this.laundry,
      tv: tv ?? this.tv,
    );
  }

  Map<String, bool> toMap() {
    return {
      'wifi': wifi,
      'pool': pool,
      'beach': beach,
      'medkit': medkit,
      'passengerLift': passengerLift,
      'airportTransfers': airportTransfers,
      'parking': parking,
      'restaurant': restaurant,
      'carRental': carRental,
      'laundry': laundry,
      'tv': tv,
    };
  }

  factory Facilities.fromMap(Map<String, dynamic> map) {
    return Facilities(
      wifi: map['wifi'] ?? false,
      pool: map['pool'] ?? false,
      beach: map['beach'] ?? false,
      medkit: map['medkit'] ?? false,
      passengerLift: map['passengerLift'] ?? false,
      airportTransfers: map['airportTransfers'] ?? false,
      parking: map['parking'] ?? false,
      restaurant: map['restaurant'] ?? false,
      carRental: map['carRental'] ?? false,
      laundry: map['laundry'] ?? false,
      tv: map['tv'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Facilities.fromJson(String source) =>
      Facilities.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Facilities(wifi: $wifi, pool: $pool, beach: $beach, medkit: $medkit, passengerLift: $passengerLift, airportTransfers: $airportTransfers, parking: $parking, restaurant: $restaurant, carRental: $carRental, laundry: $laundry, tv: $tv)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Facilities &&
        other.wifi == wifi &&
        other.pool == pool &&
        other.beach == beach &&
        other.medkit == medkit &&
        other.passengerLift == passengerLift &&
        other.airportTransfers == airportTransfers &&
        other.parking == parking &&
        other.restaurant == restaurant &&
        other.carRental == carRental &&
        other.laundry == laundry &&
        other.tv == tv;
  }

  @override
  int get hashCode {
    return wifi.hashCode ^
        pool.hashCode ^
        beach.hashCode ^
        medkit.hashCode ^
        passengerLift.hashCode ^
        airportTransfers.hashCode ^
        parking.hashCode ^
        restaurant.hashCode ^
        carRental.hashCode ^
        laundry.hashCode ^
        tv.hashCode;
  }
}
