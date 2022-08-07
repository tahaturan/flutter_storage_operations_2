import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage_operations_2/model/my_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceKullanimi extends StatefulWidget {
  const SharedPreferenceKullanimi({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceKullanimi> createState() =>
      _SharedPreferenceKullanimiState();
}

class _SharedPreferenceKullanimiState extends State<SharedPreferenceKullanimi> {
  var secilenCinsiyet = Cinsiyet.KADIN;
  List<String> secilenRenkler = [];
  var ogrenciMi = false;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    verileriOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreference Kullanimi'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Adinizi Giriniz"),
            ),
          ),
          for (var item in Cinsiyet.values)
            _buildRadioListTiles(describeEnum(item), item),
          //Ayirici Cizgi
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          for (var item in Renkler.values) _buildCheckboxListTiles(item),

          SwitchListTile(
            title: const Text("Ogenci misin"),
            value: ogrenciMi,
            onChanged: (bool deger) {
              setState(() {
                ogrenciMi = deger;
              });
            },
          ),
          TextButton(
            onPressed: () {
              verileriKaydet();
            },
            child: const Text(
              "KAYDET",
            ),
          ),
        ],
      ),
    );
  }

  void verileriKaydet() async {
    final name = nameController.text;
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("isim", name);
    preferences.setBool("ogrenci", ogrenciMi);
    preferences.setInt("cinsiyet", secilenCinsiyet.index);
    preferences.setStringList("renkler", secilenRenkler);
  }

  void verileriOku() async {
    final preferences = await SharedPreferences.getInstance();
    nameController.text = preferences.getString("isim") ?? "";
    ogrenciMi = preferences.getBool("ogrenci") ?? false;
    secilenCinsiyet = Cinsiyet.values[preferences.getInt("cinsiyet") ?? 0];
    secilenRenkler = preferences.getStringList("renkler") ?? <String>[];
    setState(() {});
  }

  CheckboxListTile _buildCheckboxListTiles(Renkler renk) {
    return CheckboxListTile(
      title: Text(describeEnum(renk)),
      value: secilenRenkler.contains(describeEnum(renk)),
      onChanged: (bool? deger) {
        if (deger == false) {
          secilenRenkler.remove(describeEnum(renk));
        } else {
          secilenRenkler.add(describeEnum(renk));
        }
        setState(() {});
      },
    );
  }

  RadioListTile<Cinsiyet> _buildRadioListTiles(
      String title, Cinsiyet cinsiyet) {
    return RadioListTile(
      title: Text(title),
      value: cinsiyet,
      groupValue: secilenCinsiyet,
      onChanged: (Cinsiyet? secilmisCinsiyet) {
        setState(() {
          secilenCinsiyet = secilmisCinsiyet!;
        });
      },
    );
  }
}
