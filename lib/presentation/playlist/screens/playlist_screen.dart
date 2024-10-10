import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunes/core/configs/themes/app_colors.dart';
import 'package:tunes/core/configs/themes/app_sizes.dart';
import 'package:tunes/core/constant/assets/app_assets.dart';
import 'package:tunes/domain/entities/playlist_entity.dart';
import 'package:tunes/presentation/widgets/images/image_builder.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key, required this.playlist});

  final PlaylistEntity playlist;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

// const double _bottomPreferredSize = 26.0;

const double expandedHeight = 350.0;
// const double searchBoxHeight = 128.0;

class _PlaylistScreenState extends State<PlaylistScreen> {
  late final ScrollController _scrollController;

  // final TextStyle? bodyStyle;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final TextStyle? bodyStyle = textTheme.bodyMedium?.copyWith(
      color: AppColors.bodyTextColor,
    );

    return Scaffold(
      backgroundColor: AppColors.gradientPlaylistEnd,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _PlaylistSliverAppBar(title: widget.playlist.name, scrollController: _scrollController),
          SliverPadding(
              padding: AppSizes.sidePadding,
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    // const SizedBox(height: AppSizes.sp20),
                    Row(
                      children: [
                        Flexible(
                            child: Text(
                          'By Spotify',
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: bodyStyle,
                        )),
                        const SizedBox(width: AppSizes.sp10),
                        ImageBuilder.localSvg(SvgAssets.dotCenter, size: 3),
                        const SizedBox(width: AppSizes.sp10),
                        Flexible(
                            child: Text(
                          '50 songs',
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: bodyStyle,
                        )),
                        const SizedBox(width: AppSizes.sp10),
                        ImageBuilder.localSvg(SvgAssets.dotCenter, size: 3),
                        const SizedBox(width: AppSizes.sp10),
                        Flexible(
                            child: Text(
                          '3 hr 30 min',
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: bodyStyle,
                        )),
                      ],
                    ),
                  ],
                ),
              )),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.gradientPlaylistEnd,
                  ),
                  child: Column(
                    children: [
                      const Placeholder(),
                      Container(
                        height: 200,
                        color: AppColors.gradientPlaylistEnd,
                      ),
                      const Placeholder(),
                      const Placeholder(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaylistSliverAppBar extends StatefulWidget {
  const _PlaylistSliverAppBar({
    required this.title,
    required this.scrollController,
  });

  final String title;
  final ScrollController scrollController;

  @override
  State<_PlaylistSliverAppBar> createState() => _PlaylistSliverAppBarState();
}

const double minTitlePadding = AppSizes.sp15; // when expanded
const double maxTitlePadding = AppSizes.leadingWidth + AppSizes.sp15; // when collapsed

class _PlaylistSliverAppBarState extends State<_PlaylistSliverAppBar> {
  double searchBarOpacity = 1;
  double titlePadding = minTitlePadding;

  void appbarExpendListener() {
    try {
      double opacity = 0;
      if (widget.scrollController.hasClients) {
        opacity = ((expandedHeight - widget.scrollController.offset) / expandedHeight).clamp(0, 1);
        log('opacity: $opacity');
        if (opacity < 0) {
          opacity = 0;
        }
        if (opacity > 1) {
          opacity = 1;
        }
      } else {
        opacity = 1;
      }

      if (searchBarOpacity != opacity) {
        setState(() {
          searchBarOpacity = (opacity - (1 - opacity) * 1.5).clamp(0, 1);

          final padding = minTitlePadding + (AppSizes.leadingWidth - (opacity * AppSizes.leadingWidth));
          if (titlePadding != padding) {
            titlePadding = padding;
          }
        });
      }
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(appbarExpendListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(appbarExpendListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return SliverAppBar(
      pinned: true,
      floating: false,
      snap: false,
      expandedHeight: expandedHeight,
      forceMaterialTransparency: true,
      // backgroundColor: Colors.red,
      foregroundColor: AppColors.bodyTextColor,
      // surfaceTintColor: Colors.red,
      toolbarHeight: kToolbarHeight,
      title: Visibility(
        visible: searchBarOpacity > 0,
        child: Opacity(
          opacity: searchBarOpacity,
          child: TextField(
            style: textTheme.titleSmall?.copyWith(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search playlist',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: AppColors.textFieldBackground,
              hintStyle: textTheme.titleSmall?.copyWith(color: const Color(0xB3898989)),
            ),
          ),
        ),
      ),
      flexibleSpace: DecoratedBox(
        decoration: const BoxDecoration(color: AppColors.gradientPlaylistMiddle),
        child: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: Container(
            decoration: BoxDecoration(
              color: AppColors.gradientPlaylistEnd,
              gradient: LinearGradient(
                colors: AppColors.gradientPlaylist,
                tileMode: TileMode.clamp,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: mediaQuery.padding.top + kToolbarHeight,
                  child: Align(
                    alignment: Alignment.center,
                    child: ImageBuilder(
                      '',
                      borderRadius: BorderRadius.circular(24.0),
                      fit: BoxFit.cover,
                      height: expandedHeight / 2,
                      width: expandedHeight / 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            widget.title,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
          ),
          centerTitle: false,
          expandedTitleScale: 1.2,
          titlePadding: EdgeInsets.only(
            top: AppSizes.sp15,
            right: AppSizes.zero,
            // bottom: AppSizes.sp16,
            left: titlePadding,
          ),
          // stretchModes: const [
          //   StretchMode.zoomBackground,
          //   StretchMode.fadeTitle,
          // ],
        ),
      ),
    );
  }
}
