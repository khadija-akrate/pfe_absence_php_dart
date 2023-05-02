import 'package:app2/model/userDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class userservice {
  Future<List<userDetails>> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2/api_data/api/studentdata.php'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => userDetails.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
