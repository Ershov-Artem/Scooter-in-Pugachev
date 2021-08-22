import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/widgets.dart';

class TimerForm extends StatefulWidget {
  @override
  _TimerFormState createState() => _TimerFormState();
}

class _TimerFormState extends State<TimerForm> {
  Timer _timer;
  int _start = 0;
  bool _isStoped = false;

  void startTimer() {
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

  String _startToTimeString(start) {
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
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              _startToTimeString(_start),
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
              size: 60,
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
  }
}
