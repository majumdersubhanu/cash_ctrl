import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:upi_india/upi_india.dart';

import '../../core/extensions.dart';
import 'transaction_details_controller.dart';

extension TextCapitalization on String {
  get capitalizeFirstOfEach =>
      split(" ").map((e) => e.capitalizeFirst).join(" ");
}

class TransactionDetailsView extends GetView<TransactionDetailsController> {
  const TransactionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments ?? {};
    FormGroup formGroup = FormGroup(
      arguments.map(
        (key, value) => MapEntry(
          key,
          FormControl<String>(value: value?.toString() ?? ""),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        primary: true,
        child: ReactiveForm(
          formGroup: formGroup,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.down,
            textDirection: TextDirection.ltr,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(
                'Details',
                style: context.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10),
              ...arguments.keys.map((key) {
                return Column(
                  children: [
                    const Gap(20),
                    ReactiveTextField<String>(
                      formControlName: key,
                      decoration: InputDecoration(
                        labelText: key.capitalizeFirstOfEach,
                        hintText: 'Enter $key',
                        icon: const Icon(Icons.text_fields),
                      ),
                    ),
                  ],
                );
              }),
              const Gap(40),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      am: formGroup.value['am'].toString(),
                      pa: formGroup.value['pa'].toString(),
                      pn: formGroup.value['pn'].toString(),
                      tn: formGroup.value['tn'].toString(),
                    ),
                  ),
                ),
                child: const Text('Confirm Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String pa, pn, am, tn;

  const HomePage(
      {super.key,
      required this.pa,
      required this.pn,
      required this.am,
      required this.tn});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: widget.pa,
      receiverName: widget.pn,
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: widget.tn,
      amount: double.tryParse(widget.am) ?? 0.0,
    );
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (apps!.isEmpty)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
            body,
            style: value,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: displayUpiApps(),
          ),
          Expanded(
            child: FutureBuilder(
              future: _transaction,
              builder:
                  (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        _upiErrorHandler(snapshot.error.runtimeType),
                        style: header,
                      ),
                    );
                  }

                  UpiResponse upiResponse = snapshot.data!;

                  String txnId = upiResponse.transactionId ?? 'N/A';
                  String resCode = upiResponse.responseCode ?? 'N/A';
                  String txnRef = upiResponse.transactionRefId ?? 'N/A';
                  String status = upiResponse.status ?? 'N/A';
                  String approvalRef = upiResponse.approvalRefNo ?? 'N/A';
                  _checkTxnStatus(status);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        displayTransactionData('Transaction Id', txnId),
                        displayTransactionData('Response Code', resCode),
                        displayTransactionData('Reference Id', txnRef),
                        displayTransactionData('Status', status.toUpperCase()),
                        displayTransactionData('Approval No', approvalRef),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(''),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
