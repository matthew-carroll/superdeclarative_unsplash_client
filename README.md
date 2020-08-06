# Unsplash Client

A Dart Client for the Unsplash API.

**This is a [SuperDeclarative!](https://superdeclarative.com) product, not an official Unsplash library**

Unsplash is a service that provides access to royalty free stock photographs. In addition to direct browsing of photographs, Unsplash offers a developer API for accessing photos, collections of photos, users of the platform, and more.

This package is a client for the Unsplash API, built in the Dart language.

Unsplash API documentation: https://unsplash.com/documentation

## Quickstart

Create a client:

```dart
import 'package:http/http.dart' as http;

final unsplashClient = UnsplashClient(
  httpClient: http.Client(),
  accessKey: YOUR_API_KEY,
);
```

Get a single photo:

```dart
final Photo photo = await unsplashClient.getPhoto(id: 'some_photo_id');
```

Search photos:

```dart
final PhotoSearchPage page = await unsplashClient.searchPhotos(
  query: 'some query or blank for featured photos',
);
```

Load pages of photos:

```dart
final paginator = Paginator.listPhotos(
  client: unsplashClient,
)..loadNextPage();
```

## Example Project

An example project, built with Flutter, is available in the `/example` directory.

## Supported Calls

### API Version 1

#### Authentication

- [x] HTTP Basic Authentication
- [ ] User Authentication Flow
- [ ] Dynamic Client Registration

#### Current User

- [ ] GET /me
- [ ] PUT /me

#### Users

- [ ] GET /users/:username
- [ ] GET /users/:username/portfolio
- [ ] GET /users/:username/photos
- [ ] GET /users/:username/likes
- [ ] GET /users/:username/collections
- [ ] GET /users/:username/statistics

#### Photos

- [x] GET /photos
- [x] GET /photos/:id
- [x] GET /photos/random
- [x] GET /photos/:id/statistics
- [ ] GET /photos/:id/download
- [ ] PUT /photos/:id
- [ ] POST /photos/:id/like
- [ ] DELETE /photos/:id/like

#### Search

- [x] GET /search/photos
- [x] GET /search/collections
- [x] GET /search/users

#### Collections

- [x] GET /collections
- [x] GET /collections/featured
- [x] GET /collections/:id
- [ ] GET /collections/:id/photos
- [ ] GET /collections/:id/related
- [ ] POST /collections
- [ ] PUT /collections/:id
- [ ] DELETE /collections/:id
- [ ] POST /collections/:collection_id/add
- [ ] DELETE /collections/:collection_id/remove

#### Stats

- [x] GET /stats/total
- [x] GET /stats/month

