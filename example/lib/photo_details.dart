import 'dart:math';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:superdeclarative_unsplash_client/superdeclarative_unsplash_client.dart';

/// Displays a single, specified Unsplash photo at the center of the screen
/// atop a darker copy of that photo stretched across the background.
///
/// Expects a `Photo` to be passed as the incoming route `arguments`.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      body: _PhotoPage(photo: _photo),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

/// Displays the given photo at the center of the widget, with width and height
/// dimension measurements, and a darker version of the photo stretched across
/// the background.
class _PhotoPage extends StatelessWidget {
  const _PhotoPage({
    Key key,
    this.photo,
  }) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Background image.
        CachedNetworkImage(
          imageUrl: photo.urls.regular,
          fit: BoxFit.cover,
          alignment: Alignment.topLeft,
          color: Colors.black.withOpacity(0.8),
          colorBlendMode: BlendMode.dstOut,
          fadeInDuration: Duration.zero,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 2),
            // Primary photo
            _MeasuredPhoto(photo: photo),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Stats at bottom of screen.
              children: _buildStats(),
            ),
            Spacer(flex: 1),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildStats() {
    final List<Widget> stats = [];
    if (photo.views != null) {
      stats
        ..add(
          _buildStat(
            icon: Icons.remove_red_eye,
            value: '${photo.views}',
          ),
        )
        ..add(
          SizedBox(height: 32),
        );
    }
    if (photo.likes != null) {
      stats
        ..add(
          _buildStat(
            icon: Icons.thumb_up,
            value: '${photo.likes}',
          ),
        )
        ..add(
          SizedBox(height: 32),
        );
    }
    if (photo.downloads != null) {
      stats
        ..add(
          _buildStat(
            icon: Icons.cloud_download,
            value: '${photo.downloads}',
          ),
        )
        ..add(
          SizedBox(height: 32),
        );
    }
    return stats;
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
}

/// Displays the given `photo` with its width and height dimensions displayed
/// beside it.
class _MeasuredPhoto extends StatelessWidget {
  const _MeasuredPhoto({
    Key key,
    @required this.photo,
  }) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    final double measureTapeThickness = 30;
    final double measureTapeMargin = 8;

    final int maxWidth = 200;
    final int maxHeight = 400;
    final double maxAspectRatio = maxWidth.toDouble() / maxHeight;
    final double photoAspectRatio = photo.width.toDouble() / photo.height;

    double displayWidth;
    double displayHeight;
    if (photoAspectRatio >= maxAspectRatio) {
      displayWidth = maxWidth.toDouble();
      displayHeight = (maxWidth / photo.width) * photo.height;
    } else {
      displayHeight = maxHeight.toDouble();
      displayWidth = (maxHeight / photo.height) * photo.width;
    }

    return SizedBox(
      width:
          displayWidth + (2 * measureTapeThickness) + (2 * measureTapeMargin),
      height: displayHeight + measureTapeThickness + measureTapeMargin,
      child: Stack(
        children: [
          // Photo
          Positioned(
            left: measureTapeThickness + measureTapeMargin,
            right: measureTapeThickness + measureTapeMargin,
            top: 0,
            bottom: measureTapeThickness + measureTapeMargin,
            child: _buildPhoto(),
          ),
          // Vertical image dimensions
          Positioned(
            left: 0,
            top: 0,
            bottom: measureTapeThickness + measureTapeMargin,
            child: SizedBox(
              width: measureTapeThickness,
              child: CustomPaint(
                painter: _DimensionRulerPainter(
                  direction: _RulerDirection.vertical,
                  label: '${photo.height} px',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  rulerColor: Colors.white,
                  rulerLineWidth: 2,
                ),
              ),
            ),
          ),
          // Horizontal image dimensions
          Positioned(
            left: measureTapeThickness + measureTapeMargin,
            right: measureTapeThickness + measureTapeMargin,
            bottom: 0,
            child: SizedBox(
              height: measureTapeThickness,
              child: CustomPaint(
                painter: _DimensionRulerPainter(
                  direction: _RulerDirection.horizontal,
                  label: '${photo.width} px',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  rulerColor: Colors.white,
                  rulerLineWidth: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoto() {
    return photo != null
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
              tag: photo.id,
              transitionOnUserGestures: true,
              child: CachedNetworkImage(
                imageUrl: photo.urls.regular,
                fit: BoxFit.contain,
                fadeInDuration: Duration.zero,
              ),
            ),
          )
        : SizedBox();
  }
}

/// Paints a given `label` between 2 end-cap lines.
class _DimensionRulerPainter extends CustomPainter {
  _DimensionRulerPainter({
    @required this.direction,
    this.label = '',
    @required this.labelStyle,
    @required this.rulerColor,
    @required this.rulerLineWidth,
  }) : rulerPaint = Paint()..color = rulerColor;

  final _RulerDirection direction;
  final String label;
  final TextStyle labelStyle;
  final Color rulerColor;
  final double rulerLineWidth;
  final Paint rulerPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (direction == _RulerDirection.horizontal) {
      _drawHorizontal(canvas, size);
    } else {
      _drawVertical(canvas, size);
    }
  }

  void _drawHorizontal(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        0,
        rulerLineWidth,
        size.height,
      ),
      rulerPaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(
        size.width - rulerLineWidth,
        0,
        rulerLineWidth,
        size.height,
      ),
      rulerPaint,
    );

    final labelParagraph = _createParagraph(label)
      ..layout(ui.ParagraphConstraints(width: size.width));

    canvas.drawParagraph(
      labelParagraph,
      Offset(
        (size.width - labelParagraph.width) / 2,
        (size.height - labelParagraph.height) / 2,
      ),
    );
  }

  void _drawVertical(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        0,
        size.width,
        rulerLineWidth,
      ),
      rulerPaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(
        0,
        size.height - rulerLineWidth,
        size.width,
        rulerLineWidth,
      ),
      rulerPaint,
    );

    final labelParagraph = _createParagraph(label)
      ..layout(ui.ParagraphConstraints(width: size.height));

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-pi / 2);
    canvas.drawParagraph(
      labelParagraph,
      Offset(
        (-labelParagraph.width) / 2,
        (-labelParagraph.height) / 2,
      ),
    );
    canvas.restore();
  }

  ui.Paragraph _createParagraph(String label) {
    final paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: labelStyle.fontSize,
        fontWeight: labelStyle.fontWeight,
      ),
    )
      ..pushStyle(
        ui.TextStyle(
          color: labelStyle.color,
        ),
      )
      ..addText(label);
    return paragraphBuilder.build();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO:
    return true;
  }
}

enum _RulerDirection {
  horizontal,
  vertical,
}
