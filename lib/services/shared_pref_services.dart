import 'package:flutter_storage_operations_2/model/my_models.dart';
import 'package:flutter_storage_operations_2/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
//*veritabani islmelerimizi widget kodlarimizdan ayirdik boylelikle daha okunabilir bir kod elde ettik

class SharedPreferenceService implements LocalStorageService {
  @override
  Future<void> verileriKaydet(UserInformation userInformation) async {
    //*olusturdugumuz kullanicibilgisi turunde bir nesne alacak dedik burasi
    final preferences = await SharedPreferences.getInstance();
    //*ve tek tek model sinifimiza gelen verileri dogru sekilde kaydettik
    preferences.setString("isim", userInformation.isim);
    preferences.setBool("ogrenci", userInformation.ogrenciMi);
    preferences.setInt("cinsiyet", userInformation.cinsiyet.index);
    preferences.setStringList("renkler", userInformation.renkler);
    //*Burada verilerimizi girdigimiz zaman bir key ve deger seklinde tek tek kaydettik
    //*boylelikle verilerimiz saklanmsi olacak ve uygulama kapatildiginda silinmemis olacak
  }

  @override
  Future<UserInformation> verileriOku() async {
    final preferences = await SharedPreferences.getInstance();
    //*kaydettigimiz verileri key olarak degerlerini almak istedik ?? anlami null gelirsedir null gelirsede by degeri kullan demis olduk
    var isim = preferences.getString("isim") ?? "";
    var ogrenci = preferences.getBool("ogrenci") ?? false;
    var cinsiyet = Cinsiyet.values[preferences.getInt("cinsiyet") ?? 0];
    var renkler = preferences.getStringList("renkler") ?? <String>[];

    return UserInformation(
        isim: isim, cinsiyet: cinsiyet, renkler: renkler, ogrenciMi: ogrenci);

    //*burada ise kullanicibileri diye sinifimizi donduruyoruz
    //* kaydettigimiz verileri uygulama acildiginda tekrar gormek icin anasayfamizdaki tasarima gonderiyoruz
    //* boylelikle uygulama kapatalip acildiginda kaldigimiz yerden devam etmemizi sagliyor
  }
}
