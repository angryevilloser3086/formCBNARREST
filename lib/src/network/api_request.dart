import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class ApiRequest {
  Client client = Client();
  String dbUrl = "https://cbnform.firebaseio.com/";

  Future<bool> uploadRTDB(Map<String, dynamic> json) async {
    try {
      var res = await client.post(
        Uri.parse(dbUrl),
        body: jsonEncode(json),
      );
      var body = jsonDecode(utf8.decode(res.bodyBytes));
      if (res.statusCode == 200) {
        return true;
      } else {
        throw Exception(body);
      }
    } on SocketException catch (_) {
      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e);
    }
  }
}
