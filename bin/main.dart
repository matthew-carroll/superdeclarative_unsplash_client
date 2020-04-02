import 'package:http/http.dart';

import 'api_keys.dart';
import 'src/client/unsplash_client.dart';
import 'src/schema/unsplash_schema.dart';

Future<void> main(List<String> arguments) async {
  final Client httpClient = Client();
  final UnsplashClient unsplashClient = UnsplashClient(
    httpClient: httpClient,
    accessKey: accessKey,
  );

  final Photo randomPhoto = await unsplashClient.getRandomPhoto();
  print('Random Photo:\n$randomPhoto');
}
