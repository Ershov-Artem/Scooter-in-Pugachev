import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pay/pay.dart';
import 'package:scooter_pugachev/pages/pay/request/entities/entities.dart';
import 'package:scooter_pugachev/pages/reg&confirm/register/widgets/regButton.dart';
import '../request/cubit/cubit.dart';
import 'package:scooter_pugachev/pages/timer/timer.dart';

class PayForm extends StatefulWidget {
  @override
  _PayFormState createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  int deposit = 500;
  int price = 7;
  PayBloc _bloc;
  PayResponse _response;

  final List<PaymentItem> _paymentItems = [
    PaymentItem(
      label: "Total",
      amount: "500.0",
      type: PaymentItemType.total,
      status: PaymentItemStatus.final_price,
    ),
  ];

  //Pay _payClient = Pay.withAssets(['gpay.json', 'applepay.json']);

  @override
  void didChangeDependencies() async {
    _bloc = BlocProvider.of<PayBloc>(context);
    super.didChangeDependencies();
  }

  void onGooglePayResult(paymentResult) async {
    print("inside ogpr");
    print(paymentResult.runtimeType);
    print("something goes");
    print(paymentResult['paymentMethodData']['tokenizationData']['token']);
    print(paymentResult['paymentMethodData']['tokenizationData']['token']
        .runtimeType);
    _response = await _bloc.postPayToken(
        paymentResult['paymentMethodData']['tokenizationData']['token'], 2);
    print("request goes");
  }

  @override
  Widget build(BuildContext context) => BlocConsumer(
      bloc: _bloc,
      listener: (context, state) async {},
      builder: (context, state) {
        if (state == PayStatus.initial) {
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
                        "???? ?????????? ?????????????? ?? ?????? ???????????????? ?????????? $deposit ????????????, ?????????????? ???????????????? ???? ?????????????????? ??????????????. ???????????? ???????????? ?????????????? ?????????? ???????????? $price ????????????.",
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
        } else if (state == PayStatus.loading) {
          return Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "??????????????????, ????????????????",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Color(0xff8ebbff),
                  )
                ],
              ));
        } else if (state == PayStatus.ok) {
          print("goto TimerPage");
          return TimerPage(null);
        } else {
          return Align(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("?????????????????? ???????????? ${_response.error}"),
                    RegButton(
                        onTap: () {
                          Navigator.pushNamed(context, "/pay");
                        },
                        height: 55,
                        width: 230,
                        text: "?????????????????????? ??????????",
                        decoration: BoxDecoration(
                            color: Color(0xff8ebbff),
                            borderRadius: BorderRadius.circular(10)))
                  ]));
        }
      });
}
