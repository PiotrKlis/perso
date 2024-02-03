import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/home/bloc/home_bloc.dart';
import 'package:perso/app/screens/home/state/home_state.dart';
import 'package:perso/app/screens/home/widgets/perso_account_icon.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/address_and_map/bloc/addres_and_map_bloc.dart';
import 'package:perso/app/widgets/address_and_map/google_map.dart';
import 'package:perso/app/widgets/perso_big_header.dart';
import 'package:perso/app/widgets/perso_clickable_text.dart';
import 'package:perso/app/widgets/perso_header.dart';
import 'package:perso/app/widgets/trainers_list/perso_trainers_list.dart';
import 'package:perso/app/widgets/trainers_search_carousel/perso_trainers_search_carousel.dart';
import 'package:perso/app/widgets/training_category_list/perso_training_category_list.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<AddressAndMapBloc>(
          create: (context) => AddressAndMapBloc(),
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.xmMargin,
                    left: Dimens.xmMargin,
                    right: Dimens.xmMargin,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PersoBigHeader(
                        title: context.strings.home_main_header,
                      ),
                      GestureDetector(
                        onTap: () =>
                            context.pushNamed(ScreenNavigationKey.signIn),
                        child: const PersoAccountIcon(),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: Dimens.xmMargin,
                    top: Dimens.xmMargin,
                    right: Dimens.xmMargin,
                  ),
                  child: Container(
                    color: Colors.grey,
                    height: 30,
                    width: double.infinity,
                    child: const Center(child: Text('TODO: Users search')),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.lMargin,
                    left: Dimens.xmMargin,
                    right: Dimens.xmMargin,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PersoHeader(title: context.strings.category_header),
                      GestureDetector(
                        onTap: () => context.pushNamed(
                          ScreenNavigationKey.trainingCategories,
                        ),
                        child: PersoClickableText(
                          title: context.strings.see_all_categories,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: Dimens.xmMargin,
                    top: Dimens.lMargin,
                  ),
                  child: const PersoTrainingCategoryList(
                    isShortList: true,
                  ),
                ),
                Container(
                  color: PersoColors.lightBlue,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: Dimens.lMargin,
                        ),
                        child: const PersoTrainersSearchCarousel(),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: Dimens.lMargin,
                          left: Dimens.xmMargin,
                          right: Dimens.xmMargin,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PersoHeader(title: context.strings.near_you),
                            GestureDetector(
                              onTap: () => context.pushNamed(
                                ScreenNavigationKey.searchResults,
                                pathParameters: {
                                  'input': 'see all trainers near my location',
                                },
                              ),
                              child: PersoClickableText(
                                title: context.strings.see_all_categories,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: Dimens.xsMargin,
                        ),
                        child: const PersoGoogleMap(),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: Dimens.xsMargin,
                        ),
                        child: const PersoTrainersList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
