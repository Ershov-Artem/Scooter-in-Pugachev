import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../request/cubit/cubit.dart';
import '../widgets/widgets.dart';

class TimerForm extends StatefulWidget {
  final String startedAt;

  TimerForm(this.startedAt);
  @override
  _TimerFormState createState() => _TimerFormState(startedAt);
}

class _TimerFormState extends State<TimerForm> {
  PhotoCubit _cubit;
  Timer _timer;
  bool _isStoped = false;
  final String startedAt;

  _TimerFormState(this.startedAt);

  int _timeToInt(String _time) {
    if (_time == null) {
      return 0;
    } else {
      DateTime _now = DateTime.now();
      DateTime _start = DateTime.parse(_time);
      return (((_now.millisecondsSinceEpoch - _start.millisecondsSinceEpoch)
              .toInt()) ~/
          1000);
    }
  }

  void startTimer(int _start) {
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isStoped) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start++;
        });
      }
    });
  }

  String _startToTimeString(int start) {
    int _seconds, _minutes;
    _seconds = start % 60;
    _minutes = ((start - _seconds) / 60).floor();
    String _sec = "$_seconds", _min = "$_minutes";
    if (_seconds < 10) {
      _sec = "0" + _sec;
    }
    if (_minutes < 10) {
      _min = "0" + _min;
    }
    return _min + " : " + _sec;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer(_timeToInt(startedAt));
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    _cubit = BlocProvider.of<PhotoCubit>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer(
      bloc: _cubit,
      listener: (context, state) async {},
      builder: (context, state) {
        if (state == PhotoStatus.initial) {
          print("on TimerPage");
          return Align(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 275,
                padding: EdgeInsets.only(bottom: 50),
                child: Text(
                  "Длительность Вашей поездки",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  width: 275,
                  padding: EdgeInsets.only(bottom: 50),
                  child: Text(
                    _startToTimeString(_timeToInt(startedAt)),
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  )),
              Container(
                  width: 275,
                  padding: EdgeInsets.only(bottom: 100),
                  child: Text(
                    "Перед завершением поездки требуется сфотографировать самокат на фоне окружающей его местности",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  )),
              CustomButton(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile image =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (image == null) return;
                  },
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 50,
                  ),
                  height: 100,
                  width: 100,
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
                      ]))
            ],
          ));
        } else if (state == PhotoStatus.ok) {
          print("all ok");
          return Container();
        } else if (state == PhotoStatus.loading) {
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
        } else {
          print("shit happends");
          return Container();
        }
      });
}
