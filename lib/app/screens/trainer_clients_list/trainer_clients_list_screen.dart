import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/trainer_clients_list/bloc/trainer_client_list_bloc.dart';
import 'package:perso/app/screens/trainer_clients_list/client_section_data.dart';
import 'package:perso/app/screens/trainer_clients_list/event/trainer_client_list_event.dart';
import 'package:perso/app/screens/trainer_clients_list/section_type.dart';
import 'package:perso/app/screens/trainer_clients_list/state/trainer_client_list_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_client_trainers_list.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/models/trainer_identity.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/core/extensions/string_extensions.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class TrainerClientsScreen extends StatelessWidget {
  const TrainerClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrainerClientsListBloc(),
      child: _TrainerClientsListView(),
    );
  }
}

class _TrainerClientsListView extends StatefulWidget {
  @override
  State<_TrainerClientsListView> createState() =>
      _TrainerClientsListViewState();
}

class _TrainerClientsListViewState extends State<_TrainerClientsListView> {
  Set<String> _segmentSelected = Set.from({_Segments.clients.name});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _segmentedButton(),
          BlocBuilder<TrainerClientsListBloc, TrainerClientsListState>(
            builder: (context, state) {
              return state.when(
                initial: () {
                  context.read<TrainerClientsListBloc>().add(
                        const TrainerClientsListEvent.loadClientData(),
                      );
                  return const Center(child: CircularProgressIndicator());
                },
                clientsData: _ClientsList.new,
                error: _Error.new,
                trainersData: (List<TrainerIdentity> trainersData) {
                  return PersoClientTrainersList(trainersData);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _segmentedButton() {
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      width: double.infinity,
      child: SegmentedButton(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) {
            return ThemeText.bodyBoldBlackText;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              } else {
                return Colors.black;
              }
            },
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.black;
              } else {
                return Colors.white;
              }
            },
          ),
        ),
        showSelectedIcon: false,
        selected: _segmentSelected,
        segments: [
          ButtonSegment<String>(
            value: _Segments.clients.name,
            label: const Text('Clients'),
          ),
          ButtonSegment<String>(
            value: _Segments.trainers.name,
            label: const Text('Trainers'),
          ),
        ],
        onSelectionChanged: (selectedSet) {
          _reloadScreenContent(selectedSet);
          setState(() {
            _segmentSelected = selectedSet;
          });
        },
      ),
    );
  }

  void _reloadScreenContent(Set<String> selectedSet) {
    if (selectedSet.contains(_Segments.trainers.name)) {
      context
          .read<TrainerClientsListBloc>()
          .add(const TrainerClientsListEvent.loadTrainerData());
    } else {
      context
          .read<TrainerClientsListBloc>()
          .add(const TrainerClientsListEvent.loadClientData());
    }
  }
}

class _ClientsList extends StatefulWidget {
  const _ClientsList(this.clientsData);

  final List<ClientSectionData> clientsData;

  @override
  State<_ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<_ClientsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: Dimens.xmMargin,
            right: Dimens.xmMargin,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Trainings', style: ThemeText.largerTitleBold),
              Icon(Icons.notifications_off),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: Dimens.xmMargin,
            top: Dimens.lMargin,
            bottom: Dimens.mMargin,
          ),
          child: const Text(
            'My clients',
            style: ThemeText.mediumTitleBold,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.clientsData.length,
          itemBuilder: (context, index) {
            return StickyHeader(
              header:
                  _Header(sectionType: widget.clientsData[index].sectionType),
              content: _Clients(section: widget.clientsData[index]),
            );
          },
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.sectionType});

  final SectionType sectionType;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PersoColors.grey,
      padding: const EdgeInsets.all(Dimens.xmMargin),
      alignment: Alignment.centerLeft,
      child: Text(
        '${sectionType.name.capitalizeFirstLetter()} clients',
        style: ThemeText.bodyBoldWhiteText,
      ),
    );
  }
}

class _Clients extends StatelessWidget {
  const _Clients({
    required this.section,
  });

  final ClientSectionData section;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final client in section.clients)
          _Client(
            sectionType: section.sectionType,
            client: client,
            trainerId: section.trainerId,
          ),
      ],
    );
  }
}

class _Client extends StatelessWidget {
  const _Client({
    required this.sectionType,
    required this.client,
    required this.trainerId,
  });

  final SectionType sectionType;
  final ClientEntity client;
  final String trainerId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (sectionType == SectionType.active) {
              context.pushNamed(
                ScreenNavigationKey.trainerPlanOverview,
                queryParameters: {
                  'clientId': client.id,
                  'trainerId': trainerId,
                },
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.only(
              top: Dimens.xsMargin,
              bottom: Dimens.xsMargin,
            ),
            child: Row(
              children: [
                //TODO: Add navigation to client profile on image click
                _Image(imagePath: client.imagePath),
                _Title(
                  name: client.name,
                  surname: client.surname,
                  nickname: client.nickname,
                ),
                _Actions(sectionType: sectionType, clientId: client.id),
              ],
            ),
          ),
        ),
        const PersoDivider(),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.name,
    required this.surname,
    required this.nickname,
  });

  final String name;
  final String surname;
  final String nickname;

  @override
  Widget build(BuildContext context) {
    final title = '$name $surname $nickname';
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          left: Dimens.xsMargin,
        ),
        child: Text(
          title,
          style: ThemeText.bodyRegularBlackText,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: Dimens.xsMargin),
      child: imagePath.isNotEmpty
          ? Image.network(imagePath)
          : const Icon(
              Icons.account_circle,
              size: Dimens.accountIconSize,
            ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.sectionType,
    required this.clientId,
  });

  final SectionType sectionType;
  final String clientId;

  @override
  Widget build(BuildContext context) {
    final buttons = switch (sectionType) {
      SectionType.active => _ActiveActions(clientId),
      SectionType.pending => _PendingActions(clientId),
      SectionType.inactive => _InactiveActions(clientId),
    };
    return Container(
      margin: const EdgeInsets.only(right: Dimens.xsMargin),
      child: buttons,
    );
  }
}

class _InactiveActions extends StatelessWidget {
  const _InactiveActions(this.clientId);

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: false,
          onChanged: (value) {
            context
                .read<TrainerClientsListBloc>()
                .add(TrainerClientsListEvent.activateClient(clientId));
          },
        ),
        GestureDetector(
          onTap: () {
            context
                .read<TrainerClientsListBloc>()
                .add(TrainerClientsListEvent.removeClient(clientId));
          },
          child: const Icon(
            Icons.delete_forever,
          ),
        ),
      ],
    );
  }
}

class _PendingActions extends StatelessWidget {
  const _PendingActions(this.clientId);

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: false,
          onChanged: (value) {
            if (value) {
              context
                  .read<TrainerClientsListBloc>()
                  .add(TrainerClientsListEvent.activateClient(clientId));
            }
          },
        ),
        GestureDetector(
          onTap: () {
            context
                .read<TrainerClientsListBloc>()
                .add(TrainerClientsListEvent.removeClient(clientId));
          },
          child: const Icon(
            Icons.delete_forever,
          ),
        ),
      ],
    );
  }
}

class _ActiveActions extends StatelessWidget {
  const _ActiveActions(this.clientId);

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: true,
      onChanged: (value) {
        context
            .read<TrainerClientsListBloc>()
            .add(TrainerClientsListEvent.deactivateClient(clientId));
      },
    );
  }
}

class _Error extends StatelessWidget {
  const _Error(this.error);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: ThemeText.calloutRegularRed,
      ),
    );
  }
}

enum _Segments { trainers, clients }
