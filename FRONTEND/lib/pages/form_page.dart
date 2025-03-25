import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:provider/provider.dart';
import 'package:sistem_rekomendasi_sma/provider/address_provider.dart';
import 'package:sistem_rekomendasi_sma/response/post_request.dart';
import 'package:sistem_rekomendasi_sma/static/address_result_state.dart';

import '../provider/post_calculate_provider.dart';
import '../response/list_address_response.dart';
import 'result_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String? selectedValue;
  Address? selectedAddress;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<AddressProvider>().fetchAddressList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              "Sistem Rekomendasi Sekolah SMA\nSederajat Kabupaten Bogor",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 30),
            Image.asset(
              "assets/students.png",
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 50),
            Text(
              "Silakan pilih jenis sekolah dan lokasi untuk melihat rekomendasi terbaik untukmu!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                value: selectedValue,
                hint: Text(
                  'Pilih Jenis Sekolah Kamu',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                items: ['SMA', 'SMK', 'MAN']
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            children: [
                              Icon(Icons.school,
                                  color: Colors.blue), // Tambah ikon
                              SizedBox(width: 10),
                              Text(item, style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black87, width: 1),
                    color: Colors.white,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  scrollbarTheme: ScrollbarThemeData(
                    thumbVisibility: WidgetStateProperty.all(true),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Consumer<AddressProvider>(
              builder: (context, provider, child) {
                return switch (provider.resultState) {
                  AddressListLoadingState() => Center(
                      child: CircularProgressIndicator(),
                    ),
                  AddressListErrorState(error: var message) => Text(message),
                  AddressListLoadedState(data: var addressList) =>
                    DropdownButtonHideUnderline(
                        child: DropdownButton2<Address>(
                      isExpanded: true,
                      hint: Text(
                        'Pilih Lokasi Kamu',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      value: selectedAddress,
                      items: addressList.map((address) {
                        return DropdownMenuItem<Address>(
                          value: address,
                          child: Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.blue),
                              SizedBox(width: 10),
                              Text(address.name ?? "Alamat Tidak Diketahui",
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedAddress = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black87, width: 1),
                          color: Colors.white,
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          thumbVisibility: WidgetStateProperty.all(true),
                        ),
                      ),
                    )),
                  _ => SizedBox(),
                };
              },
            ),
            const SizedBox(height: 50),
            Consumer<PostCalculateProvider>(
              builder: (context, provider, child) {
                return MUILoadingButton(
                  text: "Submit Data",
                  loadingStateText: "Please wait",
                  animationDuration: 250, // Sesuai default package
                  bgColor: const Color(0xff205781),
                  loadingStateBackgroundColor:
                      Colors.grey, // Warna saat loading
                  textColor: Colors.white,
                  loadingStateTextColor: Colors.white,
                  borderRadius: 10,
                  onPressed: () async {
                    final provider = Provider.of<PostCalculateProvider>(context,
                        listen: false);

                    try {
                      final data = PostRequest(
                        address: selectedAddress?.id,
                        type: selectedValue?.toLowerCase(),
                      );

                      final result = await provider.postCalculateData(data);

                      if (provider.calculateData != null ||
                          result.ranking?.result != null) {
                        if (!context.mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ResultPage(resultData: provider.calculateData!),
                          ),
                        );
                      } else {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  provider.message ?? "Terjadi kesalahan")),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${e.toString()}")),
                      );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
