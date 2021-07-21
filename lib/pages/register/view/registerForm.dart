import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:scooter_pugachev/pages/register/widgets/regButton.dart';

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
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Введите свой номер телефона",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.symmetric(vertical: 100),
            ),
            Container(
                width: 300,
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            height: 44,
                            decoration: new BoxDecoration(
                                color: Color(0xffcbe0ff),
                                borderRadius: BorderRadius.circular(10)),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "+7",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                )),
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                          flex: 15,
                          child: Container(
                              height: 44,
                              decoration: new BoxDecoration(
                                  color: Color(0xfff0f0f0),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
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
                                  ))))
                    ])),
            Container(
              height: 200,
            ),
            RegButton(
                onTap: () => {},
                height: 55,
                width: 230,
                text: "Далее",
                decoration: BoxDecoration(
                    color: Color(0xff8ebbff),
                    borderRadius: BorderRadius.circular(10)))
          ],
        ));
  }
}
