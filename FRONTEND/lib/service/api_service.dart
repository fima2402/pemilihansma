import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sistem_rekomendasi_sma/response/calculation_response.dart';
import 'package:sistem_rekomendasi_sma/response/list_address_response.dart';
import 'package:sistem_rekomendasi_sma/response/post_request.dart';

class ApiService {
  static const String _baseUrl = "https://recomendation-system-six.vercel.app";

  Future<ListAddressResponse> getAddressList() async {
    final response = await http.get(Uri.parse("$_baseUrl/address"));

    if (response.statusCode == 200) {
      return ListAddressResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load address list');
    }
  }

  Future<CalculationResponse> postCalculateData(PostRequest data) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/recomendation_system"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode == 200) {
      return CalculationResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to calculate data');
    }
  }
}
