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
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Language menu (the page has no title, like upstream).
          const SliverAppBar(
            floating: true,
            actions: [LanguageButton()],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Consumer<FavouriteScreenProvider>(
                  builder: (context, favoriteProvider, child) {
                    final isFavorite =
                        favoriteProvider.selectedItemList.contains(index);
                    final module = AppConstants.modules[index];
                    return GestureDetector(
                      onTap: () {
                        if (module.routeName != null) {
                          Navigator.pushNamed(context, module.routeName!);
                        } else {
                          Navigator.push(context, module.route);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        height: ConstantDimensions.heightExtraLarge * 4,
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
                                imageFilter:
                                    ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: module.thumbnailPath.endsWith('.svg')
                                    ? SvgPicture.asset(
                                        module.thumbnailPath,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        module.thumbnailPath,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'modules.${module.name}.name'.tr(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
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
                                        'modules.${module.name}.desc'.tr(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
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
                              PositionedDirectional(
                                top: 8,
                                end: 8,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      if (isFavorite) {
                                        favoriteProvider.removeList(index);
                                      } else {
                                        favoriteProvider.setList(index);
                                      }
                                    },
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 25,
                                      color: isFavorite
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: AppConstants.modules.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Consumer<FavouriteScreenProvider>(
              builder: (context, favoriteProvider, child) {
                final isFavorite = favoriteProvider.drawingBoard;
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AllRoutesConstant.drawingboardRoute,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    height: ConstantDimensions.heightExtraLarge * 4,
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
                            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: SvgPicture.asset(
                              'assets/explore/drawing_board.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'titles.drawing'.tr(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
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
                                      fontWeight: FontWeight.bold,
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
                          PositionedDirectional(
                            top: 8,
                            end: 8,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  favoriteProvider.setDrawingBoard();
                                },
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 25,
                                  color: isFavorite ? Colors.red : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushNamed(context, '/quiz');
            //   },
            //   child: Container(
            //     margin: const EdgeInsets.all(5.0),
            //     padding: const EdgeInsets.all(8.0),
            //     decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 1.0),
            //       borderRadius: BorderRadius.circular(8.0),
            //       color: Colors.blueAccent,
            //     ),
            //     child: Row(
            //       children: [
            //         SizedBox(
            //           width: 50,
            //           height: 50,
            //           child: SvgPicture.asset('assets/explore/notebook.svg'),
            //         ),
            //         const SizedBox(width: 28.0),
            //         const Text(
            //           'Quiz',
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 30.0,
            //             fontFamily: 'Comic',
            //             color: Colors.white,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
