import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:scooter_pugachev/pages/reg&confirm/register/widgets/regButton.dart';
import 'package:scooter_pugachev/pages/reg&confirm/request/cubit/cubit.dart';
import 'package:scooter_pugachev/pages/reg&confirm/request/entities/entities.dart';

class ConfirmForm extends StatefulWidget {
  //const ConfirmForm({ Key? key }) : super(key: key);

  @override
  _ConfirmFormState createState() => _ConfirmFormState();
}

class _ConfirmFormState extends State<ConfirmForm> {
  PostUserBloc _bloc;
  ConfirmCodeResponse _response;
  String _code;
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
                Text(
                  "Введите код из СМС",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  width: 275,
                  child: new Text(
                    "На указанный номер был отправлен код подтверждения",
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(height: 50),
                Container(
                    width: 275,
                    height: 60,
                    decoration: new BoxDecoration(
                        color: Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.center,
                          inputFormatters: [MaskedInputFormater("0 0 0 0")],
                          onChanged: (newValue) {
                            print(_controller.text);
                            _code = newValue;
                            print(_code);
                            request(_code);
                          },
                        )))
              ],
            ),
          );
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
          print("all ok, I can't believe");
          return Align(alignment: Alignment.center, child: Text("okokokok"));
        } else {
          return Align(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Произошла ошибка ${_response.error}"),
                    RegButton(
                        onTap: () => Navigator.pushNamed(context, '/reg'),
                        height: 55,
                        width: 230,
                        text: "Попробовать снова",
                        decoration: BoxDecoration(
                            color: Color(0xff8ebbff),
                            borderRadius: BorderRadius.circular(10)))
                  ]));
        }
      });
  void request(String str) async {
    if (str.length == 7) {
      str = str.replaceAll(" ", "");
      var _val = int.parse(str);
      print(_val);
      _response = await _bloc.confUser(_val);
    }
  }
}
