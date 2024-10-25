import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MovieDetailSheet extends StatefulWidget {
  final String? filmName;
  final String? synopsisLong;
  final String imageLandscape;
  final String? filmTrailer;

  const MovieDetailSheet({
    super.key,
    required this.filmName,
    required this.synopsisLong,
    required this.imageLandscape,
    this.filmTrailer,
  });

  @override
  MovieDetailSheetState createState() => MovieDetailSheetState();
}

class MovieDetailSheetState extends State<MovieDetailSheet> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.filmTrailer != null) {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.filmTrailer!))
            ..initialize().then((_) {
              setState(() {});
            });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.imageLandscape,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.filmName ?? "No Title",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              widget.synopsisLong ?? "No description available.",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16),
            if (widget.filmTrailer != null &&
                _controller != null &&
                _controller!.value.isInitialized) ...[
              const Text(
                'Trailer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                  IconButton(
                    icon: Icon(
                      _controller!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          _controller!.value.isPlaying
                              ? _controller!.pause()
                              : _controller!.play();
                        },
                      );
                    },
                  ),
                ],
              ),
            ] else ...[
              const Text(
                "No Trailer available",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.left,
              )
            ]
          ],
        ),
      ),
    );
  }
}
