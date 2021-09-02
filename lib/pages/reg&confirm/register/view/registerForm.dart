import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:scooter_pugachev/pages/reg&confirm/regConfirm/confirm.dart';
import 'package:scooter_pugachev/pages/reg&confirm/request/cubit/cubit.dart';
import 'package:scooter_pugachev/pages/reg&confirm/request/entities/entities.dart';

import '../widgets/regButton.dart';

class RegForm extends StatefulWidget {
  @override
  _RegFormState createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
  PostUserBloc _bloc;
  PostUserResponse _response;
  String _phoneNumber;
  final formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    _bloc = BlocProvider.of<PostUserBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer(
      bloc: _bloc,
      listener: (context, state) async {},
      builder: (context, state) {
        if (state == UserStatus.initial) {
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          textAlign: TextAlign.center,
                                          controller: _controller,
                                          key: formKey,
                                          onChanged: (newValue) {
                                            print(_controller.text);
                                            _phoneNumber = newValue;
                                          },
                                          inputFormatters: [
                                            MaskedInputFormater(
                                                "(000) 000-00-00")
                                          ],
                                        ))))
                          ])),
                  Container(
                    height: 200,
                  ),
                  RegButton(
                      onTap: () async {
                        _phoneNumber = _phoneNumber.replaceAll('(', '');
                        _phoneNumber = _phoneNumber.replaceAll(')', '');
                        _phoneNumber = _phoneNumber.replaceAll('-', '');
                        _phoneNumber = _phoneNumber.replaceAll(' ', '');
                        _phoneNumber = "7" + _phoneNumber;
                        print(_phoneNumber);
                        _response = await _bloc.regUser(_phoneNumber, "");
                      },
                      height: 55,
                      width: 230,
                      text: "Далее",
                      decoration: BoxDecoration(
                          color: Color(0xff8ebbff),
                          borderRadius: BorderRadius.circular(10)))
                ],
              ));
        } else if (state == UserStatus.loading) {
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
        } else if (state == UserStatus.ok) {
          return ConfirmPage(_phoneNumber);
        } else {
          return Container(
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Произошла ошибка ${_response.error}"),
                        RegButton(
                            onTap: () => state = UserStatus.initial,
                            height: 55,
                            width: 230,
                            text: "Попробовать снова",
                            decoration: BoxDecoration(
                                color: Color(0xff8ebbff),
                                borderRadius: BorderRadius.circular(10)))
                      ])));
        }
      });
}
