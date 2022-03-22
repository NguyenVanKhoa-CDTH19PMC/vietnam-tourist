import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dart_ipify/dart_ipify.dart';

String serverUrl() {
  String serverUrl = "http://127.0.0.1:8000/"; //for run in web
  // String serverUrl = "http://10.0.2.2:8000/";
  // String serverUrl = "http://192.168.0.2/"; //for run in visual mobile
  return serverUrl;
}

Future<String> main() async {
  dotenv.load();
  var ipifyApiKeyName = 'IPIFY_API_KEY';
  var IPIFY_API_KEY = dotenv.env.containsKey(ipifyApiKeyName)
      ? dotenv.env[ipifyApiKeyName]
      : '';

  final ip = await Ipify.ipv64(format: Format.JSON);
  print(ip);

  final myGeo = await Ipify.geo(IPIFY_API_KEY.toString());
  print(myGeo.location);

  final someGeo = await Ipify.geo(IPIFY_API_KEY.toString(), ip: '8.8.8.8');
  print(someGeo);

  final balance = await Ipify.balance(IPIFY_API_KEY.toString());
  print(balance);
  return ip;
}
