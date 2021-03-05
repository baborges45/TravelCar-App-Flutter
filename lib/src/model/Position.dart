class Position {
  final int id;
  final int vehicleId;
  final int datetime;
  final double latitude;
  final double longitude;
  final String address;
  final bool ignition;
  final int hodometro;

  Position(this.id, this.vehicleId, this.datetime, this.latitude,
      this.longitude, this.address, this.ignition, this.hodometro);
}
