import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:superdeclarative_unsplash_client/api_keys.dart';
import 'package:superdeclarative_unsplash_client/unsplash.dart';

class PhotoListScreen extends StatefulWidget {
  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  UnsplashClient _unsplashClient;
  Paginator _paginator;

  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _unsplashClient = UnsplashClient(
      httpClient: http.Client(),
      accessKey: accessKey,
    );

    _paginator = Paginator.listPhotos(
      client: _unsplashClient,
    )..loadNextPage();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchPhotos() {
    final String searchQuery = _searchController.text;

    setState(() {
      if (searchQuery.isNotEmpty) {
        _paginator = Paginator.searchPhotos(
          client: _unsplashClient,
          query: searchQuery,
        )..loadNextPage();
      } else {
        _paginator = Paginator.listPhotos(
          client: _unsplashClient,
        )..loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PhotoList(
            paginator: _paginator,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 54,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).accentColor,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 5),
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Search photos...',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  FloatingActionButton(
                    onPressed: _searchPhotos,
                    tooltip: 'Search Photos',
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoList extends StatefulWidget {
  const PhotoList({Key key, this.paginator}) : super(key: key);

  final Paginator paginator;

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  PagingListener _pagingListener;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _pagingListener = FunctionalPagingListener(
        onPageLoaded: (List<Photo> page, int pageIndex) {
      setState(() {});
    });

    widget.paginator.addListener(_pagingListener);

    _scrollController = ScrollController();
  }

  @override
  void didUpdateWidget(PhotoList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.paginator != oldWidget.paginator) {
      oldWidget.paginator.removeListener(_pagingListener);
      widget.paginator.addListener(_pagingListener);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    widget.paginator.removeListener(_pagingListener);
    super.dispose();
  }

  Widget _buildListItem(BuildContext context, Photo photo) {
    return AspectRatio(
      aspectRatio: photo.width / photo.height,
      child: GestureDetector(
        child: Hero(
          tag: photo.id,
          child: CachedNetworkImage(
            imageUrl: photo.urls.regular,
            fit: BoxFit.cover,
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed('photo', arguments: photo);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scrollbar(
        controller: _scrollController,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                title: Text('The Grand Finale'),
              ),
              expandedHeight: 150,
              stretch: true,
              pinned: true,
              elevation: 10,
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (widget.paginator.isPhotoLoaded(index)) {
                    return _buildListItem(
                        context, widget.paginator.getPhoto(index));
                  } else {
                    widget.paginator.loadNextPage();
                    return null;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
