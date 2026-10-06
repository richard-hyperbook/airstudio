import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'auth/firebase_auth/auth_util.dart';
// import 'auth/firebase_auth/firebase_user_provider.dart';
// import 'backend/firebase/firebase_config.dart';
// import 'backend/push_notifications/push_notifications_util.dart';
// import 'backend/schema/users_record.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'index.dart';
// import '../../custom_code/widgets/get_hyperbooks.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:scroll_to_hide/scroll_to_hide.dart';
import 'package:flutter/rendering.dart';
import 'app_state.dart';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_functions/cloud_functions.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as models;
import 'appwrite_interface.dart';
// import 'dart:html';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'conditional.dart';
import 'app_state.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as dartio;
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:in_app_purchase_android/billing_client_wrappers.dart';
// import 'package:in_app_purchase_android/in_app_purchase_android.dart';
// import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
// import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:platform/platform.dart';
import 'consumable_store.dart';




appwrite.Client? client;
appwrite.Databases? databases;
String result = 'XXX';
appwrite.RealtimeSubscription? subscription;
List<Map<String, dynamic>> items = [];
String? loadingParameter;

// ScrollController hyperbookDisplayscrollController = ScrollController();


void main() async {
  print('(AAU1)');
  WidgetsFlutterBinding.ensureInitialized();
  print('(AAU2)');
  setIsIncomingResetPassword();
  print('(AAU3)');
  // loadJNI();
  // debugPrintRebuildDirtyWidgets = true;
  // client = appwrite.Client()
  //     .setEndpoint("http://localhost/v1")
  //     .setProject("67cd5b6e000fe41c331e");
  // appwrite.Account account = appwrite.Account(client!);
  showLogoEtcOnMap = true;
  usePathUrlStrategy();
  print('(AAU4)');
  // await initFirebase();
  // dartio.Directory dir = await getApplicationDocumentsDirectory();
  // print('(JN1)${dir.path}');
// initAppwrite();
/*  if (true) {
    // Only for debug mode.
    try {
      final emulatorHost =
          false // defaultTargetPlatform == TargetPlatform.android
              ? "10.0.2.2"
              : "localhost";
      // FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
      // FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8080);
      // FirebaseAuth.instance.useAuthEmulator(emulatorHost, 9099);
      // FirebaseFunctions.instance.useFunctionsEmulator(emulatorHost, 9099);
    } catch (e) {
      // ignore: avoid_print
      //>print('(N4000)$e');
    }
  }*/
  print('(AAU5)');

  // await FlutterFlowTheme.initialize();
  //>print('(SU8)${globalSharedPrefs}');
  print('(AAU6)');

  final FFAppState appState = FFAppState(); // Initialize FFAppState
  // await appState.initializePersistedState();
  print('(AAU7)');

  // await initializePersistedState();
  //>print('(SU6)${globalSharedPrefs}');
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => appState,
    child: MyApp(),
  ));
  print('(AAU8)');

  print('(AAU9)');

}




class MyApp extends StatefulWidget {
  MyApp({super.key});
  appwrite.Account? account;
  models.User? loggedInUser;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  // late Stream<BaseAuthUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;



  Future<void> logout() async {
    await widget.account!.deleteSession(sessionId: 'current');
    setState(() {
      loggedInUser = null;
      currentUser = null;
    });
  }

  @override
  void initState() {
    /*M*/ //>print('(M5)');
    super.initState();
    /*M*/ //>print('(M50)');
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);



    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        /*M*/ //>print('(M55)');
        _appStateNotifier.stopShowingSplashImage();

