import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:superdeclarative_unsplash_client/unsplash.dart';
import 'package:test/test.dart';

void main() {
  final unsplashKey = Platform.environment['UNSPLASH_KEY'];
  assert(unsplashKey != null,
      'No Unsplash API key found. Place your key in an environment variable called "UNSPLASH_KEY"');

  final http.Client httpClient = http.Client();
  final UnsplashClient unsplashClient = UnsplashClient(
    httpClient: httpClient,
    accessKey: unsplashKey,
  );

  group('Smoke Tests', () {
    test('Get specific photo', () async {
      final Photo specificPhoto =
          await unsplashClient.getPhoto(id: 'DkkVU4N1zZw');
      expect(specificPhoto, isNotNull);
      expect(specificPhoto.id, isNotNull);
      expect(specificPhoto.width, isPositive);
      expect(specificPhoto.height, isPositive);
      expect(specificPhoto.urls, isNotNull);
      expect(specificPhoto.urls.raw, isNotNull);
    });

    test('Get random photo', () async {
      final Photo randomPhoto = await unsplashClient.getRandomPhoto();
      expect(randomPhoto, isNotNull);
      expect(randomPhoto.id, isNotNull);
      expect(randomPhoto.width, isPositive);
      expect(randomPhoto.height, isPositive);
      expect(randomPhoto.urls, isNotNull);
      expect(randomPhoto.urls.raw, isNotNull);
    });
  });
}
