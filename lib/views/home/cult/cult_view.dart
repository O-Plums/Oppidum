import 'package:flutter/material.dart';
import 'package:carcassonne/views/widgets/place_card.dart';
import 'package:fluro/fluro.dart';
import 'package:carcassonne/router.dart';
import 'package:carcassonne/views/widgets/loading_widget.dart';
import 'package:carcassonne/models/city_model.dart';
import 'package:provider/provider.dart';
import 'package:carcassonne/net/place_api.dart';

class CultView extends StatefulWidget {
  final bool showReminder;

  CultView({Key key, this.showReminder = false}) : super(key: key);

  @override
  _CultViewState createState() => _CultViewState();
}

class _CultViewState extends State<CultView> {
bool loading = false;
  List<dynamic> _places = [];

void fetchPlace(context) async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    var cityModel = Provider.of<CityModel>(context, listen: false);

    var places = await CarcassonnePlaceApi.getPlaceByType('cult', cityModel.id);
    if (mounted) {
      setState(() {
        _places = places;
        loading = false;
      });
    }
  }

  @override
  void initState() {
    new Future.delayed(Duration.zero, () {
      fetchPlace(context);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
     return SingleChildScrollView(
        child: Column(children: [
        if (loading == true) LoadingAnnimation(),
        if (_places.length == 0 && loading == false) Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 50),
          child: Text('No data')),
      ..._places.map((place) {
      return PlaceCard(
            place: place,
            onPressed: () {
              AppRouter.router.navigateTo(context, 'place',
                  replace: false, transition: TransitionType.inFromRight,
                 routeSettings: RouteSettings(arguments: {
                          'placeId': place['_id'],
                        }),
                   );
            });
      }).toList()
    ]));
  }
}
