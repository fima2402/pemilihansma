import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sistem_rekomendasi_sma/pages/form_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../response/calculation_response.dart';

class ResultPage extends StatelessWidget {
  final List<Result> resultData;

  const ResultPage({required this.resultData, super.key});

  @override
  Widget build(BuildContext context) {
    String getDistanceLabel(int? value) {
      switch (value) {
        case 1:
          return "Jauh";
        case 2:
          return "Sedang"; // Bisa diganti dengan istilah lain
        case 3:
          return "Dekat";
        default:
          return "Tidak diketahui";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Hasil"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Text(
              "Berikut adalah daftar sekolah terbaik berdasarkan metode perhitungan yang telah diproses. Pilih sekolah yang sesuai dengan preferensimu!"),
          const SizedBox(height: 18),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: min(5, resultData.length),
            itemBuilder: (context, index) {
              final result = resultData[index];

              Color? backgroundColor;
              switch (index) {
                case 0:
                  backgroundColor = Color(0xffE7D283);
                  break;
                case 1:
                  backgroundColor = Color(0xffBBB9B3);
                  break;
                case 2:
                  backgroundColor = Color(0xffC08B5C);
                  break;
                default:
                  backgroundColor = Colors.white;
              }

              return Card(
                color: backgroundColor,
                margin: EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(result.name ?? "No Name"),
                  subtitle: Text(result.address ?? "No address"),
                  trailing: Icon(Icons.more_horiz_outlined),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Detail Sekolah'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${result.name} (${result.type!.toUpperCase()})",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(result.address ?? "No address school"),
                                ],
                              ),
                              const SizedBox(height: 15),
                              InkWell(
                                onTap: () async {
                                  final Uri url =
                                      Uri.parse(result.linkProfile!);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url,
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Tidak dapat membuka link')),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Profil Sekolah', //text terlalu panjang (overflowed)
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text("Akreditasi: ${result.accreditation?.name}"),
                              Text("Fasilitas: ${result.facility?.name}"),
                              Text(
                                  "Jarak tempuh ke sekolah: ${getDistanceLabel(result.distance?.value)}"),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Icon(
                                    Icons.graphic_eq,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Hasil Perhitungan",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text("AHP: ${result.calculation?.ahp}"),
                              Text(
                                  "ELECTRE: ${result.calculation?.electreResult}"),
                              Text("SAW: ${result.calculation?.sawResult}"),
                              const SizedBox(height: 15),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: Navigator.of(context).pop,
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          Text("Ingin mencari rekomendasi sekolah lain?"),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff7A8183)),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormPage(),
                  ),
                  (route) => false,
                );
              },
              child: Text(
                "Coba Lagi",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
