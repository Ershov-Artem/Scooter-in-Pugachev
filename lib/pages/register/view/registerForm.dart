import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class RegForm extends StatefulWidget {
  @override
  _RegFormState createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
  String _phoneNumber;
  final formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text(
            "Для регистрации введите свой номер телефона",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
        ),
        Container(
            width: 200,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Text("+7"), flex: 2),
                  Expanded(
                      flex: 15,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _controller,
                        key: formKey,
                        onChanged: (newValue) {
                          print(_controller.text);
                          _phoneNumber = newValue;
                        },
                        inputFormatters: [
                          MaskedInputFormater("(000) 000-00-00")
                        ],
                      ))
                ]))
      ],
    );
  }
}
