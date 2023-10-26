import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class ApiRequest {
  static const String googleApiKey = 'AIzaSyDlYLALZZw0yXpleOSxpGzGxLw-K86F9SY';
  Client client = Client();
  String dbUrl = "https://cbnform.firebaseio.com/";
  String dbUrl2 =
      "https://cbn-survey-default-rtdb.asia-southeast1.firebasedatabase.app/";
  String dbUrlBranding =
      "https://branding-posters.asia-southeast1.firebasedatabase.app/";

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


Future<Map<String, dynamic>> getLatLong(String placeName) async {
 
  final endpoint =
      'https://maps.googleapis.com/maps/api/geocode/json?address=$placeName&key=$googleApiKey';

  final response = await client.get(Uri.parse(endpoint));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data['status'] == 'OK') {
      final location = data['results'][0]['geometry']['location'];
      double lat = location['lat'];
      double lng = location['lng'];
      return {'latitude': lat, 'longitude': lng};
    } else {
      throw Exception('Failed to load location data');
    }
  } else {
    throw Exception('Failed to load location data');
  }
}

}
