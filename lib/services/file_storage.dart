import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_storage_operations_2/model/my_models.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  _getFilePath() async {
    var filePath = await getApplicationDocumentsDirectory();
    return filePath.path;
  }

  FileStorageService() {
    _createFile();
  }

  Future<File> _createFile() async {
    var file = File(await _getFilePath() + "/info.json");
    return file;
  }

  void verileriKaydet(UserInformation userInformation) async {
    var file = await _createFile();
    await file.writeAsString(jsonEncode(userInformation));
  }

  Future<UserInformation> verileriOku() async {
    try {
      var file = await _createFile();
      var dosyaStringIcerik = await file.readAsString();
      var json = jsonDecode(dosyaStringIcerik);
      return UserInformation.fromJson(json);
    } catch (e) {
      debugPrint(e.toString());
    }
    return UserInformation(
        isim: "Taha", cinsiyet: Cinsiyet.ERKEK, renkler: [], ogrenciMi: false);
  }
}
