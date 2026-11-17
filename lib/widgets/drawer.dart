import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// ignore: unused_import
import 'package:learn/utils/assets_path.dart';
import 'package:learn/utils/route/route_constant.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).canvasColor,
            child: Column(
              children: [
                DrawerHeader(
                  padding: const EdgeInsets.all(0),
                  decoration:
                      BoxDecoration(color: Theme.of(context).canvasColor),
                  child: UserAccountsDrawerHeader(
                    margin: const EdgeInsets.all(0),
                    decoration:
                        BoxDecoration(color: Theme.of(context).canvasColor),
                    accountName: Text(
                      'drawer.app_name'.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    accountEmail: Text(
                      'drawer.made_by'.tr(namedArgs: {'name': 'sapatevaibhav'}),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/dp.png"),
                    ),
                  ),
                ),
                _buildListTile(
                  icon: Icons.home,
                  title: 'titles.home'.tr(),
                  onTap: () {
                    Navigator.pushNamed(
                        context, AllRoutesConstant.mainhomeRoute);
                  },
                  context: context,
                ),
                _buildListTile(
                  icon: Icons.text_fields,
                  title: 'titles.atoz'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AllRoutesConstant.atozRoute);
                  },
                  context: context,
                ),
                _buildListTile(
                  icon: Icons.pest_control_rodent_outlined,
                  title: 'titles.animals'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AllRoutesConstant.animalRoute);
                  },
                  context: context,
                ),
                _buildListTile(
                  icon: Icons.egg,
                  title: 'titles.birds'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AllRoutesConstant.birdsRoute);
                  },
                  context: context,
                ),
                _buildListTile(
                  icon: Icons.cloud,
                  title: 'modules.Seasons.name'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AllRoutesConstant.seasonRoute);
                  },
                  context: context,
                ),
                _buildListTile(
                  icon: Icons.pentagon_outlined,
                  title: 'titles.shapes'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AllRoutesConstant.shapesRoute);
                  },
                  context: context,
                ),
                _buildListTile(
                  icon: Icons.back_hand_rounded,
                  title: 'titles.body'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AllRoutesConstant.partsRoute);
                  },
                  context: context,
                ),
                _buildListTile(
                  icon: Icons.work,
                  title: 'titles.occupations'.tr(),
                  onTap: () {
                    Navigator.pushNamed(
                        context, AllRoutesConstant.occupationRoute);
                  },
                  context: context,
                ),
                _buildListTile(
                  icon: Icons.sunny,
                  title: 'titles.solar'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AllRoutesConstant.solarRoute);
                  },
                  context: context,
                ),
                _buildListTile(
                  icon: Icons.palette,
                  title: 'titles.colours'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AllRoutesConstant.colourRoute);
                  },
                  context: context,
                ),
                _buildListTile(
                  icon: Icons.local_florist,
                  title: 'titles.flowers'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AllRoutesConstant.flowerRoute);
                  },
                  context: context,
                ),
                _buildListTile(
                  icon: Icons.edit,
                  title: 'titles.drawing'.tr(),
                  onTap: () {
                    Navigator.pushNamed(
                        context, AllRoutesConstant.drawingboardRoute);
                  },
                  context: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: onTap,
    );
  }

  // Widget _buildListTileSVG({
  //   required BuildContext context,
  //   required String icon,
  //   required String title,
  //   required VoidCallback onTap,
  // }) {
  //   return ListTile(
  //     leading: SvgPicture.asset(
  //       icon,
  //       width: 24,
  //       height: 24,
  //     ),
  //     title: Text(
  //       title,
  //       style: Theme.of(context).textTheme.bodyLarge,
  //     ),
  //     onTap: onTap,
  //   );
  // }
}
