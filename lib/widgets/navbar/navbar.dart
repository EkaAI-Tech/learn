import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/cubit/index_cubit.dart';

class BottomNavBar extends StatefulWidget {
  final PageController pageController;

  const BottomNavBar({
    super.key,
    required this.pageController,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexCubit, int>(
      builder: (context, index) {
        final currentPageIndex = index;
        return NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (index) {
            // Animate to the selected page
            widget.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            context.read<IndexCubit>().changeIndex(index);
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_rounded),
              label: 'nav.home'.tr(),
            ),
            NavigationDestination(
              icon: const Icon(Icons.search_rounded),
              label: 'nav.explore'.tr(),
            ),
            NavigationDestination(
              icon: const Icon(Icons.favorite_rounded),
              label: 'nav.favorite'.tr(),
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_rounded),
              label: 'nav.about'.tr(),
            ),
          ],
        );
      },
    );
  }
}
