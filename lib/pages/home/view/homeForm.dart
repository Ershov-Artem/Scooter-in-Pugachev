import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:scooter_pugachev/pages/home/request/cubit/cubit.dart';
import 'package:scooter_pugachev/pages/home/request/entities/entities.dart';
import 'package:scooter_pugachev/pages/reg&confirm/register/register.dart';

import '../widgets/customButton.dart';

class HomeForm extends StatefulWidget {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('wss://scoots.herokuapp.com/coordinates');
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  CheckUserCubit _cubit;
  CheckUserResponse _response;

  var zoom = 13.0;

  List<Marker> _markers = [];

  @override
  void didChangeDependencies() async {
    _cubit = BlocProvider.of<CheckUserCubit>(context);

    _response = await _cubit.checkUser();

    super.didChangeDependencies();
  }

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
            return StreamBuilder(
                stream: widget.channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _markers.add(
                      Marker(
                        point: LatLng(
                            double.parse(snapshot.data['coordinate']['x']),
                            double.parse(snapshot.data['coordinate']['y'])),
                        builder: (context) => Container(
                          child: Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                            size: 25,
                          ),
                        ),
                      ),
                    );
                  }
                  return Stack(
                    children: [_buildMap(), _buildCustimButton()],
                  );
                });
          } else if (state == CheckStatus.need_login) {
            return RegForm();
          } else {
            return Container(
                child: Center(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Error occured ${_response.error}"),
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

  Widget _buildCustimButton() => Padding(
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
      ));
}
