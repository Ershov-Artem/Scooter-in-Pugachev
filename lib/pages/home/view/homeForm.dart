import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:scooter_pugachev/pages/home/request/cubit/cubit.dart';
import 'package:scooter_pugachev/pages/home/request/entities/entities.dart';
import 'package:scooter_pugachev/pages/reg&confirm/register/register.dart';

import '../widgets/customButton.dart';

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  CheckUserCubit _cubit;
  CheckUserResponse _response;

  @override
  void didChangeDependencies() async {
    _cubit = BlocProvider.of<CheckUserCubit>(context);

    _response = await _cubit.checkUser();

    super.didChangeDependencies();
  }

  var zoom = 13.0;

  List<Marker> _markers = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckUserCubit, CheckStatus>(
        bloc: _cubit,
        listener: (context, state) async {},
        builder: (context, state) {
          if (state == CheckStatus.loading) {
            return Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Подождите, загрузка",
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Color(0xff8ebbff),
                    )
                  ],
                ));
          } else if (state == CheckStatus.ok) {
            return Stack(
              children: [
                _buildMap(),
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        height: 130,
                        width: 130,
                        onTap: () => Navigator.of(context).pushNamed('/QRScan'),
                        icon: Icon(
                          Icons.qr_code,
                          size: 70,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 10,
                                blurRadius: 10,
                                offset: Offset(0, -2),
                              )
                            ]),
                      ),
                    ))
              ],
            );
          } else if (state == CheckStatus.need_login) {
            return RegForm();
          } else {
            return Container(
                child: Center(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Error occured"),
              ],
            )));
          }
        });
  }

  Widget _buildMap() => FlutterMap(
        options: new MapOptions(
          center: new LatLng(52.016610402762396, 48.80186056209476),
          zoom: zoom,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: _markers,
          )
        ],
      );
}
