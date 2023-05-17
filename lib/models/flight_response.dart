class FlightResponse {
  Data? data;

  FlightResponse({this.data});

  FlightResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? type;
  Attributes? attributes;

  Data({this.id, this.type, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  num? passengers;
  List<Legs>? legs;
  String? estimatedAt;
  num? carbonG;
  num? carbonLb;
  num? carbonKg;
  num? carbonMt;
  String? distanceUnit;
  double? distanceValue;

  Attributes(
      {this.passengers,
        this.legs,
        this.estimatedAt,
        this.carbonG,
        this.carbonLb,
        this.carbonKg,
        this.carbonMt,
        this.distanceUnit,
        this.distanceValue});

  Attributes.fromJson(Map<String, dynamic> json) {
    passengers = json['passengers'];
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add(Legs.fromJson(v));
      });
    }
    estimatedAt = json['estimated_at'];
    carbonG = json['carbon_g'];
    carbonLb = json['carbon_lb'];
    carbonKg = json['carbon_kg'];
    carbonMt = json['carbon_mt'];
    distanceUnit = json['distance_unit'];
    distanceValue = json['distance_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['passengers'] = this.passengers;
    if (this.legs != null) {
      data['legs'] = this.legs!.map((v) => v.toJson()).toList();
    }
    data['estimated_at'] = this.estimatedAt;
    data['carbon_g'] = this.carbonG;
    data['carbon_lb'] = this.carbonLb;
    data['carbon_kg'] = this.carbonKg;
    data['carbon_mt'] = this.carbonMt;
    data['distance_unit'] = this.distanceUnit;
    data['distance_value'] = this.distanceValue;
    return data;
  }
}

class Legs {
  String? departureAirport;
  String? destinationAirport;

  Legs({this.departureAirport, this.destinationAirport});

  Legs.fromJson(Map<String, dynamic> json) {
    departureAirport = json['departure_airport'];
    destinationAirport = json['destination_airport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departure_airport'] = this.departureAirport;
    data['destination_airport'] = this.destinationAirport;
    return data;
  }
}
