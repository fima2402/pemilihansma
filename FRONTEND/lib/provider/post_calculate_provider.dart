import 'package:flutter/widgets.dart';
import 'package:sistem_rekomendasi_sma/response/calculation_response.dart';
import 'package:sistem_rekomendasi_sma/response/post_request.dart';

import '../service/api_service.dart';

class PostCalculateProvider extends ChangeNotifier {
  final ApiService _apiService;

  PostCalculateProvider(this._apiService);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _message;
  String? get message => _message;

  List<Result>? _calculateData = [];
  List<Result>? get calculateData => _calculateData;

  Future<CalculationResponse> postCalculateData(PostRequest data) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiService.postCalculateData(data);

      if (result.ranking?.result == null) {
        _isLoading = false;
        _message = "Cannot find the result";
        notifyListeners();
        return result;
      } else {
        _isLoading = false;
        _message = "Result founded.";
        _calculateData = result.ranking?.result;
        notifyListeners();
        return result;
      }
    } catch (e) {
      _message = e.toString();
      _isLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }
}
