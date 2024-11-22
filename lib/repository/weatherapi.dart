import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

String apikey = 'f175b16513bb43ffc27c9d19ce485441';

Future<Map<String, dynamic>?> fetchtherealtime(String? query) async {
  try {
    final url =
        'http://api.weatherstack.com/current?access_key=$apikey&query=$query';
    final uri = Uri.parse(url);
    final Response = await http.get(uri);

    if (Response.statusCode == 200) {
      final body = Response.body;
      final items = jsonDecode(body);
      log(items.toString());
      return items;
    }

  } catch (e) {
    log(e.toString());
  }
  return null;
}
