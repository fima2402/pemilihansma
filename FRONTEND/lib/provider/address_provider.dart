import 'package:flutter/widgets.dart';
import 'package:sistem_rekomendasi_sma/service/api_service.dart';

import '../static/address_result_state.dart';

class AddressProvider extends ChangeNotifier {
  final ApiService _apiService;

  AddressProvider(this._apiService);

  AddressListResultState _resultState = AddressListNoneState();
  AddressListResultState get resultState => _resultState;

  Future<void> fetchAddressList() async {
    try {
      _resultState = AddressListLoadingState();
      notifyListeners();

      final result = await _apiService.getAddressList();

      if (result.data == null) {
        _resultState = AddressListErrorState("Data not found.");
        notifyListeners();
      } else {
        _resultState = AddressListLoadedState(result.data!);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = AddressListErrorState(e.toString());
      notifyListeners();
    }
  }
}
