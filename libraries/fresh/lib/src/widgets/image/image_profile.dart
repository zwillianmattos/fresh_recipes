import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageProfile extends StatefulWidget {
  final String photoUrl;
  final double height;
  final double width;
  final double borderRadius;
  const ImageProfile({
    super.key,
    required this.photoUrl,
    this.height = 24,
    this.width = 24,
    this.borderRadius = 15,
  });

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: CachedNetworkImage(
        imageUrl: widget.photoUrl,
        fit: BoxFit.cover,
        width: widget.width,
        height: widget.height,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
