import 'position.dart';

class Lieu {
  final String libelle;
  final String cat;
  final Positions position;

  Lieu({required this.position, required this.libelle, required this.cat});

  Lieu.fromJson(Map<String, Object?> json)
      : this(
            libelle: json['libelle'].toString(),
            cat: json['cat'].toString(),
            position:
                Positions.fromJson(json['position'] as Map<String, Object?>));

  Map<String, Object?> toJson() {
    return {'position': position.toJson(), 'libelle': libelle, 'cat': cat};
  }
}
