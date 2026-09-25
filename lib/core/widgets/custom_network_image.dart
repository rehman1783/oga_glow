import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A web-friendly image loader widget that uses [Image.network] on Web
/// (to prevent flutter_cache_manager CORS & WebGL issues) and [CachedNetworkImage] on Native platforms.
class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final String trimmedUrl = imageUrl.trim();

    if (trimmedUrl.isEmpty) {
      return errorWidget?.call(context, imageUrl, 'Empty URL') ?? _defaultError(context);
    }

    if (kIsWeb) {
      return Image.network(
        trimmedUrl,
        fit: fit,
        width: width,
        height: height,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          if (placeholder != null) {
            return placeholder!(context, trimmedUrl);
          }
          return _defaultPlaceholder(context);
        },
        errorBuilder: (context, error, stackTrace) {
          if (errorWidget != null) {
            return errorWidget!(context, trimmedUrl, error);
          }
          return _defaultError(context);
        },
      );
    }

    return CachedNetworkImage(
      imageUrl: trimmedUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: placeholder != null
          ? (ctx, url) => placeholder!(ctx, url)
          : null,
      errorWidget: errorWidget != null
          ? (ctx, url, err) => errorWidget!(ctx, url, err)
          : (ctx, url, err) => _defaultError(ctx),
    );
  }

  Widget _defaultPlaceholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.withValues(alpha: 0.1),
    );
  }

  Widget _defaultError(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.withValues(alpha: 0.1),
      child: const Icon(Icons.spa_rounded, color: Colors.grey),
    );
  }
}
