import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/core/string_extensions.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

enum SectionType { active, pending, inactive }

class Section {
  Section({required this.sectionType, required this.clients});

  final SectionType sectionType;
  final List<ClientData> clients;
}

class ClientData {
  ClientData({required this.imagePath, required this.name});

  final String imagePath;
  final String name;
}

class TrainerClientsScreen extends StatelessWidget {
  const TrainerClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      Section(
        sectionType: SectionType.active,
        clients: [
          ClientData(imagePath: 'imagePath', name: 'Active John Doe'),
          ClientData(imagePath: 'imagePath', name: 'Active Jane Doe'),
          ClientData(imagePath: 'imagePath', name: 'Active John Smith'),
          ClientData(imagePath: 'imagePath', name: 'Active John Doe'),
          ClientData(imagePath: 'imagePath', name: 'Active Jane Doe'),
          ClientData(imagePath: 'imagePath', name: 'Active John Smith'),
          ClientData(imagePath: 'imagePath', name: 'Active John Doe'),
          ClientData(imagePath: 'imagePath', name: 'Active Jane Doe'),
          ClientData(imagePath: 'imagePath', name: 'Active John Smith'),
          ClientData(imagePath: 'imagePath', name: 'Active John Doe'),
          ClientData(imagePath: 'imagePath', name: 'Active Jane Doe'),
          ClientData(imagePath: 'imagePath', name: 'Active John Smith'),
        ],
      ),
      Section(
        sectionType: SectionType.pending,
        clients: [
          ClientData(imagePath: 'imagePath', name: 'Pending John Doe'),
          ClientData(imagePath: 'imagePath', name: 'Pending Jane Doe'),
          ClientData(imagePath: 'imagePath', name: 'Pending John Smith'),
          ClientData(imagePath: 'imagePath', name: 'Pending John Doe'),
          ClientData(imagePath: 'imagePath', name: 'Pending Jane Doe'),
          ClientData(imagePath: 'imagePath', name: 'Pending John Smith'),
          ClientData(imagePath: 'imagePath', name: 'Pending John Doe'),
          ClientData(imagePath: 'imagePath', name: 'Pending Jane Doe'),
          ClientData(imagePath: 'imagePath', name: 'Pending John Smith'),
          ClientData(imagePath: 'imagePath', name: 'Pending John Doe'),
          ClientData(imagePath: 'imagePath', name: 'Pending Jane Doe'),
          ClientData(imagePath: 'imagePath', name: 'Pending John Smith'),
        ],
      ),
      Section(
        sectionType: SectionType.inactive,
        clients: [
          ClientData(imagePath: 'imagePath', name: 'Inactive John Doe'),
          ClientData(imagePath: 'imagePath', name: 'Inactive Jane Doe'),
          ClientData(
            imagePath: 'imagePath',
            name: 'Inactive John Smith Inactive John Smith',
          ),
        ],
      ),
    ];
    return SafeArea(
      child: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return StickyHeader(
            header: _Header(sectionType: sections[index].sectionType),
            content: _Clients(section: sections[index]),
          );
        },
      ),
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
      padding: const EdgeInsets.all(Dimens.normalMargin),
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

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final client in section.clients)
          _Client(
            sectionType: section.sectionType,
            client: client,
          ),
      ],
    );
  }
}

class _Client extends StatelessWidget {
  const _Client({required this.sectionType, required this.client});

  final SectionType sectionType;
  final ClientData client;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: Dimens.smallMargin,
            bottom: Dimens.smallMargin,
          ),
          child: Row(
            children: [
              const _Image(),
              _Title(client: client),
              _Actions(sectionType: sectionType),
            ],
          ),
        ),
        const PersoDivider(),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.client,
  });

  final ClientData client;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          left: Dimens.smallMargin,
        ),
        child: Text(
          client.name,
          style: ThemeText.bodyRegularBlackText,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: Dimens.smallMargin),
      child: const Icon(
        //client.imagePath
        Icons.account_circle,
        size: Dimens.accountIconSize,
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.sectionType,
  });

  final SectionType sectionType;

  @override
  Widget build(BuildContext context) {
    final buttons = switch (sectionType) {
      SectionType.active => const _ActiveActions(),
      SectionType.pending => const _PendingActions(),
      SectionType.inactive => const _InactiveActions(),
    };
    return Container(
      margin: const EdgeInsets.only(right: Dimens.smallMargin),
      child: buttons,
    );
  }
}

class _InactiveActions extends StatefulWidget {
  const _InactiveActions();

  @override
  State<_InactiveActions> createState() => _InactiveActionsState();
}

class _InactiveActionsState extends State<_InactiveActions> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: switchValue,
          onChanged: (value) {
            setState(() {
              switchValue = value;
            });
          },
        ),
        const Icon(
          Icons.delete_forever,
        ),
      ],
    );
  }
}

class _PendingActions extends StatefulWidget {
  const _PendingActions();

  @override
  State<_PendingActions> createState() => _PendingActionsState();
}

class _PendingActionsState extends State<_PendingActions> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: switchValue,
          onChanged: (value) {
            setState(() {
              switchValue = value;
            });
          },
        ),
        const Icon(
          Icons.delete_forever,
        ),
      ],
    );
  }
}

class _ActiveActions extends StatefulWidget {
  const _ActiveActions();

  @override
  State<_ActiveActions> createState() => _ActiveActionsState();
}

class _ActiveActionsState extends State<_ActiveActions> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: switchValue,
          onChanged: (value) {
            setState(() {
              switchValue = value;
            });
          },
        ),
      ],
    );
  }
}
