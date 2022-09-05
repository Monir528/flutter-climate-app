import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NetworkHelper {
  NetworkHelper({required this.url});
  String url;
  Future getData() async {
    var uri = Uri.parse(url);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }
}
