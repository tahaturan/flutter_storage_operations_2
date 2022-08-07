import 'package:flutter/material.dart';
import 'package:flutter_storage_operations_2/pages/shared_pref_kullanimi.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anasayfa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SharedPreferenceKullanimi(),
                    ));
              },
              child: const Text(
                "SharedPreference Kullanimi",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
