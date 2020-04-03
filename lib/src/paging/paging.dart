import 'package:meta/meta.dart';
import 'package:superdeclarative_unsplash_client/src/client/unsplash_client.dart';

import '../schema/unsplash_schema.dart';

typedef PageLoader = Future<List<Photo>> Function(int pageIndex, int perPage);

class Paginator {
  factory Paginator.searchPhotos({
    @required UnsplashClient client,
    @required String query,
    int initialPageIndex = 1,
    int perPage = 10,
  }) {
    return Paginator._(
        initialPageIndex: initialPageIndex,
        perPage: perPage,
        pageLoader: (int pageIndex, int perPage) async {
          PhotoSearchPage page = await client.searchPhotos(
            query: query,
            page: pageIndex,
            perPage: perPage,
          );
          return page.results;
        });
  }

  factory Paginator.listPhotos({
    @required UnsplashClient client,
    int initialPageIndex = 1,
    int perPage = 10,
    PhotosPageOrder orderBy = PhotosPageOrder.latest,
  }) {
    return Paginator._(
        initialPageIndex: initialPageIndex,
        perPage: perPage,
        pageLoader: (int pageIndex, int perPage) async {
          PhotoListPage page = await client.listPhotos(
            page: pageIndex,
            perPage: perPage,
          );
          return page.photos;
        });
  }

  Paginator._({
    this.perPage,
    int initialPageIndex = 1,
    PageLoader pageLoader,
  })  : assert(initialPageIndex >= 1, 'Page indices begin at 1'),
        _nextPageIndex = initialPageIndex,
        _pageLoader = pageLoader;

  final int perPage;
  final PageLoader _pageLoader;
  final Map<int, List<Photo>> _pages = <int, List<Photo>>{};
  final Set<PagingListener> _listeners = <PagingListener>{};
  int _nextPageIndex; // starts at 1
  Future<List<Photo>> _nextPageResult;

  int get loadedPageCount => _pages.length;

  void dispose() {
    _listeners.clear();
    _pages.clear();
    _nextPageIndex = 1;
  }

  void addListener(PagingListener listener) {
    _listeners.add(listener);
  }

  void removeListener(PagingListener listener) {
    _listeners.remove(listener);
  }

  bool isPageLoaded(int index) {
    return index < _nextPageIndex;
  }

  bool isPhotoLoaded(int photoIndex) {
    return isPageLoaded((photoIndex / perPage).floor() + 1);
  }

  Photo getPhoto(int photoIndex) {
    assert(isPhotoLoaded(photoIndex), 'Photo $photoIndex is not loaded yet.');
    final int pageIndex = (photoIndex / perPage).floor() + 1;
    final List<Photo> page = getPage(pageIndex);
    return page[photoIndex % perPage];
  }

  List<Photo> getPage(int index) {
    assert(isPageLoaded(index), 'Page $index has not been loaded yet.');
    return _pages[index - 1];
  }

  Future<List<Photo>> loadNextPage() {
    if (_nextPageResult != null) {
      return _nextPageResult;
    }

    _nextPageResult = _loadPage(_nextPageIndex);

    _nextPageResult.then((List<Photo> page) {
      if (page != null && page.isNotEmpty) {
        ++_nextPageIndex;

        _nextPageResult = null;

        for (PagingListener listener in _listeners) {
          listener.onPageLoaded(page, _nextPageIndex - 1);
        }
      }
    });

    return _nextPageResult;
  }

  Future<List<Photo>> _loadPage(int index) async {
    List<Photo> page = await _pageLoader(index, perPage);
    _pages[index - 1] = page;
    return page;
  }
}

abstract class PagingListener {
  void onPageLoaded(List<Photo> page, int pageIndex);
}

class FunctionalPagingListener implements PagingListener {
  FunctionalPagingListener({
    @required Function(List<Photo> page, int pageIndex) onPageLoaded,
  }) : _onPageLoaded = onPageLoaded;

  final Function(List<Photo> page, int pageIndex) _onPageLoaded;

  @override
  void onPageLoaded(List<Photo> page, int pageIndex) {
    _onPageLoaded(page, pageIndex);
  }
}
