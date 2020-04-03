import 'package:flutter/material.dart';
import 'package:superdeclarative_unsplash_client/unsplash.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  Photo _photo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _photo = ModalRoute.of(context).settings.arguments;
  }

  Widget _buildMeasuredPhoto() {
    final double measureTapeThickness = 30;
    final double measureTapeMargin = 8;

    final int maxWidth = 200;
    final int maxHeight = 400;
    final double maxAspectRatio = maxWidth.toDouble() / maxHeight;
    final double photoAspectRatio = _photo.width.toDouble() / _photo.height;

    double displayWidth;
    double displayHeight;
    if (photoAspectRatio >= maxAspectRatio) {
      displayWidth = maxWidth.toDouble();
      displayHeight = (maxWidth / _photo.width) * _photo.height;
    } else {
      displayHeight = maxHeight.toDouble();
      displayWidth = (maxHeight / _photo.height) * _photo.width;
    }

    return SizedBox(
      width:
          displayWidth + (2 * measureTapeThickness) + (2 * measureTapeMargin),
      height: displayHeight + measureTapeThickness + measureTapeMargin,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: measureTapeThickness,
                height: displayHeight,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 3,
                      color: Colors.white,
                    ),
                    Spacer(),
                    RotatedBox(
                      quarterTurns: -1,
                      child: Text('${_photo.height} px'),
                    ),
                    Spacer(),
                    Container(
                      height: 3,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(width: measureTapeMargin),
              SizedBox(
                width: displayWidth,
                height: displayHeight,
                child: _buildPhoto(),
              ),
              SizedBox(width: measureTapeMargin),
              SizedBox(width: measureTapeThickness),
            ],
          ),
          SizedBox(height: measureTapeMargin),
          SizedBox(
            height: measureTapeThickness,
            child: Row(
              children: <Widget>[
                Spacer(),
                SizedBox(
                  width: displayWidth,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 3,
                        color: Colors.white,
                      ),
                      Spacer(),
                      Text('${_photo.width} px'),
                      Spacer(),
                      Container(
                        width: 3,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoto() {
    return _photo != null
        ? Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Hero(
              tag: _photo.id,
              child: Image.network(
                _photo.urls.small,
                fit: BoxFit.contain,
              ),
            ),
          )
        : SizedBox();
  }

  Widget _buildStat({
    @required IconData icon,
    @required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          icon,
          size: 30,
        ),
        SizedBox(width: 16),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stats = [];
    if (_photo.views != null) {
      stats
        ..add(
          _buildStat(
            icon: Icons.remove_red_eye,
            value: '${_photo.views}',
          ),
        )
        ..add(
          SizedBox(height: 32),
        );
    }
    if (_photo.likes != null) {
      stats
        ..add(
          _buildStat(
            icon: Icons.thumb_up,
            value: '${_photo.likes}',
          ),
        )
        ..add(
          SizedBox(height: 32),
        );
    }
    if (_photo.downloads != null) {
      stats
        ..add(
          _buildStat(
            icon: Icons.cloud_download,
            value: '${_photo.downloads}',
          ),
        )
        ..add(
          SizedBox(height: 32),
        );
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              _photo.urls.regular,
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
              color: Colors.black.withOpacity(0.8),
              colorBlendMode: BlendMode.dstOut,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 2),
                _buildMeasuredPhoto(),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: stats,
                ),
                Spacer(flex: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
