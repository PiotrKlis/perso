import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/widgets/perso_app_bar.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:flutter/material.dart';
import 'package:Perso/app/widgets/spoken_language_row.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PersoColors.lightBlue,
      appBar: PersoAppBar(
        title: "Search filter",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Spoken languages",
            style: TextStyle(
              fontSize: 17,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.4,
            ),
          ),

          Text(
            "Location",
            style: TextStyle(
              fontSize: 17,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.4,
            ),
          ),
          
           Row(
            children: <Widget>[
          Expanded(child: Text(
            "Rating",
            style: TextStyle(
              fontSize: 17,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.4,
            ),
          )),
         Expanded( child: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 0), itemSize: 30,
              itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
              onRatingUpdate: (rating) {
                print(rating);
              }))]),
          PersoButton(title: "Apply Filtres")
        ]
      ),
    );
  }
}
