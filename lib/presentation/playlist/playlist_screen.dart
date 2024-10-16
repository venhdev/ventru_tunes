import 'package:flutter/material.dart';
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

const double expandedHeight = 350.0;

class _PlaylistScreenState extends State<PlaylistScreen> {
  late final ScrollController _scrollController;

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
                  const SizedBox(height: AppSizes.sp4),
                  Row(
                    children: [
                      Flexible(
                          child: Text.rich(
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        TextSpan(text: 'By ', style: bodyStyle, children: [
                          TextSpan(text: 'Spotify', style: textTheme.titleSmall?.copyWith(color: AppColors.cE0E0E0)),
                        ]),
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
                  const SizedBox(height: AppSizes.sp20),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: ImageBuilder.localSvg(SvgAssets.add, size: AppSizes.sp40),
                      ),
                      const SizedBox(width: AppSizes.sp14),
                      InkWell(
                        onTap: () {},
                        child: ImageBuilder.localSvg(SvgAssets.addToPlaylist, size: AppSizes.sp40),
                      ),
                      const SizedBox(width: AppSizes.sp14),
                      InkWell(
                        onTap: () {},
                        child: ImageBuilder.localSvg(SvgAssets.download, size: AppSizes.sp40),
                      ),
                      const SizedBox(width: AppSizes.sp14),
                      InkWell(
                        onTap: () {},
                        child: ImageBuilder.localSvg(SvgAssets.more, size: AppSizes.sp40),
                      ),
                      const SizedBox(width: AppSizes.sp14),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: ImageBuilder.localSvg(SvgAssets.shuffle, size: AppSizes.sp40),
                      ),
                      const SizedBox(width: AppSizes.sp14),
                      InkWell(
                        onTap: () {},
                        child: ImageBuilder.localSvg(SvgAssets.play, size: AppSizes.sp40),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSizes.sp30)),
          SliverPadding(
            padding: AppSizes.sidePadding,
            sliver: SliverList.builder(
              itemCount: 40,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.sp8, horizontal: AppSizes.zero),
                  child: Row(
                    children: [
                      ImageBuilder(
                        '',
                        width: AppSizes.sp50,
                        height: AppSizes.sp50,
                        borderRadius: BorderRadius.circular(AppSizes.sp3),
                      ),
                      const SizedBox(width: AppSizes.sp10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Song name',
                            style: textTheme.titleMedium?.copyWith(color: AppColors.cE0E0E0),
                          ),
                          const SizedBox(height: AppSizes.sp4),
                          Text(
                            'Artist name',
                            style: textTheme.bodyMedium?.copyWith(color: AppColors.c898989),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: ImageBuilder.localSvg(SvgAssets.more, size: AppSizes.sp40),
                      ),
                    ],
                  ),
                );
              },
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
  double imageOpacity = 1;
  double titlePadding = minTitlePadding;

  void appbarExpendListener() {
    try {
      double opacity = 0;
      if (widget.scrollController.hasClients) {
        opacity = ((expandedHeight - widget.scrollController.offset) / expandedHeight).clamp(0, 1);
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
          searchBarOpacity = (opacity - (1 - opacity) * 1.2).clamp(0, 1);
          imageOpacity = opacity;

          final padding = (minTitlePadding + (AppSizes.leadingWidth - (opacity * AppSizes.leadingWidth * 1.1)))
              .clamp(minTitlePadding, maxTitlePadding);

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
    const paddingTop = 51;

    return SliverAppBar(
      pinned: true,
      floating: false,
      snap: false,
      expandedHeight: expandedHeight,
      forceMaterialTransparency: true,
      foregroundColor: AppColors.bodyTextColor,
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
              alignment: Alignment.center,
              children: [
                Positioned(
                  // paddingTop is the top padding of the appbar
                  // kToolbarHeight is the height of the toolbar (search bar)
                  top: paddingTop + kToolbarHeight + 32,
                  // 28 is the height of text title
                  // 1.5 [expandedTitleScale]
                  // 16 is the bottom padding of title (= default titlePadding)
                  bottom: (28 * 1.5) + AppSizes.sp16 + 32,
                  child: Opacity(
                    opacity: imageOpacity,
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
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          centerTitle: false,
          expandedTitleScale: 1.5,
          titlePadding: EdgeInsets.only(
            // top: AppSizes.sp15,
            right: AppSizes.zero,
            bottom: AppSizes.sp16,
            left: titlePadding,
          ),
        ),
      ),
    );
  }
}
