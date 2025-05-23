import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/home/bloc/home_bloc.dart';
import 'package:perso/app/screens/home/state/home_state.dart';
import 'package:perso/app/screens/home/widgets/perso_account_icon.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/map/map_cubit.dart';
import 'package:perso/app/widgets/map/perso_google_map.dart';
import 'package:perso/app/widgets/perso_big_header.dart';
import 'package:perso/app/widgets/perso_clickable_text.dart';
import 'package:perso/app/widgets/perso_header.dart';
import 'package:perso/app/widgets/search/trainers/bloc/search_trainers_bloc.dart';
import 'package:perso/app/widgets/search/trainers/event/search_trainers_event.dart';
import 'package:perso/app/widgets/trainers_list/bloc/trainers_list_bloc.dart';
import 'package:perso/app/widgets/trainers_list/perso_trainers_list.dart';
import 'package:perso/app/widgets/trainers_search_carousel/perso_trainers_search_carousel.dart';
import 'package:perso/app/widgets/training_category_list/perso_training_category_list.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    setupStringProvider(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<MapCubit>(
          create: (context) => MapCubit(),
        ),
        BlocProvider(
          create: (context) => SearchTrainersBloc()
            ..add(
              const SearchTrainersEvent.searchTrainersInput(
                'trainers',
              ),
            ),
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: Dimens.xmMargin,
                      left: Dimens.xmMargin,
                      right: Dimens.xmMargin,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: Dimens.xmMargin,
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
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: Dimens.xmMargin,
                      top: Dimens.xmMargin,
                      right: Dimens.xmMargin,
                    ),
                    child: SearchBar(
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                      hintText: 'Search trainers',
                      leading: const Icon(Icons.search),
                      keyboardType: TextInputType.none,
                      onTap: () => context.pushNamed(
                        ScreenNavigationKey.searchResults,
                        pathParameters: {'input': ' '},
                      ),
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
                  ColoredBox(
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
                                    'input': 'all trainers near my location',
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
      ),
    );
  }
}
