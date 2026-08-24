import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter_inapp_purchase_plus/flutter_inapp_purchase.dart';
import '../../appwrite_interface.dart';
import 'package:appwrite/models.dart' as models;
import '/flutter_flow/flutter_flow_theme.dart';
import '../localDB.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';

const String kProductIdMonthlyAndroid = 'airstudio';
const String kProductIdMonthlyIOS = 'uk.co.hyperbook.airstudio.monthlysubscription';

class Purchase3 extends StatefulWidget {
  Purchase3({Key? key}) : super(key: key);

  @override
  _Purchase3State createState() => new _Purchase3State();
}

class _Purchase3State extends State<Purchase3> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late dynamic _purchaseUpdatedSubscription;
  late dynamic _purchaseErrorSubscription;
  late dynamic _connectionSubscription;
  String subscriptionRespone = '';
  final List<String> _subscriptionsLists = Platform.isAndroid
      ? [
          kProductIdMonthlyAndroid,
        ]
      : [kProductIdMonthlyIOS];

  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _getSubscription();
  }

  @override
  void dispose() {
    if (_connectionSubscription != null) {
      _connectionSubscription.cancel();
      _connectionSubscription = null;
    }
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // prepare
    String? result = await FlutterInappPurchase.instance.initialize();
    debugPrint('#1result: $result');
    logString('(P3-8A)${result}');
    if ((result?? '').contains('started')){
      await FlutterInappPurchase.instance.finalize();
      String? result = await FlutterInappPurchase.instance.initialize();
      logString('(P3-8B)${result}');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAll() as String;
      debugPrint('#2consumeAllItems: $msg');
      logString('(P3-7)${msg}');
    } catch (err) {
      debugPrint('#3consumeAllItems error: $err');
      logString('(P3-6)${err}');
    }

    _connectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      debugPrint('#4connected: $connected');
      logString('(P3-9)${connected}');
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) async {
      logString('(P3-10)${productItem}');
      try {
        DateTime transDateTime = productItem!.transactionDate?? DateTime(1900);
        String details = '''
          kPurchasesProductId: ${productItem.productId?? '?'},
          kPurchasesEmail: ${currentUser!.email},
          kPurchasesDateTime: ${DateTime.now().toIso8601String()},
          kPurchasesObfuscatedAccountIdAndroid:  ${(currentUser!.email).hashCode.toString()},
          kPurchasesTransactionDate: ${productItem.transactionDate?? '?'},
          kPurchasesTransactionId: ${productItem.transactionId?? '?'},
          kPurchasesPurchaseToken: ${productItem.purchaseToken?? '?'},
          kPurchasesSignatureAndroid: ${productItem.signatureAndroid?? '?'},
          kPurchasesOriginalTransactionDateIOS: ${productItem.originalTransactionDateIOS?? '?'},
          kPurchasesOriginalTransactionIdentifierIOS: ${productItem.originalTransactionIdentifierIOS?? '?'},
          kPurchasesTransactionReceipt: ${productItem.transactionReceipt?? '?'},
          kPurchasesTransactionStateIOS: ${productItem.transactionStateIOS?? '?'},

          ''';

        /* await updateDocument(
              collection: usersRef,
              document: currentUser!.reference,
              data: {
                kUserProductId: productItem.productId,
                kUserApplicationUserName:
                (currentUser!.email).hashCode.toString(),
                kUserPurchaseID: productItem.purchaseToken,
                kUserTransactionDateTime: productItem.transactionDate,
                kUserPurchaseStatus: productItem.purchaseStateAndroid,
              });*/
        String transactionStateIOS = 'unknown';
        if (productItem.transactionStateIOS != null){
          transactionStateIOS = productItem.transactionStateIOS!.name;
        }
        Map<String, String> data =
        {
          kPurchasesProductId: productItem.productId!,
          kPurchasesEmail: currentUser!.email?? '',
          kPurchasesActualDate: DateTime.now().toIso8601String(),
          kPurchasesDetails: details,
          kPurchasesSignatureAndroid: productItem.signatureAndroid?? '?',
          kPurchasesTransactionDate: ((productItem.transactionDate)?? DateTime(1900)).toIso8601String(),
          kPurchasesTransactionId: productItem.transactionId?? '?',
          kPurchasesPurchaseToken: productItem.purchaseToken?? '?',
          kPurchasesOriginalTransactionDateIOS: ((productItem.originalTransactionDateIOS)?? DateTime(1900)).toIso8601String(),
          kPurchasesOriginalTransactionIdentifierIOS: productItem.originalTransactionIdentifierIOS?? '?',
          kPurchasesTransactionReceipt: productItem.transactionReceipt?? '?',
          kPurchasesTransactionStateIOS: transactionStateIOS,

        };
        logString('(P3-1A)${data}');
        await createDocument(
          collection: purchasesRef,
          data: data,
        );
        logString('(P3-1B)${details}');
        setState(() {
          subscriptionRespone = details;
        });
      } catch (e) {
        logString(
            '(P3-2)${currentUser!.email}....${productItem!.transactionDate},,,,${e}');
      }
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      debugPrint('#6purchase-error: $purchaseError');
      logString(
          '(P3-5)${purchaseError}....${(currentUser!.email).hashCode.toString()},,,,${result}');
    });
  }

  void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId!);
  }

  Future<void> _listPurchases() async {
    List<PurchasedItem>? purchases =
        await FlutterInappPurchase.instance.getPurchaseHistory();
    logString('(P3-201)${purchases}');
    logString('(P3-202)${(purchases ?? []).length}');
    if ((purchases ?? []).length > 0) {
      logString('(P3-203)${(purchases!.first).productId}');
    }
  }

  Future<void> _getSubscription() async {
    List<IAPItem> items = await FlutterInappPurchase.instance
        .getSubscriptions(_subscriptionsLists);
    subscriptionRespone = '';
    setState(() {
      for (var item in items) {
        logString('#7B|${item.toString()}');
        _items.add(item);
        subscriptionRespone = subscriptionRespone + item.toString();
      }
      _items = items;
      _purchases = [];
    });
  }

  static const int CHARGE_FULL_PRICE = 5;

  Future _requestSubscription() async {
    final String kProductIdMonthly = Platform.isAndroid ? kProductIdMonthlyAndroid : kProductIdMonthlyIOS;
    try {
      logString(
          '(P3-3A)${(currentUser!.email).hashCode.toString()}....${kProductIdMonthly},,,,${CHARGE_FULL_PRICE}');
      dynamic result = await FlutterInappPurchase.instance.requestSubscription(
        kProductIdMonthly,
        prorationModeAndroid: CHARGE_FULL_PRICE,
        obfuscatedAccountIdAndroid: (currentUser!.email).hashCode.toString(),
      );

      logString(
          '(P3-3B)${(currentUser!.email).hashCode.toString()}....${result}');
    } catch (e) {
      logString(
          '(P3-4)${e}....${(currentUser!.email).hashCode.toString()}....${result}');
    }
  }

  Future _getPurchaseHistory() async {
    List<PurchasedItem>? items =
        await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in items!) {
      debugPrint('#9|${item.toString()}');
      _purchases.add(item);
    }

    setState(() {
      _items = [];
      _purchases = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 20;
    double buttonWidth = (screenWidth / 3) - 20;

    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Air Studio Purchase Subscription',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Rubik',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
        ),
        body: Container(
          width: MediaQuery.sizeOf(context).width * 0.95,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 20),
            FlutterFlowIconButton(
              showLoadingIndicator: false,
              caption: 'Buy Subscription',
              tooltipMessage: '',
              borderColor: Colors.transparent,
              borderRadius: 0.0,
              borderWidth: 1.0,
              buttonSize: 40.0,
              buttonWidth: kSessionIconButtonWidth,
              icon: Icon(Icons.archive_outlined),
              onPressed: () async {
                await _requestSubscription();
              },
            ),
            SizedBox(height: 20),
            FlutterFlowIconButton(
              showLoadingIndicator: false,
              caption: 'Show Subscription',
              tooltipMessage: '',
              borderColor: Colors.transparent,
              borderRadius: 0.0,
              borderWidth: 1.0,
              buttonSize: 40.0,
              buttonWidth: kSessionIconButtonWidth,
              icon: Icon(Icons.list),
              onPressed: () async {
                await _getSubscription();
              },

            ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                      width: screenWidth - 50,
                      child:
                      SingleChildScrollView(
                        child: Text(subscriptionRespone, softWrap: true,),
                      ),

                  ),
                )
          ]),
        ));
  }
}

