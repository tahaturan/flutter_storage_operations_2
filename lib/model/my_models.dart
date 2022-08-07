// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

enum Cinsiyet { KADIN, ERKEK, DIGER }

enum Renkler { SARI, KIRMIZI, MAVI, PEMBE, YESIL }

class UserInformation {
  final String isim;
  final Cinsiyet cinsiyet;
  final List<String> renkler;
  final bool ogrenciMi;
  UserInformation({
    required this.isim,
    required this.cinsiyet,
    required this.renkler,
    required this.ogrenciMi,
  });
  //*burada kolaylik olsun diye bir kullanicibilgi sinifi olusturulduk ve constructor dan gerekli verileri istedik anasayfamizda kullanidigmiz kayitedecegimiz verileri
}
