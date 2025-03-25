import 'dart:convert';

PostRequest postRequestFromJson(String str) =>
    PostRequest.fromJson(json.decode(str));

String postRequestToJson(PostRequest data) => json.encode(data.toJson());

class PostRequest {
  final String? address;
  final String? type;

  PostRequest({
    this.address,
    this.type,
  });

  factory PostRequest.fromJson(Map<String, dynamic> json) => PostRequest(
        address: json["address"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "type": type,
      };
}
