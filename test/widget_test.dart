import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
  String api_key = "0ef7a3102a289380a00c9da42cf0a952";
  final response = await http.post(
    url,
    body: {
      "origin": "78",
      "destination": "101",
      "weight": "1700",
      "courier": "jne"
    },
    headers: {
      "key": api_key,
      'content-type': 'application/x-www-form-urlencoded',
    },
  );

  print(response.body);
}
