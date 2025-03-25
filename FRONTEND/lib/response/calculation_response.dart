import 'dart:convert';

CalculationResponse calculationResponseFromJson(String str) =>
    CalculationResponse.fromJson(json.decode(str));

String calculationResponseToJson(CalculationResponse data) =>
    json.encode(data.toJson());

class CalculationResponse {
  final Ranking? ranking;

  CalculationResponse({
    this.ranking,
  });

  factory CalculationResponse.fromJson(Map<String, dynamic> json) =>
      CalculationResponse(
        ranking:
            json["ranking"] == null ? null : Ranking.fromJson(json["ranking"]),
      );

  Map<String, dynamic> toJson() => {
        "ranking": ranking?.toJson(),
      };
}

class Ranking {
  final List<Result>? result;
  final int? length;

  Ranking({
    this.result,
    this.length,
  });

  factory Ranking.fromJson(Map<String, dynamic> json) => Ranking(
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "length": length,
      };
}

class Result {
  final String? id;
  final String? name;
  final String? address;
  final String? type;
  final Accreditation? distance;
  final Accreditation? facility;
  final Accreditation? accreditation;
  final String? linkProfile;
  final Calculation? calculation;

  Result({
    this.id,
    this.name,
    this.address,
    this.type,
    this.distance,
    this.facility,
    this.accreditation,
    this.linkProfile,
    this.calculation,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        type: json["type"],
        distance: json["distance"] == null
            ? null
            : Accreditation.fromJson(json["distance"]),
        facility: json["facility"] == null
            ? null
            : Accreditation.fromJson(json["facility"]),
        accreditation: json["accreditation"] == null
            ? null
            : Accreditation.fromJson(json["accreditation"]),
        linkProfile: json["link_profile"],
        calculation: json["calculation"] == null
            ? null
            : Calculation.fromJson(json["calculation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "type": type,
        "distance": distance?.toJson(),
        "facility": facility?.toJson(),
        "accreditation": accreditation?.toJson(),
        "calculation": calculation?.toJson(),
      };
}

class Accreditation {
  final String? name;
  final int? value;

  Accreditation({
    this.name,
    this.value,
  });

  factory Accreditation.fromJson(Map<String, dynamic> json) => Accreditation(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

class Calculation {
  final double? ahp;
  final double? electreResult;
  final double? sawResult;

  Calculation({
    this.ahp,
    this.electreResult,
    this.sawResult,
  });

  factory Calculation.fromJson(Map<String, dynamic> json) => Calculation(
        ahp: json["ahp"]?.toDouble(),
        electreResult: json["electreResult"]?.toDouble(),
        sawResult: json["sawResult"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ahp": ahp,
        "electreResult": electreResult,
        "sawResult": sawResult,
      };
}
