import 'package:flutter_storage_operations_2/model/my_models.dart';

abstract class LocalStorageService {
  Future<void> verileriKaydet(UserInformation userInformation);

  Future<UserInformation> verileriOku();
}
