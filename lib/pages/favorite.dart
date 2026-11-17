import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn/utils/constants.dart';
import 'package:learn/utils/route/route_constant.dart';
import 'package:provider/provider.dart';
import '../../favorite_page_provider.dart';
import '../../utils/const_dimensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:learn/widgets/language_button.dart';

// Explore Page
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    await Provider.of<FavouriteScreenProvider>(context, listen: false)
        .loadFromPrefs();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<FavouriteScreenProvider>(context, listen: false);
    List<int> selectItem = provider.selectedItemList;
    return (provider.selectedItemList.isEmpty && !provider.drawingBoard)
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                '${'favorite.empty'.tr()}\n${'favorite.empty_hint'.tr()}',
                textAlign: TextAlign.center,
              ),
            ),
          )
        : _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: CustomScrollView(
                  slivers: [
                    // Language menu (the page has no title, like upstream).
                    const SliverAppBar(
                      floating: true,
                      actions: [LanguageButton()],
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AllRoutesConstant.drawingboardRoute);
                            },
                            child: !provider.drawingBoard
                                ? Container(
                                    height: 0,
                                  )
                                : Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    height:
                                        ConstantDimensions.heightExtraLarge * 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        alignment: Alignment.center,
                                        children: [
                                          ImageFiltered(
                                            imageFilter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: SvgPicture.asset(
                                              'assets/explore/drawing_board.svg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'titles.drawing'.tr(),
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium!
                                                        .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      shadows: [
                                                        const Shadow(
                                                          color: Colors.black,
                                                          offset: Offset(2, 1),
                                                          blurRadius: 4,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    'explore.drawing_desc'.tr(),
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      shadows: [
                                                        const Shadow(
                                                          color: Colors.black,
                                                          offset: Offset(2, 1),
                                                          blurRadius: 2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Consumer<
                                                    FavouriteScreenProvider>(
                                                  builder:
                                                      (context, item, child) {
                                                    return IconButton(
                                                      onPressed: () {
                                                        item.setDrawingBoard();
                                                        setState(() {});
                                                      },
                                                      icon: item.drawingBoard
                                                          ? const Icon(
                                                              Icons.favorite,
                                                              size: 25,
                                                              color: Colors.red,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              size: 25,
                                                            ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: AppConstants.modules.length,
                        (context, index) {
                          return GestureDetector(
                            onTap: () {
                              try {
                                final module = AppConstants.modules[index];
                                if (module.routeName != null) {
                                  Navigator.pushNamed(
                                      context, module.routeName!);
                                } else {
                                  Navigator.push(context, module.route);
                                }
                              } catch (e) {
                                // ignore: avoid_print
                                print(e);
                              }
                            },
                            child: !(selectItem.contains(index))
                                ? Container()
                                : Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    height:
                                        ConstantDimensions.heightExtraLarge * 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        alignment: Alignment.center,
                                        children: [
                                          ImageFiltered(
                                            imageFilter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: AppConstants.modules[index]
                                                    .thumbnailPath
                                                    .endsWith('.svg')
                                                ? SvgPicture.asset(
                                                    AppConstants.modules[index]
                                                        .thumbnailPath,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    AppConstants.modules[index]
                                                        .thumbnailPath,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'modules.${AppConstants.modules[index].name}.name'
                                                        .tr(),
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium!
                                                        .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      shadows: [
                                                        const Shadow(
                                                          color: Colors.black,
                                                          offset: Offset(2, 1),
                                                          blurRadius: 4,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    'modules.${AppConstants.modules[index].name}.desc'
                                                        .tr(),
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      shadows: [
                                                        const Shadow(
                                                          color: Colors.black,
                                                          offset: Offset(2, 1),
                                                          blurRadius: 2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Consumer<
                                                    FavouriteScreenProvider>(
                                                  builder:
                                                      (context, item, child) {
                                                    return IconButton(
                                                      onPressed: () {
                                                        if (item
                                                            .selectedItemList
                                                            .contains(index)) {
                                                          item.removeList(
                                                              index);
                                                          setState(() {});
                                                        } else {
                                                          item.setList(index);
                                                        }
                                                      },
                                                      icon: selectItem
                                                              .contains(index)
                                                          ? const Icon(
                                                              Icons.favorite,
                                                              size: 25,
                                                              color: Colors.red,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              size: 25,
                                                            ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
  }
}
