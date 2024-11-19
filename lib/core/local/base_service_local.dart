import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseServiceLocal {
  Future<String?> get(String key); //phuong thuc lấy dữ liệu
  Future<bool> saveKey(String key, String value);
}

class LocalServiceImpl implements BaseServiceLocal {
  @override
  Future<String?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<bool> saveKey(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
}



//tách ra local service để dùng chung cho các dữ liệu khác
//enum language tìm hiểu thêm
// copyWith để copy object
