import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PlanOverviewScreen extends StatelessWidget {
  const PlanOverviewScreen({required this.clientId, super.key});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersoAppBar(
        title: 'Plan overview',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfDateRangePicker(
              showNavigationArrow: true,
              // onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              //   print(args.value);
              // },
            ),
            ColoredBox(
              color: PersoColors.lightBlue,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: Dimens.smallMargin,
                      right: Dimens.smallMargin,
                      top: Dimens.smallMargin,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Exercises',
                          style: ThemeText.largeTitleBold,
                        ),
                        const PersoButton(
                          title: 'Add',
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return const ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('Exercise name'),
                        subtitle: Text('Exercise description'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
