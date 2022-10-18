class Positions {
  final double latitude;
  final double longitude;
  final String libelle;

  Positions(
      {required this.libelle, required this.latitude, required this.longitude});
  Positions.fromJson(Map<String, Object?> json)
      : this(
            latitude: double.parse(json['latitude'].toString()),
            longitude: double.parse(json['longitude'].toString()),
            libelle: json['libelle'].toString());

  Map<String, Object?> toJson() {
    return {'latitude': latitude, 'longitude': longitude, 'libelle': libelle};
  }
}
