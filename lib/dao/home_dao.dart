import 'package:flutter_app/model/home_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeDao {
  static const String HOME_URL =
      "http://www.devio.org/io/flutter_app/json/home_page.json";

  static Future<HomeModel> fetchHomeData() async {
    var response = await http.get(HOME_URL);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //防止中文乱码
      return HomeModel.fromJson(
          json.decode(utf8decoder.convert(response.bodyBytes)));
    } else {
      return null;
    }
  }
}
