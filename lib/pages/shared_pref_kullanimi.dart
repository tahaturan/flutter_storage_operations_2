import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage_operations_2/model/my_models.dart';

class SharedPreferenceKullanimi extends StatefulWidget {
  const SharedPreferenceKullanimi({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceKullanimi> createState() =>
      _SharedPreferenceKullanimiState();
}

class _SharedPreferenceKullanimiState extends State<SharedPreferenceKullanimi> {
  var secilenCinsiyet = Cinsiyet.KADIN;
  var secilenRenkler = [];
  var ogrenciMi = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreference Kullanimi'),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: TextField(
              decoration: InputDecoration(labelText: "Adinizi Giriniz"),
            ),
          ),
          _buildRadioListTiles("Kadin", Cinsiyet.KADIN),
          _buildRadioListTiles("Erkek", Cinsiyet.ERKEK),
          _buildRadioListTiles("Diger", Cinsiyet.DIGER),
          //Ayirici Cizgi
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          _buildCheckboxListTiles(Renkler.KIRMIZI),
          _buildCheckboxListTiles(Renkler.MAVI),
          _buildCheckboxListTiles(Renkler.SARI),
          _buildCheckboxListTiles(Renkler.YESIL),
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
            onPressed: () {},
            child: const Text(
              "KAYDET",
            ),
          ),
        ],
      ),
    );
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