        /*M*/ //>print('(M56)');
      },
    );
    //>print('(M57)');
  //  setupTutorialUser(context);
    _initAsync();

  }


  Future<void> _initAsync() async {
    await initAppwrite(); // safe: engine already initialized and on UI isolate
    setState(() { /* ready */ });
  }


  @override
  void dispose() {
    // authUserSub.cancel();
    // fcmTokenSub.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;

      });

  @override
  Widget build(BuildContext context) {
    /*M*/ //>//>print('(M3)');
    if(MediaQuery.sizeOf(context).width > 500) {
      basicFontSize = 25;
    } else {
      basicFontSize = 15;
    }
    print('(TH1)');
    return MaterialApp.router(
      title: 'hyperbook',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const <Locale>[
        Locale('en'),
      ],
      theme: ThemeData(
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black)),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'hyperbook_display';
  late Widget? _currentPage;

  bool isNavBarVisible = true;

  @override
  void initState() {
    /*M*/ //>print('(M4)');
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
    //hyperbookDisplayscrollController = ScrollController();
  }

  ScrollController tempScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    /*//>print('(M1A)${hyperbookDisplayscrollController}');
    if(hyperbookDisplayscrollController != null) {
      hyperbookDisplayscrollController!.addListener(() {
        if (hyperbookDisplayscrollController!.hasClients) {
          if (hyperbookDisplayscrollController!.position.userScrollDirection ==
              ScrollDirection.reverse) {
            if (isNavBarVisible)
              setState(() {
                isNavBarVisible = false;
                */ /*M*/ /*
                //>print('(N4001)$isNavBarVisible up');
              });
          }
          if (hyperbookDisplayscrollController!.position.userScrollDirection ==
              ScrollDirection.forward) {
            if (!isNavBarVisible)
              setState(() {
                isNavBarVisible = true;
                */ /*M*/ /*
                //>print('(N4002) $isNavBarVisible down');
              });
          }
        }
    */ /*M*/
    // print(
    //     '(N4000)${isNavBarVisible}????${hyperbookDisplayscrollController!
    //         .hasClients}&&&&${hyperbookDisplayscrollController!.position}');
    // });
    // }
    /*DocumentReference? hyperbook;
    String hyperbookTitle = '';
    DocumentReference? moderator;
    DocumentReference? startChapter;
    //>print('(SU11)${cachedHyperbookList.length}');
    for (int i = 0; i < cachedHyperbookList.length; i++) {
      //>print('(SU12)${cachedHyperbookList[i].hyperbook!.title}');
      if (cachedHyperbookList[i].hyperbook!.title == 'Hyperbook Tutorial') {
        hyperbook = cachedHyperbookList[i].hyperbook!.reference!;
        hyperbookTitle = cachedHyperbookList[i].hyperbook!.title!;
        moderator = cachedHyperbookList[i].hyperbook!.moderator;
        startChapter = cachedHyperbookList[i].hyperbook!.startChapter;
        //>print('(SU13)${cachedHyperbookList[i].hyperbook!.reference!.path}');
        break;
      }
    }*/



    final Map<String, StatefulWidget> tabs = <String, StatefulWidget>{
     /*# 'introduction':  MapDisplayWidget(
        hyperbook: tutorialHyperbook,
        hyperbookTitle: tutorialHyperbookTitle,
        moderator: tutorialModerator,
        startChapter: tutorialStartChapter,
        hyperbookBlurb: tutorialHyperbookBlurb,
      ),*/ //const IntroductionWidget(),
      'introduction': const LoginWidget(),
      'login': const LoginWidget(),
      'profilePage': const ProfilePageWidget(),
      'hyperbook_display':
          const /* GetHyperbooks(), */ SessionDisplayWidget(),
    };
    final int currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    final MediaQueryData queryData = MediaQuery.of(context);
    /*M*/ //>print('(M2)');
    return Scaffold(
      body: MediaQuery(
          data: queryData
              .removeViewInsets(removeBottom: true)
              .removeViewPadding(removeBottom: true),
          child: _currentPage ?? tabs[_currentPageName]!),
      //extendBody: true,
/*     bottomNavigationBar:
          *//*ScrollToHide(
          hideDirection: Axis.vertical,
          scrollController: hyperbookDisplayscrollController,
          height: 60, // The initial height of the widget.
          duration: Duration(
              milliseconds: 300), // Duration of the hide/show animation.
          child:*//*
          FloatingNavbar(
        width: isNavBarVisible ? double.infinity : 60,
        currentIndex: currentIndex,
        onTap: (int i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
        selectedItemColor: FlutterFlowTheme.of(context).warning,
        unselectedItemColor: FlutterFlowTheme.of(context).iconGray,
        selectedBackgroundColor: const Color(0x00000000),
        margin: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        items: <FloatingNavbarItem>[

          FloatingNavbarItem(
            icon: Icons.school,
            title: 'Tutorial',
          ),
          FloatingNavbarItem(icon: Icons.login, title: 'Login'),
          FloatingNavbarItem(
            icon: Icons.person,
            title: 'Profile',
          ),
          FloatingNavbarItem(
            icon: Icons.folder_copy,
            title: 'Hyperbooks',
          )


        ],
      ),*/
      // )
    );
  }
}
