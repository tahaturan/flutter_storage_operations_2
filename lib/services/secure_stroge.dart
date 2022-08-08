import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_storage_operations_2/model/my_models.dart';

class SecureStorageService {
  void verileriKaydet(UserInformation userInformation) async {
    const preferences = FlutterSecureStorage();
    await preferences.write(key: "isim", value: userInformation.isim);
    await preferences.write(
        key: "ogrenci", value: userInformation.ogrenciMi.toString());
    await preferences.write(
        key: "cinsiyet", value: userInformation.cinsiyet.index.toString());
    await preferences.write(
        key: "renkler", value: jsonEncode(userInformation.renkler));
  }

  Future<UserInformation> verileriOku() async {
    const preferences = FlutterSecureStorage();

    var isim = await preferences.read(key: "isim") ?? "";
    var ogrenciString = await preferences.read(key: "ogrenci") ?? "false";
    var ogrenci = ogrenciString.toLowerCase() == "true" ? true : false;
    var cinsiyetString = await preferences.read(key: "cinsiyet") ?? "0";
    var cinsiyet = Cinsiyet.values[int.parse(cinsiyetString)];
    var renklerString = await preferences.read(key: "renkler");
    var renkler = renklerString == null
        ? <String>[]
        : List<String>.from(jsonDecode(renklerString));

    return UserInformation(
        isim: isim, cinsiyet: cinsiyet, renkler: renkler, ogrenciMi: ogrenci);
  }
}