final DateTime startDate = DateTime.fromMillisecondsSinceEpoch(0);

Future<bool> checkIfCanCreateSession() async {
  bool canCreate = false;
  models.Document infoDoc = await getDocument(
    collection: infoRef,
    document: infoDocumentRef,
  );
  logString('(P3-44)$currentUser}');
  if (currentUser!.cumulativeSessions! <
      (infoDoc.data[kInfoNoOfSessionsFree] as int)) {
    canCreate = true;
  } else {
    DateTime expiryDate =
        ((await latestPurchaseDate(currentUser!)) ?? startDate)
            .add(const Duration(days: 31));
    if ((expiryDate ?? startDate).isAfter(DateTime.now())) {
      if (currentUser!.cumulativeSessions! <
          (infoDoc.data[kInfoNoOfSessionsSubscribed] as int)) {
        canCreate = true;
      }
    }
  }
  logString('(PS-100)${infoDoc}....${canCreate}');
  return canCreate;
}

Future<DateTime?> latestPurchaseDate(UsersRecord user) async {
  models.DocumentList docs = await listDocumentsWithOneQueryString(
    collection: purchasesRef,
    attribute: kPurchasesEmail,
    value: user.email,
  );
  DateTime? latestDate;
  final DateTime startDate = DateTime.fromMillisecondsSinceEpoch(0);
  for (int i = 0; i < docs.total; i++) {
    DateTime? actualDateTime =
    (DateTime.tryParse(docs.documents[i].data[kPurchasesActualDate] as String)) ?? DateTime(1900);
    if (actualDateTime.isAfter(latestDate ?? startDate)) {
      latestDate = actualDateTime;
    }
    logString('(PS-101)${user.email}....${latestDate},,,,${actualDateTime}');
  }
  return latestDate;
}
