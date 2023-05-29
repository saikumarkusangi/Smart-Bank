import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/asymmetric/api.dart';


String publicKeyString = '''
-----BEGIN PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAvVWcF72SARmle0b5cKFy
L5HdY7uhj6Txq9hQPprYmh+edUC7BU+0UMyIn0qyU+QglYlNbtIh44Cthwgh7HEi
NckBiHY9jGOBGoC47o09j5W3NSZG6QbhCofKI5tFF6CI15j+/KSf4gfPeHC92nAx
LheaPdCO67BhYoegGSA3XfMCSg8iGtwiLEEo420VOdkccM/mMq8ZentfPSq+8bvq
ixxjwGArbebQbZVhZzY/zLCL9i6eaVB+yVSHa+QCXxhXKRAHGs3w/M8Yb0vDvuFG
/6a+81sxUAfOKMd2/tI/R1jxyXO7j4GBSjXrfWdA3SeYsdK58ieA4pj+bdBcIYrM
XknxbidHEWQbNCTrnVdnauXL5f3qrD0KCyt3Bn4cYrq/tQfjK7SseGxHbrvTAssE
kdeBmKOHe4aTCIUDAqDmADx4yEywfBR3rV1CGsu5+kkutswb+hOh2AajdNHkOz6s
g7+jo/kkBNgkJ+oTRWPwPri5PqeCgHJg+mdaHQK4aiuNGTt1cWgkfcb4p8Ye5+0y
QPJkYQQvkEwAwnMjA0PGQAd7foUuOkro+oui1IYgR97T+nO2F2i5JIgDsmfURQj2
BjMB2fW3z6/VVXp8PyWIna4dZEdRI5qWKcyZzLmJZxBAAtG4R0C+V8kUGxAXmtLz
IzGz76FZlsSOFEDPUB4z9YUCAwEAAQ==
-----END PUBLIC KEY-----
''';

RSAPublicKey parsePublicKeyFromPem(String pemString) {
  final publicKey = RSAKeyParser().parse(publicKeyString);
  return publicKey as RSAPublicKey;
}

String rsaEncrypt(String data) {
  final publicKey = parsePublicKeyFromPem(publicKeyString);
  final encrypter = Encrypter(RSA(publicKey: publicKey));

  final encrypted = encrypter.encrypt(data);
  final encryptedBase64 = base64.encode(encrypted.bytes);

  return encryptedBase64;
}

Future<void> sendDataToServer(String encryptedData) async {
  final url = 'https://events.respark.iitm.ac.in:3000/rp_bank_api';
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({'encryptedData': encryptedData});

  final response = await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    // Process the response
    print(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}
demo() {
  // Example payload
  final payload = json.encode({
    'action': 'balance',
    'token': 'oeo9cjc5n9lknivgu0au',
    'nick_name': 'cindy',
  });

  final encryptedData = rsaEncrypt(payload);
  sendDataToServer(encryptedData);
}
