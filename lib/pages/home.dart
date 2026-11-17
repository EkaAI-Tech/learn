// ignore: unused_import
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:learn/utils/assets_path.dart';
import 'package:learn/utils/const_dimensions.dart';
import 'package:learn/utils/route/route_constant.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import '../theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:learn/widgets/language_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<bool> _isImageClicked = List.generate(8, (index) => false);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // Language menu (English / العربية / Français / Español).
          const LanguageButton(compact: false),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16, top: 1),
            child: IconButton(
              icon: Icon(
                themeProvider.themeMode == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            children: [
              categoryCard(
                context: context,
                title: "ALPHABETS".tr(),
                image: AssetsPath.getAlphabetImage(Alphabets.alphabets),
                shortDescription: "A2Z".tr(),
                route: AllRoutesConstant.atozRoute,
                index: 0,
              ),
              const SizedBox(
                height: ConstantDimensions.heightMedium,
              ),
              categoryCard(
                context: context,
                title: 'home.numbers'.tr(),
                image: 'assets/images/numbers/numbers.jpg',
                shortDescription: 'home.numbers_desc'.tr(),
                route: AllRoutesConstant.numberRoute,
                index: 7,
              ),
              const SizedBox(
                height: ConstantDimensions.heightMedium,
              ),
              categoryCard(
                context: context,
                title: 'home.animals'.tr(),
                image: AssetsPath.getAnimalImage(Animals.animals),
                shortDescription: 'home.animals_desc'.tr(),
                route: AllRoutesConstant.animalRoute,
                index: 1,
              ),
              const SizedBox(
                height: ConstantDimensions.heightMedium,
              ),
              categoryCard(
                context: context,
                title: 'home.body'.tr(),
                image: AssetsPath.getBodyImage(Body.body),
                shortDescription:
                    'home.body_desc'.tr(),
                route: AllRoutesConstant.partsRoute,
                index: 2,
              ),
              const SizedBox(
                height: ConstantDimensions.heightMedium,
              ),
              categoryCard(
                context: context,
                title: 'home.birds'.tr(),
                image: AssetsPath.getBirdImage(Birds.birds),
                shortDescription: 'home.birds_desc'.tr(),
                route: AllRoutesConstant.birdsRoute,
                index: 3,
              ),
              const SizedBox(
                height: ConstantDimensions.heightMedium,
              ),
              categoryCard(
                context: context,
                title: 'home.colours'.tr(),
                image: AssetsPath.getColoursImage(ColorImages.colorsCover),
                shortDescription: 'home.colours_desc'.tr(),
                route: AllRoutesConstant.colourRoute,
                index: 4,
              ),
              const SizedBox(
                height: ConstantDimensions.heightMedium,
              ),
              categoryCard(
                context: context,
                title: 'home.flowers'.tr(),
                image: AssetsPath.getFlowerImage(Flowers.flowerBanner),
                shortDescription: 'home.flowers_desc'.tr(),
                route: AllRoutesConstant.flowerRoute,
                index: 5,
              ),
              const SizedBox(
                height: ConstantDimensions.heightMedium,
              ),
              categoryCard(
                context: context,
                title: 'home.fruits'.tr(),
                image: 'assets/fruitsVeges/cover.jpg',
                shortDescription:
                    'home.fruits_desc'.tr(),
                route: AllRoutesConstant.fruitRoute,
                index: 6,
              ),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }

  Column categoryCard({
    required BuildContext context,
    required String title,
    required String image,
    required String shortDescription,
    required String route,
    required int index,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isImageClicked[index] = !_isImageClicked[index];
            });
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.pushNamed(context, route);
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _isImageClicked[index]
                ? ConstantDimensions.heightSmallImage
                : ConstantDimensions.heightBigImage,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: ConstantDimensions.heightMedium),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(shortDescription, textAlign: TextAlign.center),
      ],
    );
  }
}
