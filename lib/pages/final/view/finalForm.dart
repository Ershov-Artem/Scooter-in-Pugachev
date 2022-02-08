import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';
import 'package:scooter_pugachev/pages/final/request/cubit/cubit.dart';
import 'package:scooter_pugachev/pages/final/request/entities/entities.dart';
import 'package:scooter_pugachev/pages/reg&confirm/register/widgets/regButton.dart';

class FinalForm extends StatefulWidget {
  int minutes;
  FinalForm(this.minutes);

  @override
  _FinalFormState createState() => _FinalFormState(minutes);
}

class _FinalFormState extends State<FinalForm> {
  int minutes;

  _FinalFormState(this.minutes);

  FinalPayBloc _bloc;
  FinalPayResponse _response;

  final List<PaymentItem> _paymentItems = [];

  void countOfMinutes(int minutes) {
    int i;
    for (i = 0; i < minutes; i++) {
      _paymentItems.add(PaymentItem(
        label: "Total",
        amount: "7.0",
        type: PaymentItemType.item,
        status: PaymentItemStatus.unknown,
      ));
    }
    print("countOfMinutes...${i}");
  }

  @override
  void initState() {
    countOfMinutes(minutes);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    _bloc = BlocProvider.of<FinalPayBloc>(context);
    super.didChangeDependencies();
  }

  void onGooglePayResult(paymentResult) async {
    print("inside ogpr");
    print(paymentResult.runtimeType);
    print("something goes");
    print(paymentResult['paymentMethodData']['tokenizationData']['token']);
    print(paymentResult['paymentMethodData']['tokenizationData']['token']
        .runtimeType);
    _response = await _bloc.postFinalPayToken(
        paymentResult['paymentMethodData']['tokenizationData']['token']);
    print("request goes");
  }

  @override
  Widget build(BuildContext context) => BlocConsumer(
      bloc: _bloc,
      listener: (context, state) async {},
      builder: (context, state) {
        if (state == FinalPayStatus.initial) {
          print("on GPay");
          return Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.electric_scooter_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 100,
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 60, top: 60),
                      width: 275,
                      child: Text(
                        ".",
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      )),
                  ApplePayButton(
                    paymentConfigurationAsset: 'applepay.json',
                    paymentItems: _paymentItems,
                    height: 75,
                    width: 275,
                    style: ApplePayButtonStyle.black,
                    type: ApplePayButtonType.buy,
                    margin: const EdgeInsets.only(top: 15.0),
                    onPaymentResult: (data) {
                      print(data);
                    },
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  GooglePayButton(
                    height: 75,
                    width: 275,
                    paymentConfigurationAsset: 'gpay.json',
                    paymentItems: _paymentItems,
                    style: GooglePayButtonStyle.black,
                    type: GooglePayButtonType.pay,
                    margin: const EdgeInsets.only(top: 15.0),
                    onPaymentResult: onGooglePayResult,
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ));
        } else if (state == FinalPayStatus.loading) {
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
        } else if (state == FinalPayStatus.ok) {
          print("goto TimerPage");
          return Container();
        } else {
          return Align(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Произошла ошибка ${_response.error}"),
                    RegButton(
                        onTap: () {
                          Navigator.pushNamed(context, "/finalPay");
                        },
                        height: 55,
                        width: 230,
                        text: "Попробовать снова",
                        decoration: BoxDecoration(
                            color: Color(0xff8ebbff),
                            borderRadius: BorderRadius.circular(10)))
                  ]));
        }
      });
}
