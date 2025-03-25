// To parse this JSON data, do
//
//     final listAddressResponse = listAddressResponseFromJson(jsonString);

import 'dart:convert';

ListAddressResponse listAddressResponseFromJson(String str) =>
    ListAddressResponse.fromJson(json.decode(str));

String listAddressResponseToJson(ListAddressResponse data) =>
    json.encode(data.toJson());

class ListAddressResponse {
  final List<Address>? data;

  ListAddressResponse({
    this.data,
  });

  factory ListAddressResponse.fromJson(Map<String, dynamic> json) =>
      ListAddressResponse(
        data: json["data"] == null
            ? []
            : List<Address>.from(json["data"]!.map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Address {
  final String? id;
  final String? name;

  Address({
    this.id,
    this.name,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
