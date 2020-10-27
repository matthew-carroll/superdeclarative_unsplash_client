import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../schema/_stats.dart';
import '../schema/unsplash_schema.dart';

const rootUrl = 'https://api.unsplash.com';

const Map<String, String> universalHeaders = {
  'Accept-Version': 'v1',
};

class UnsplashClient {
  UnsplashClient({
    http.Client httpClient,
    @required this.accessKey,
  }) : httpClient = httpClient ?? http.Client();

  final http.Client httpClient;
  final String accessKey;

  Map<String, String> _addAuthorizationToHeaders(Map<String, String> headers) {
    return <String, String>{}
      ..addAll(headers)
      ..['Authorization'] = 'Client-ID $accessKey';
  }

  Future<CollectionSearchPage> searchCollections({
    @required String query,
    int page = 1,
    int perPage = 10,
  }) async {
    final http.Response response = await httpClient.get(
      rootUrl + '/search/collections?query=$query&page=$page&per_page=$perPage',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final dynamic responseJson = json.decode(response.body);

    return CollectionSearchPage.fromJson(
      responseJson,
    );
  }

  Future<PhotoSearchPage> searchPhotos({
    @required String query,
    int page = 1,
    int perPage = 10,
    SearchOrder orderBy = SearchOrder.relevant,
    List<String> collections = const [],
    SearchContentFilter contentFilter = SearchContentFilter.low,
    SearchColorFilter color,
    SearchOrientation orientation,
  }) async {
    String orderByParam;
    switch (orderBy) {
      case SearchOrder.relevant:
        orderByParam = 'relevant';
        break;
      case SearchOrder.latest:
        orderByParam = 'latest';
        break;
    }

    String contentFilterParam;
    switch (contentFilter) {
      case SearchContentFilter.low:
        contentFilterParam = 'low';
        break;
      case SearchContentFilter.high:
        contentFilterParam = 'high';
        break;
    }

    String colorParam;
    switch (color) {
      case SearchColorFilter.blackAndWhite:
        colorParam = 'black_and_white';
        break;
      case SearchColorFilter.black:
        colorParam = 'black';
        break;
      case SearchColorFilter.white:
        colorParam = 'white';
        break;
      case SearchColorFilter.yellow:
        colorParam = 'yellow';
        break;
      case SearchColorFilter.orange:
        colorParam = 'orange';
        break;
      case SearchColorFilter.red:
        colorParam = 'red';
        break;
      case SearchColorFilter.purple:
        colorParam = 'purple';
        break;
      case SearchColorFilter.magenta:
        colorParam = 'magenta';
        break;
      case SearchColorFilter.green:
        colorParam = 'green';
        break;
      case SearchColorFilter.teal:
        colorParam = 'teal';
        break;
      case SearchColorFilter.blue:
        colorParam = 'blue';
        break;
    }

    String orientationParam;
    switch (orientation) {
      case SearchOrientation.landscape:
        orientationParam = 'landscape';
        break;
      case SearchOrientation.portrait:
        orientationParam = 'portrait';
        break;
      case SearchOrientation.squarish:
        orientationParam = 'squarish';
        break;
    }

    String params =
        'query=$query&page=$page&per_page=$perPage&order_by=$orderByParam&content_filter=$contentFilterParam';
    if (collections.isNotEmpty) {
      params += '&collections=$collections';
    }
    if (color != null) {
      params += '&color=$colorParam';
    }
    if (orientation != null) {
      params += '&orientation=$orientationParam';
    }

    final http.Response response = await httpClient.get(
      rootUrl + '/search/photos?$params',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final dynamic responseJson = json.decode(response.body);

    return PhotoSearchPage.fromJson(
      responseJson,
    );
  }

  Future<UserSearchPage> searchUsers({
    @required String query,
    int page = 1,
    int perPage = 10,
  }) async {
    final http.Response response = await httpClient.get(
      rootUrl + '/search/users?query=$query&page=$page&per_page=$perPage',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final dynamic responseJson = json.decode(response.body);

    return UserSearchPage.fromJson(
      responseJson,
    );
  }

  Future<List<Collection>> listCollections({
    int page = 1,
    int perPage = 10,
  }) async {
    final http.Response response = await httpClient.get(
      rootUrl + '/collections?page=$page&per_page=$perPage',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final dynamic responseJson = json.decode(response.body);

    assert(responseJson is List<dynamic>);
    final List<dynamic> jsonList = responseJson;

    return jsonList
        .map((dynamic collectionJson) => Collection.fromJson(collectionJson))
        .toList(growable: false);
  }

  Future<List<Collection>> listFeaturedCollections({
    int page = 1,
    int perPage = 10,
  }) async {
    final http.Response response = await httpClient.get(
      rootUrl + '/collections/featured?page=$page&per_page=$perPage',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final dynamic responseJson = json.decode(response.body);

    assert(responseJson is List<dynamic>);
    final List<dynamic> jsonList = responseJson;

    return jsonList
        .map((dynamic collectionJson) => Collection.fromJson(collectionJson))
        .toList(growable: false);
  }

  Future<Collection> getCollection({@required int id}) async {
    final http.Response response = await httpClient.get(
      rootUrl + '/collections/$id',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final Map<String, dynamic> responseJson = json.decode(response.body);

    return Collection.fromJson(responseJson);
  }

  Future<List<Collection>> listRelatedCollections(
      {@required String collectionId}) async {
    // TODO:
  }

  Future<Photo> getPhoto({@required String id}) async {
    final http.Response response = await httpClient.get(
      rootUrl + '/photos/$id',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final Map<String, dynamic> responseJson = json.decode(response.body);

    return Photo.fromJson(responseJson);
  }

  Future<PhotoStats> getPhotoStats({
    @required String photoId,
    StatResolution resolution = StatResolution.days,
    int quantity = 30,
  }) async {
    String resolutionParam;
    switch (resolution) {
      case StatResolution.days:
        resolutionParam = 'days';
        break;
    }

    final http.Response response = await httpClient.get(
      rootUrl +
          '/photos/$photoId/statistics?resolution=$resolutionParam&quantity=$quantity',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final Map<String, dynamic> responseJson = json.decode(response.body);

    return PhotoStats.fromJson(responseJson);
  }

  Future<Photo> getRandomPhoto() async {
    final http.Response response = await httpClient.get(
      rootUrl + '/photos/random',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final Map<String, dynamic> responseJson = json.decode(response.body);

    return Photo.fromJson(responseJson);
  }

  Future<List<Photo>> getMultipleRandomPhotos({count = 1}) async {
    final http.Response response = await httpClient.get(
      rootUrl + '/photos/random?count=$count',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final List<dynamic> responseJson = json.decode(response.body);

    return responseJson
        .map((dynamic photoJson) => Photo.fromJson(photoJson))
        .toList();
  }

  Future<PhotoListPage> listPhotos({
    int page = 1,
    int perPage = 10,
    PhotosPageOrder orderBy = PhotosPageOrder.latest,
  }) async {
    String orderByParam;
    switch (orderBy) {
      case PhotosPageOrder.latest:
        orderByParam = 'latest';
        break;
      case PhotosPageOrder.oldest:
        orderByParam = 'oldest';
        break;
      case PhotosPageOrder.popular:
        orderByParam = 'popular';
        break;
    }

    final http.Response response = await httpClient.get(
      rootUrl + '/photos?page=$page&per_page=$perPage&order_by=$orderByParam',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final dynamic responseJson = json.decode(response.body);

    return PhotoListPage.fromJson(
      pageIndex: page,
      perPage: perPage,
      orderBy: orderBy,
      json: responseJson,
    );
  }

  Future<TotalStats> getTotalStats() async {
    final http.Response response = await httpClient.get(
      rootUrl + '/stats/total',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final dynamic responseJson = json.decode(response.body);

    return TotalStats.fromJson(responseJson);
  }

  Future<MonthStats> getMonthStats() async {
    final http.Response response = await httpClient.get(
      rootUrl + '/stats/month',
      headers: _addAuthorizationToHeaders(universalHeaders),
    );

    final dynamic responseJson = json.decode(response.body);

    return MonthStats.fromJson(responseJson);
  }
}
