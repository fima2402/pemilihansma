import '../response/list_address_response.dart';

sealed class AddressListResultState {}

class AddressListNoneState extends AddressListResultState {}

class AddressListLoadingState extends AddressListResultState {}

class AddressListErrorState extends AddressListResultState {
  final String error;

  AddressListErrorState(this.error);
}

class AddressListLoadedState extends AddressListResultState {
  final List<Address> data;

  AddressListLoadedState(this.data);
}
