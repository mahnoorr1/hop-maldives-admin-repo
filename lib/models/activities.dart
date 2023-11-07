// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Activities {
  final bool bigGameFishing;
  final bool canoeing;
  final bool catamaranSailing;
  final bool flyBoard;
  final bool funTube;
  final bool glassBottomBoat;
  final bool jetBlade;
  final bool jetSkiTours;
  final bool kiteSurfing;
  final bool kneeBoarding;
  final bool parasailing;
  final bool schillerBike;
  final bool seaBob;
  final bool semiSubmarine;
  final bool snorkling;
  final bool speedBoat;
  final bool speedster;
  final bool standUpPaddleBoat;
  final bool sunsetCruise;
  final bool supSki;
  final bool surfing;
  final bool swimming;
  final bool trimaranSailing;
  final bool wakeBoarding;
  final bool waterSki;
  final bool windSurfing;
  final bool bananaBoatRide;
  final bool jetSki;
  Activities({
    required this.bigGameFishing,
    required this.canoeing,
    required this.catamaranSailing,
    required this.flyBoard,
    required this.funTube,
    required this.glassBottomBoat,
    required this.jetBlade,
    required this.jetSkiTours,
    required this.kiteSurfing,
    required this.kneeBoarding,
    required this.parasailing,
    required this.schillerBike,
    required this.seaBob,
    required this.semiSubmarine,
    required this.snorkling,
    required this.speedBoat,
    required this.speedster,
    required this.standUpPaddleBoat,
    required this.sunsetCruise,
    required this.supSki,
    required this.surfing,
    required this.swimming,
    required this.trimaranSailing,
    required this.wakeBoarding,
    required this.waterSki,
    required this.windSurfing,
    required this.bananaBoatRide,
    required this.jetSki,
  });

  Activities copyWith({
    bool? bigGameFishing,
    bool? canoeing,
    bool? catamaranSailing,
    bool? flyBoard,
    bool? funTube,
    bool? glassBottomBoat,
    bool? jetBlade,
    bool? jetSkiTours,
    bool? kiteSurfing,
    bool? kneeBoarding,
    bool? parasailing,
    bool? schillerBike,
    bool? seaBob,
    bool? semiSubmarine,
    bool? snorkling,
    bool? speedBoat,
    bool? speedster,
    bool? standUpPaddleBoat,
    bool? sunsetCruise,
    bool? supSki,
    bool? surfing,
    bool? swimming,
    bool? trimaranSailing,
    bool? wakeBoarding,
    bool? waterSki,
    bool? windSurfing,
    bool? bananaBoatRide,
    bool? jetSki,
  }) {
    return Activities(
      bigGameFishing: bigGameFishing ?? this.bigGameFishing,
      canoeing: canoeing ?? this.canoeing,
      catamaranSailing: catamaranSailing ?? this.catamaranSailing,
      flyBoard: flyBoard ?? this.flyBoard,
      funTube: funTube ?? this.funTube,
      glassBottomBoat: glassBottomBoat ?? this.glassBottomBoat,
      jetBlade: jetBlade ?? this.jetBlade,
      jetSkiTours: jetSkiTours ?? this.jetSkiTours,
      kiteSurfing: kiteSurfing ?? this.kiteSurfing,
      kneeBoarding: kneeBoarding ?? this.kneeBoarding,
      parasailing: parasailing ?? this.parasailing,
      schillerBike: schillerBike ?? this.schillerBike,
      seaBob: seaBob ?? this.seaBob,
      semiSubmarine: semiSubmarine ?? this.semiSubmarine,
      snorkling: snorkling ?? this.snorkling,
      speedBoat: speedBoat ?? this.speedBoat,
      speedster: speedster ?? this.speedster,
      standUpPaddleBoat: standUpPaddleBoat ?? this.standUpPaddleBoat,
      sunsetCruise: sunsetCruise ?? this.sunsetCruise,
      supSki: supSki ?? this.supSki,
      surfing: surfing ?? this.surfing,
      swimming: swimming ?? this.swimming,
      trimaranSailing: trimaranSailing ?? this.trimaranSailing,
      wakeBoarding: wakeBoarding ?? this.wakeBoarding,
      waterSki: waterSki ?? this.waterSki,
      windSurfing: windSurfing ?? this.windSurfing,
      bananaBoatRide: bananaBoatRide ?? this.bananaBoatRide,
      jetSki: jetSki ?? this.jetSki,
    );
  }

  Map<String, bool> toMap() {
    return <String, bool>{
      'bigGameFishing': bigGameFishing,
      'canoeing': canoeing,
      'catamaranSailing': catamaranSailing,
      'flyBoard': flyBoard,
      'funTube': funTube,
      'glassBottomBoat': glassBottomBoat,
      'jetBlade': jetBlade,
      'jetSkiTours': jetSkiTours,
      'kiteSurfing': kiteSurfing,
      'kneeBoarding': kneeBoarding,
      'parasailing': parasailing,
      'schillerBike': schillerBike,
      'seaBob': seaBob,
      'semiSubmarine': semiSubmarine,
      'snorkling': snorkling,
      'speedBoat': speedBoat,
      'speedster': speedster,
      'standUpPaddleBoat': standUpPaddleBoat,
      'sunsetCruise': sunsetCruise,
      'supSki': supSki,
      'surfing': surfing,
      'swimming': swimming,
      'trimaranSailing': trimaranSailing,
      'wakeBoarding': wakeBoarding,
      'waterSki': waterSki,
      'windSurfing': windSurfing,
      'bananaBoatRide': bananaBoatRide,
      'jetSki': jetSki,
    };
  }

  factory Activities.fromMap(Map<String, dynamic> map) {
    return Activities(
      bigGameFishing: map['bigGameFishing'] ?? false,
      canoeing: map['canoeing'] ?? false,
      catamaranSailing: map['catamaranSailing'] ?? false,
      flyBoard: map['flyBoard'] ?? false,
      funTube: map['funTube'] ?? false,
      glassBottomBoat: map['glassBottomBoat'] ?? false,
      jetBlade: map['jetBlade'] ?? false,
      jetSkiTours: map['jetSkiTours'] ?? false,
      kiteSurfing: map['kiteSurfing'] ?? false,
      kneeBoarding: map['kneeBoarding'] ?? false,
      parasailing: map['parasailing'] ?? false,
      schillerBike: map['schillerBike'] ?? false,
      seaBob: map['seaBob'] ?? false,
      semiSubmarine: map['semiSubmarine'] ?? false,
      snorkling: map['snorkling'] ?? false,
      speedBoat: map['speedBoat'] ?? false,
      speedster: map['speedster'] ?? false,
      standUpPaddleBoat: map['standUpPaddleBoat'] ?? false,
      sunsetCruise: map['sunsetCruise'] ?? false,
      supSki: map['supSki'] ?? false,
      surfing: map['surfing'] ?? false,
      swimming: map['swimming'] ?? false,
      trimaranSailing: map['trimaranSailing'] ?? false,
      wakeBoarding: map['wakeBoarding'] ?? false,
      waterSki: map['waterSki'] ?? false,
      windSurfing: map['windSurfing'] ?? false,
      bananaBoatRide: map['bananaBoatRide'] ?? false,
      jetSki: map['jetSki'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Activities.fromJson(String source) =>
      Activities.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Activities(bigGameFishing: $bigGameFishing, canoeing: $canoeing, catamaranSailing: $catamaranSailing, flyBoard: $flyBoard, funTube: $funTube, glassBottomBoat: $glassBottomBoat, jetBlade: $jetBlade, jetSkiTours: $jetSkiTours, kiteSurfing: $kiteSurfing, kneeBoarding: $kneeBoarding, parasailing: $parasailing, schillerBike: $schillerBike, seaBob: $seaBob, semiSubmarine: $semiSubmarine, snorkling: $snorkling, speedBoat: $speedBoat, speedster: $speedster, standUpPaddleBoat: $standUpPaddleBoat, sunsetCruise: $sunsetCruise, supSki: $supSki, surfing: $surfing, swimming: $swimming, trimaranSailing: $trimaranSailing, wakeBoarding: $wakeBoarding, waterSki: $waterSki, windSurfing: $windSurfing, bananaBoatRide: $bananaBoatRide, jetSki: $jetSki)';
  }

  @override
  bool operator ==(covariant Activities other) {
    if (identical(this, other)) return true;

    return other.bigGameFishing == bigGameFishing &&
        other.canoeing == canoeing &&
        other.catamaranSailing == catamaranSailing &&
        other.flyBoard == flyBoard &&
        other.funTube == funTube &&
        other.glassBottomBoat == glassBottomBoat &&
        other.jetBlade == jetBlade &&
        other.jetSkiTours == jetSkiTours &&
        other.kiteSurfing == kiteSurfing &&
        other.kneeBoarding == kneeBoarding &&
        other.parasailing == parasailing &&
        other.schillerBike == schillerBike &&
        other.seaBob == seaBob &&
        other.semiSubmarine == semiSubmarine &&
        other.snorkling == snorkling &&
        other.speedBoat == speedBoat &&
        other.speedster == speedster &&
        other.standUpPaddleBoat == standUpPaddleBoat &&
        other.sunsetCruise == sunsetCruise &&
        other.supSki == supSki &&
        other.surfing == surfing &&
        other.swimming == swimming &&
        other.trimaranSailing == trimaranSailing &&
        other.wakeBoarding == wakeBoarding &&
        other.waterSki == waterSki &&
        other.windSurfing == windSurfing &&
        other.bananaBoatRide == bananaBoatRide &&
        other.jetSki == jetSki;
  }

  @override
  int get hashCode {
    return bigGameFishing.hashCode ^
        canoeing.hashCode ^
        catamaranSailing.hashCode ^
        flyBoard.hashCode ^
        funTube.hashCode ^
        glassBottomBoat.hashCode ^
        jetBlade.hashCode ^
        jetSkiTours.hashCode ^
        kiteSurfing.hashCode ^
        kneeBoarding.hashCode ^
        parasailing.hashCode ^
        schillerBike.hashCode ^
        seaBob.hashCode ^
        semiSubmarine.hashCode ^
        snorkling.hashCode ^
        speedBoat.hashCode ^
        speedster.hashCode ^
        standUpPaddleBoat.hashCode ^
        sunsetCruise.hashCode ^
        supSki.hashCode ^
        surfing.hashCode ^
        swimming.hashCode ^
        trimaranSailing.hashCode ^
        wakeBoarding.hashCode ^
        waterSki.hashCode ^
        windSurfing.hashCode ^
        bananaBoatRide.hashCode ^
        jetSki.hashCode;
  }
}
