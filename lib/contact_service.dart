import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ContactService {
  Future<List<Map<String, dynamic>>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> itemStrings = prefs.getStringList('contacts') ?? [];

    return itemStrings
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
  }

  saveData(
    String name,
    String gender,
    String email,
    String phone,
    String facebook,
    String instagram,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> dataList = prefs.getStringList('contacts') ?? [];

    Map<String, String> newData = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': name,
      'gender': gender,
      'email': email,
      'phone': phone,
      'facebook': facebook,
      'instagram': instagram,
    };

    dataList.add(jsonEncode(newData));
    prefs.setStringList(
      'contacts',
      dataList,
    );
  }
}
