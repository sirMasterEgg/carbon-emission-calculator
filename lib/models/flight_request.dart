class FlightRequest {
  String? type;
  int passenger;
  String? distance_unit;
  List<Leg>? legs;

  FlightRequest({
    required this.passenger,
    this.distance_unit,
    required departure,
    required destination,
    required cabin_class
  }) {
    type = 'flight';
    legs?.add(Leg(departure, destination, cabin_class));
  }
}

class Leg {
  String? departure_airport;
  String? destination_airport;
  String? cabin_class;

  Leg(this.departure_airport, this.destination_airport, this.cabin_class);


}