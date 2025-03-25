import 'package:flutter/material.dart';

import '../common/transition.dart';
import 'form_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigateWithDelay(context, FormPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/app-logo.jpg"),
            Text(
              "Sistem Rekomendasi Sekolah SMA\nSederajat Kabupaten Bogor",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Text("Fikri Maulana"),
            Text("065118295"),
            Text("2025")
          ],
        ),
      ),
    );
  }
}
