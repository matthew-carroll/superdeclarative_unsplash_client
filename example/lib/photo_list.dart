import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:superdeclarative_unsplash_client/api_keys.dart';
import 'package:superdeclarative_unsplash_client/unsplash.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({
    Key key,
    this.accessKey,
  }) : super(key: key);

  final String accessKey;

  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  UnsplashClient _unsplashClient;
  Paginator _paginator;

  TextEditingController _searchController;
  FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _unsplashClient = UnsplashClient(
      httpClient: http.Client(),
      accessKey: widget.accessKey,
    );

    _searchController = TextEditingController();

    // Immediately run a search to fill list with initial photos.
    _searchPhotos();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _paginator.dispose();
    super.dispose();
  }

  void _searchPhotos() {
    final String searchQuery = _searchController.text;

    if (_searchFocusNode.hasFocus) {
      _searchFocusNode.unfocus();
    }

    setState(() {
      _paginator?.dispose();

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
            bottom: 16,
            left: 16,
            right: 16,
            child: _buildBottomSearch(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSearch() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
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
            child: Center(
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration.collapsed(
                  hintText: 'Search photos...',
                ),
                onSubmitted: (value) {
                  _searchPhotos();
                },
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        FloatingActionButton(
          tooltip: 'Search Photos',
          onPressed: _searchPhotos,
          child: Icon(Icons.search),
        ),
      ],
    );
  }
}

class PhotoList extends StatefulWidget {
  const PhotoList({
    Key key,
    this.paginator,
  }) : super(key: key);

  final Paginator paginator;

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  PagingListener _pagingListener;

  @override
  void initState() {
    super.initState();

    _pagingListener = FunctionalPagingListener(
      onPageLoaded: (List<Photo> page, int pageIndex) {
        setState(() {});
      },
    );

    widget.paginator.addListener(_pagingListener);
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
    widget.paginator.removeListener(_pagingListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Unsplash Client'),
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
    );
  }

  Widget _buildListItem(BuildContext context, Photo photo) {
    return AspectRatio(
      aspectRatio: photo.width / photo.height,
      child: GestureDetector(
        child: Hero(
          tag: photo.id,
          transitionOnUserGestures: true,
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
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key key,
    @required this.photo,
  }) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: photo.width / photo.height,
      child: GestureDetector(
        child: Hero(
          tag: photo.id,
          transitionOnUserGestures: true,
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
}
