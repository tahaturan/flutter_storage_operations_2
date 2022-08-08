import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage_operations_2/model/my_models.dart';
import 'package:flutter_storage_operations_2/services/secure_stroge.dart';

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
  var preferenceService = SecureStorageService();

  @override
  void initState() {
    super.initState();
    verileriOku();
    //*sayfa acildigi anda ilk calisan fonskyon oldugu icin en son yaptigimiz degisiklerde anasayfaya yansiyacaktir
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
              var userInformation = UserInformation(
                  isim: nameController.text,
                  cinsiyet: secilenCinsiyet,
                  renkler: secilenRenkler,
                  ogrenciMi: ogrenciMi);
              preferenceService.verileriKaydet(userInformation);
              //*burada butina basildiginda girilen degerleri yukaridaki degiskenlerimizde tutmustuk ve onlarla kullanicibilgi sinifimizi direk olusturduk
              //*daha sonra prefenreceservice sinifimizdaki kaydet fonksiyonuna kullanicibilgi nesnemizi gonderdik
            },
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

  void verileriOku() async {
    var info = await preferenceService.verileriOku();
    nameController.text = info.isim;
    secilenCinsiyet = info.cinsiyet;
    secilenRenkler = info.renkler;
    ogrenciMi = info.ogrenciMi;
    setState(() {});
    //*burada preferenceServide sinifimizda verilerioku fonksiyonuna eristik ve info(bilgi) adinda degiskene atadik
    //*daha sorna yukaridaki degiskenlerimizi kaydettigimiz son verilerle degistirdik
    //*setState diyerek ekranin guncellenmesini sagladik
  }
}
