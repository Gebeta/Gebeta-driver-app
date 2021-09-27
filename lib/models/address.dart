class Address {
  final double latitude;
  final double longtiude;

  Address(this.latitude, this.longtiude);

  factory Address.fromJson(dynamic json) {
    return Address(json['latitude'] as double, json['longtiude'] as double);
  }

  Map toJson() => {
        'latitude': latitude,
        'longtiude': longtiude,
      };

  @override
  String toString() {
    return '{ ${this.latitude}, ${this.longtiude} }';
  }
}
