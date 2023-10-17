import 'package:Perso/app/screens/home/bloc/home_bloc.dart';
import 'package:Perso/app/screens/home/event/home_event.dart';
import 'package:Perso/app/screens/home/state/home_state.dart';
import 'package:Perso/app/screens/home/widgets/perso_account_icon.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/widgets/adress_and_map/bloc/addres_and_map_bloc.dart';
import 'package:Perso/app/widgets/adress_and_map/google_map.dart';
import 'package:Perso/app/widgets/perso_big_header.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_clickable_text.dart';
import 'package:Perso/app/widgets/perso_header.dart';
import 'package:Perso/app/widgets/perso_search.dart';
import 'package:Perso/app/widgets/trainers_list/perso_trainers_list.dart';
import 'package:Perso/app/widgets/trainers_search_carousel/perso_trainers_search_carousel.dart';
import 'package:Perso/app/widgets/training_category_list/perso_training_category_list.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
      child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            state.when(
                initial: () {},
                navigateToSignIn: () {
                  context.pushNamed(ScreenNavigationKey.signIn);
                },
                navigateToClientProfile: () {
                  context.pushNamed(ScreenNavigationKey.clientProfile);
                },
                navigateToTrainerProfile: () {
                  context.pushNamed(ScreenNavigationKey.trainerProfile);
                });
          },
          builder: (context, state) => SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: Dimens.normalMargin,
                            left: Dimens.normalMargin,
                            right: Dimens.normalMargin),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PersoBigHeader(
                                title: AppLocalizations.of(context)!
                                    .home_main_header,
                              ),
                            GestureDetector(
                          onTap: () => _handleAccountClick(context),
                          child: const PersoAccountIcon()),
                            ]),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              left: Dimens.normalMargin,
                              top: Dimens.normalMargin,
                              right: Dimens.normalMargin),
                          child: GestureDetector(
                              onTap: () =>
                                  context.pushNamed(ScreenNavigationKey.search),
                              child:
                                  const AbsorbPointer(child: PersoSearch()))),
                      Container(
                        margin: const EdgeInsets.only(
                            top: Dimens.bigMargin,
                            left: Dimens.normalMargin,
                            right: Dimens.normalMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PersoHeader(
                                title: AppLocalizations.of(context)!
                                    .category_header),
                            GestureDetector(
                              onTap: () => context.pushNamed(
                                  ScreenNavigationKey.trainingCategories),
                              child: PersoClickableText(
                                  title: AppLocalizations.of(context)!
                                      .see_all_categories),
                            )
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              left: Dimens.normalMargin, top: Dimens.bigMargin),
                          child: const PersoTrainingCategoryList(
                              isShortList: true)),
                      Container(
                        color: PersoColors.lightBlue,
                        child: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    top: Dimens.bigMargin),
                                child: PersoTrainersSearchCarousel()),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: Dimens.bigMargin,
                                  left: Dimens.normalMargin,
                                  right: Dimens.normalMargin),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PersoHeader(
                                      title: AppLocalizations.of(context)!
                                          .near_you),
                                  GestureDetector(
                                    onTap: () => context.pushNamed(
                                        ScreenNavigationKey.searchResults,
                                        pathParameters: {
                                          "input":
                                              "see all trainers near my location"
                                        }),
                                    child: PersoClickableText(
                                        title: AppLocalizations.of(context)!
                                            .see_all_categories),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: Dimens.smallMargin),
                              child: PersoGoogleMap(),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    top: Dimens.smallMargin),
                                child: const PersoTrainersList())
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              )),
    );
  }

  void _handleAccountClick(BuildContext context) {
    context.read<HomeBloc>().add(const HomeEvent.accountNavigation());
  }
}
