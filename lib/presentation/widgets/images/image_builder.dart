import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/assets/app_assets.dart';

enum ImageType { networkImage, localSvg, localImage, networkSvg }

const double _defaultIconSize = 24.0;

class ImageBuilder extends StatelessWidget {
  final String? url;

  final BoxFit? fit;
  final double? width;
  final double? height;

  final String? placeholder;
  final Size? sizeServer;
  final bool isScale;
  final bool isZoom;

  final ImageWidgetBuilder? imageBuilder;

  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final LoadingErrorWidgetBuilder? errorWidget;
  final Duration? placeholderFadeInDuration;
  final Duration? fadeOutDuration;
  final Curve fadeOutCurve;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final Alignment alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final bool? isShowAppBar;
  final Map<String, String>? httpHeaders;
  final bool useOldImageOnUrlChange;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final String? cacheKey;
  final String? hero;

  final ImageType type;
  final bool shrinkOnError;

  final BorderRadiusGeometry borderRadius;

  const ImageBuilder(
    this.url, {
    super.key,
    this.hero,
    this.sizeServer,
    this.isScale = false,
    this.isZoom = false,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.httpHeaders,
    this.imageBuilder,
    this.progressIndicatorBuilder,
    this.errorWidget,
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.useOldImageOnUrlChange = false,
    this.color,
    this.filterQuality = FilterQuality.low,
    this.colorBlendMode,
    this.placeholderFadeInDuration,
    this.memCacheWidth,
    this.memCacheHeight,
    this.cacheKey,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.isShowAppBar = true,
    this.type = ImageType.networkImage,
    this.shrinkOnError = false,
    this.borderRadius = BorderRadius.zero,
  });

  factory ImageBuilder.localSvg(
    String? url, {
    double? size,
    double width = _defaultIconSize,
    double height = _defaultIconSize,
    BoxFit fit = BoxFit.cover,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    Color? color,
  }) {
    return ImageBuilder(
      (url != null) ? (url.startsWith('assets') ? url : 'assets/icons/svg/$url.svg') : null,
      width: size ?? width,
      height: size ?? height,
      fit: fit,
      type: ImageType.localSvg,
      borderRadius: borderRadius,
      color: color,
    );
  }

  factory ImageBuilder.localPNG(
    String? url, {
    double? size,
    double width = _defaultIconSize,
    double height = _defaultIconSize,
    BoxFit fit = BoxFit.cover,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    Color? color,
  }) {
    return ImageBuilder(
      (url != null) ? (url.startsWith('assets') ? url : 'assets/images/png/$url.png') : null,
      width: size ?? width,
      height: size ?? height,
      fit: fit,
      type: ImageType.localImage,
      borderRadius: borderRadius,
      color: color,
    );
  }

  Widget get _placeholderWidget => ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          placeholder ?? ImageAssets.placeholder,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(16.0),
              child: const Icon(Icons.image),
            );
          },
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          repeat: repeat,
          matchTextDirection: matchTextDirection,
          color: color,
          filterQuality: filterQuality,
          colorBlendMode: colorBlendMode,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final String imageUrl = url ?? '';

    if (imageUrl.isEmpty) {
      return _placeholderWidget;
    }

    Widget buildImage() {
      switch (type) {
        case ImageType.localSvg:
          return SvgPicture.asset(
            imageUrl,
            fit: fit ?? BoxFit.contain,
            colorFilter: color != null ? ColorFilter.mode(color!, colorBlendMode ?? BlendMode.srcIn) : null,
            width: width,
            height: height,
            placeholderBuilder: (context) {
              if (shrinkOnError) return const SizedBox.shrink();
              return _placeholderWidget;
            },
            alignment: alignment,
          );
        case ImageType.localImage:
          return Image.asset(
            imageUrl,
            fit: fit ?? BoxFit.contain,
            width: width,
            filterQuality: filterQuality,
            colorBlendMode: colorBlendMode,
            height: height,
            color: color,
            errorBuilder: (context, error, stackTrace) {
              if (shrinkOnError) return const SizedBox.shrink();
              return _placeholderWidget;
            },
            alignment: alignment,
            repeat: repeat,
            matchTextDirection: matchTextDirection,
            cacheHeight: memCacheHeight,
            cacheWidth: memCacheWidth,
          );
        case ImageType.networkImage:
          return CachedNetworkImage(
            imageUrl: imageUrl,
            height: height,
            width: width,
            fit: fit,
            placeholder: (context, url) {
              return _placeholderWidget;
            },
            errorWidget: errorWidget ??
                (context, url, error) {
                  return _placeholderWidget;
                },
            httpHeaders: httpHeaders,
            imageBuilder: imageBuilder,
            progressIndicatorBuilder: progressIndicatorBuilder,
            fadeOutDuration: fadeOutDuration,
            fadeOutCurve: fadeOutCurve,
            fadeInDuration: fadeInDuration,
            fadeInCurve: fadeInCurve,
            alignment: alignment,
            repeat: repeat,
            matchTextDirection: matchTextDirection,
            useOldImageOnUrlChange: useOldImageOnUrlChange,
            color: color,
            filterQuality: filterQuality,
            colorBlendMode: colorBlendMode,
            placeholderFadeInDuration: placeholderFadeInDuration,
            memCacheWidth: memCacheWidth,
            memCacheHeight: memCacheHeight,
            cacheKey: cacheKey,
            maxWidthDiskCache: maxWidthDiskCache,
            maxHeightDiskCache: maxHeightDiskCache,
          );
        case ImageType.networkSvg:
          return _placeholderWidget;
        default:
          return _placeholderWidget;
      }
    }

    return IgnorePointer(
      ignoring: !isZoom,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: buildImage(),
      ),
    );
  }
}
