import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '../../custom_code/widgets/permissions.dart';
import 'login_model.dart';
import '/appwrite_interface.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_svg/flutter_svg.dart';
import '../../custom_code/widgets/toast.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '../menu.dart';
import '../appwrite_interface.dart';
import '../localDB.dart';
import '../../session_display/session_display_widget.dart';
import '../../profile_page/profile_page_widget.dart';
// import '../../map_display/map_display_widget.dart';
import '../../change_password/change_password_widget.dart';
// import '../../paypal/paypal_widget.dart';
import '../../help/help_widget.dart';
// import '../../purchase/purchase_widget.dart';
// import '../../purchase2/purchase2_widget.dart';
import '../../conditional.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import '../../platform/audio_recorder_platform.dart';
import '../../create_account/create_account_widget.dart';
// import '../../chapter_read/chapter_read_widget.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;
import '../purchase3.dart';

export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UsersRecord? user;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());
    _model.emailAddressController ??= TextEditingController();
    _model.passwordController ??= TextEditingController();
    if (kIsWeb) {
      listenForMessage();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    MenuDetails loginMenuDetails = MenuDetails(menuLabelList: [
      'AIRs',
      'Profile',
      'Upgrade',
      // '2Puchase',
      //'3Puchase',

      'Help',
    ], menuIconList: [
      kIconHyperbooks,
      kIconProfile,
      kIconUpgrade,
      // kIconOpenBook,
      //kIconInfoStart,
      kIconHyperbookMap,

      // kIconChooseChapterState,
    ], menuColorList: [
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
      //kDefaultColor,
      // kDefaultColor,
      kDefaultColor,
    ], menuTargets: [
      (context) async {
        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: SessionDisplayWidget(),
            ));
      },
      (context) {
        // context.goNamedAuth('profilePage', context.mounted);
        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: ProfilePageWidget(),
            ));
      },
      // (context) async {
        // context.goNamedAuth('profilePage', context.mounted);
        // print('<ME100>');
        /*await initPlatformState();
        await showCustomerInfo();
        await getPackages();
        await presentPaywall();*/
      // },
      // (context) {
      //   // context.goNamedAuth('profilePage', context.mounted);
      //   Navigator.push(
      //       context,
      //       PageTransition(
      //         type: kStandardPageTransitionType,
      //         duration: kStandardTransitionTime,
      //         reverseDuration: kStandardReverseTransitionTime,
      //         child: Purchase2Widget(),
      //       ));
      // },
      (context) {
        // context.goNamedAuth('profilePage', context.mounted);
        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: Purchase3(),
            ));
      },
      (context) {
        // context.goNamedAuth('profilePage', context.mounted);
        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: HelpWidget(),
            ));
      },
    ]);
    bool isSupervisor = false;
    if ((currentUser != null) && (currentUser!.role == kRoleSupervisor)) {
      isSupervisor = true;
    }
    print('(FX3)${currentUser}');
    return Title(
        title: 'login',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 1.0,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        FlutterFlowTheme.of(context).primary,
                        FlutterFlowTheme.of(context).secondary
                      ],
                      stops: const <double>[0.0, 1.0],
                      begin: const AlignmentDirectional(0.0, -1.0),
                      end: const AlignmentDirectional(0, 1.0),
                    ),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.95,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      /* border: Border.all(
                                        color: Colors.red,
                                      ),*/
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green,
                                    ),
                                    child: FittedBox(
                                      child: SvgPicture.asset(
                                        'assets/images/paintbrush2.svg',
                                        width: logoSize,
                                        height: logoSize,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Container(width: 50)),
                                  Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                'AIR Studio',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .override(
                                                          fontFamily: 'Rubik',
                                                          color: Colors.white,
                                                          fontSize: 44.0,
                                                        ),
                                                overflow: TextOverflow.fade,
                                                //   style: FlutterFlowTheme.of(context)
                                                //      .headlineMedium,),
                                              ))),
                                      insertMenu(
                                          width: 100,
                                          height: 50,
                                          context: context,
                                          menuDetails: loginMenuDetails,
                                          externalSetState: setState,
                                          caption: 'Menu'),
                                    ],
                                  ),
                                ])),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 36.0, 0.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 20.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 10.0),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 3.0, 0.0, 0.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 16.0, 20.0, 0.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'Login or Create Account',
                                            style: (MediaQuery.sizeOf(context)
                                                        .width >
                                                    2000)
                                                ? FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                : FlutterFlowTheme.of(context)
                                                    .bodyLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height:20),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 10.0, 20.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                _model.emailAddressController,
                                            decoration: InputDecoration(
                                              labelText: 'Email Address',
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color:
                                                        const Color(0xFF95A1AC),
                                                  ),
                                              hintText:
                                                  'Enter your email here...',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color:
                                                        const Color(0xFF95A1AC),
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFDBE2E7),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .white,
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 24.0, 16.0, 0.0),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Rubik',
                                                  color:
                                                      const Color(0xFF2B343A),
                                                ),
                                            validator: _model
                                                .emailAddressControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 16.0, 20.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                _model.passwordController,
                                            obscureText:
                                                !_model.passwordVisibility,
                                            decoration: InputDecoration(
                                              labelText: 'Password',
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color:
                                                        const Color(0xFF95A1AC),
                                                  ),
                                              hintText:
                                                  'Enter your password here...',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color:
                                                        const Color(0xFF95A1AC),
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFDBE2E7),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .white,
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 24.0, 16.0, 0.0),
                                              suffixIcon: InkWell(
                                                onTap: () => setState(
                                                  () => _model
                                                          .passwordVisibility =
                                                      !_model
                                                          .passwordVisibility,
                                                ),
                                                focusNode: FocusNode(
                                                    skipTraversal: true),
                                                child: Icon(
                                                  _model.passwordVisibility
                                                      ? Icons
                                                          .visibility_outlined
                                                      : Icons
                                                          .visibility_off_outlined,
                                                  color:
                                                      const Color(0xFF95A1AC),
                                                  size: 22.0,
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Rubik',
                                                  color:
                                                      const Color(0xFF2B343A),
                                                ),
                                            validator: _model
                                                .passwordControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        FFButtonWidget(
                                          tooltipMessage:
                                              'Click to change password',
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        kStandardPageTransitionType,
                                                    duration:
                                                        kStandardTransitionTime,
                                                    reverseDuration:
                                                        kStandardReverseTransitionTime,
                                                    child:
                                                        ChangePasswordWidget()));
                                            //context.pushNamed('changePassword');
                                          },
                                          text: 'Forgot Password?',
                                          options: FFButtonOptions(
                                            width: 170.0,
                                            height: (MediaQuery.sizeOf(context)
                                                        .width <
                                                    kPhonewWidthThreashold)
                                                ? 20.0
                                                : 40.0,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .white,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Rubik',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            // //>print('(N230-1)${currentReadReferences.length}');

                                            GoRouter.of(context)
                                                .prepareAuthEvent();
                                            // //>print('(N230-2)${currentReadReferences.length}');
                                            // BaseAuthUser? user =
                                            //     await authManager.signInWithEmail(
                                            //   context,
                                            //   _model.emailAddressController.text,
                                            //   _model.passwordController.text,
                                            // );
                                            String e = _model
                                                .emailAddressController.text;

                                            if ((e.length == 2) &&
                                                (e[0] == '#')) {
                                              if (e[1] == 'r') {
                                                _model.emailAddressController
                                                        .text =
                                                    'richard@hyperbook.co.uk';
                                              } else {
                                                if (e[1] == 's') {
                                                  _model.emailAddressController
                                                          .text =
                                                      'scafflife73@gmail.com';
                                                } else {
                                                  if (e[1] == 'd') {
                                                    _model.emailAddressController
                                                            .text =
                                                        'richard.dennis.spencer@gmail.com';
                                                  } else {
                                                    _model.emailAddressController
                                                            .text =
                                                        '${e[1]}@${e[1]}.com';
                                                  }
                                                }
                                              }
                                              _model.passwordController.text =
                                                  'aaaaaaaa';
                                            } else {
                                              if (e.length == 0) {
                                                _model.emailAddressController
                                                    .text = 't@t.com';
                                                _model.passwordController.text =
                                                    'aaaaaaaa';
                                              }
                                            }
                                            models.User? appwriteUser;
                                            print(
                                                '(N91-A)${_model.emailAddressController.text}++++${_model.passwordController.text}');
                                            try {
                                              user = await appwriteLogin(
                                                context,
                                                _model.emailAddressController
                                                    .text,
                                                _model.passwordController.text,
                                              );
                                            } on AppwriteException catch (e) {
                                              print(
                                                  '(N91-B)${e.type}****${e.message}');
                                              //   toast(context, 'Login failure: ${e.message}', ToastKind.error);
                                            }
                                            // currentUser =
                                            // await getUser(document: user!.reference);
                                            print(
                                                '(N91-C)${user}....${loggedInUser}%%%%${_model.emailAddressController.text}++++${_model.passwordController.text}');
                                            // //>print('(N230-3B)${loggedInUser!.email}');
                                            print(
                                                '(N91-D)${user!.reference!.path}');
                                            print(
                                                '(N91-E)${user!.displayName}****${currentUser!.displayName}');

                                            /*         await actions.setupUserOnLogin(
                                              context,
                                              (currentUserDocument?.chapterColorsInts
                                                          .toList() ??
                                                      <int>[])
                                                  .toList(),
                                            );*/
                                            loggedIn = true;
                                            tempDirPath =
                                                (await getTemporaryDirectory())
                                                    .path;
                                            String appDirPathParent =
                                                (await getApplicationSupportDirectory())
                                                    .path;
                                            appDirPath = (await Directory(
                                                        appDirPathParent +
                                                            '/airStudio')
                                                    .create(recursive: true))
                                                .path;
                                            print(
                                                '(TD1)${tempDirPath}....${appDirPath}');
                                            await printTempDirListing();
                                            await printAppDirListing();

                                            //#hyperbookCacheValid = false;
                                            //# coonectedUsersCacheValid = false;

                                            /*#await loadCachedHyperbookLists(
                                                DocumentReference(
                                                    path: loggedInUser!
                                                        .$id));*/
                                            // await setCurrentReadReferences();
                                            print(
                                                '(N230-7)${currentUser!.email}****${DocumentReference(path: '')}////');

                                            /*        models.DocumentList connctedUserList =
                                                await listDocumentsWithOneQueryString(
                                              collection: connectedUsersRef,
                                              attribute: 'status',
                                              value:'Editor',
                                                      // _model.emailAddressController.text,
                                              // attribute2: 'user',
                                              // value2: DocumentReference(path: ''),
                                            );*/
                                            permissionHandler.Permission
                                                permission = permissionHandler
                                                    .Permission.microphone;
                                            permissionHandler.PermissionStatus
                                                status =
                                                await permission.request();
                                            if (status.isGranted) {
                                              // toast(context, 'Mic OK', ToastKind.success);
                                            } else {
                                              toast(
                                                  context,
                                                  'Mic not available',
                                                  ToastKind.warning);
                                            }
                                            logoSize = (MediaQuery.sizeOf(context).width < 1000) ? 50 : 100;
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                  type:
                                                      kStandardPageTransitionType,
                                                  duration:
                                                      kStandardTransitionTime,
                                                  reverseDuration:
                                                      kStandardReverseTransitionTime,
                                                  child: SessionDisplayWidget(),
                                                ));
                                          },
                                          text: 'Login',
                                          options: FFButtonOptions(
                                            width: 120.0,
                                            height: 52.0,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                            elevation: 4.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(26.0),
                                          ),
                                        ),

                                        /*
                                        FFButtonWidget(
                                          onPressed: () async {

                                            authManager.signOut();
                                          },
                                          text: 'Logout',
                                          options: FFButtonOptions(
                                            width: 130.0,
                                            height: 50.0,
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                            color:
                                            FlutterFlowTheme.of(context).primary,
                                            textStyle: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                              fontFamily: 'Rubik',
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            elevation: 2.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                        ),

                                  */
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 2.0,
                                    thickness: 2.0,
                                    indent: 20.0,
                                    endIndent: 20.0,
                                    color: Color(0xFFDBE2E7),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          // width: 40,
                                          // height: 40,
                                          child: FlutterFlowIconButton(
                                            //enabled: (currentUser != null),
                                            caption: 'Profile',
                                            fillColor: Colors.white,
                                            tooltipMessage: 'Change profile',
                                            // borderColor: FlutterFlowTheme.of(context)
                                            //   .primary,

                                            borderColor: Colors.transparent,
                                            borderRadius: 20.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            buttonWidth: kIconButtonWidth - 50,
                                            icon: kIconProfile,
                                            onPressed: () {
                                              // context.goNamedAuth('profilePage',
                                              //     context.mounted);
                                              if (currentUser != null) {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type:
                                                      kStandardPageTransitionType,
                                                      duration:
                                                      kStandardTransitionTime,
                                                      reverseDuration:
                                                      kStandardReverseTransitionTime,
                                                      child: ProfilePageWidget(),
                                                    ));
                                              } else {
                                                toast(context, 'please login or create account', ToastKind.warning);
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 12.0, 0.0, 12.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                  type:
                                                      kStandardPageTransitionType,
                                                  duration:
                                                      kStandardTransitionTime,
                                                  reverseDuration:
                                                      kStandardReverseTransitionTime,
                                                  child: CreateAccountWidget(),
                                                ));
                                          },
                                          text: 'Create Account',
                                          options: FFButtonOptions(
                                            width: 170.0,
                                            height: 40.0,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .white,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Rubik',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      /*FlutterFlowIconButton(
                                          caption: 'Upgrade to Pro',
                                          enabled: true,
                                          fillColor: Colors.white,
                                          tooltipMessage: 'Upgrade to Pro',
                                          borderColor: FlutterFlowTheme.of(context).primary,
                                          borderRadius: 30,
                                          borderWidth: 1,
                                          buttonSize: 40,
                                          icon: Icon(Icons.upgrade),
                                          onPressed: () async {
                                            await initPlatformState();
                                            await showCustomerInfo();
                                            await getPackages();
                                            await presentPaywall();
                                          }),
                                      SizedBox(width: kIconButtonGap),*/
                                      isSupervisor
                                          ? FlutterFlowIconButton(
                                              enabled: true,
                                              fillColor: Colors.white,
                                              tooltipMessage: 'Delete AIRs',
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 40,
                                              icon: kIconDelete,
                                              onPressed: () {
                                                showDialog<bool>(
                                                    context: context,
                                                    builder: (BuildContext
                                                        alertDialogContext) {
                                                      return AlertDialog(
                                                          title: const Text(
                                                              'Delete AIRs?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    alertDialogContext,
                                                                    false);
                                                              },
                                                              child: const Text(
                                                                  'Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                await emptyAppDir();
                                                                List<SessionsRecord>
                                                                    sessions =
                                                                    await listSessionList(
                                                                        justCurrentUserAsTherapist:
                                                                            false);
                                                                for (int i = 0;
                                                                    i <
                                                                        sessions
                                                                            .length;
                                                                    i++) {
                                                                  List<SessionStepsRecord>
                                                                      sessionsSteps =
                                                                      await listSessionStepList(
                                                                          thisSessionIndex: i);
                                                                  for (int j =
                                                                          0;
                                                                      j <
                                                                          sessionsSteps
                                                                              .length;
                                                                      j++) {
                                                                    await deleteDocument(
                                                                        collection:
                                                                            sessionStepsRef,
                                                                        document:
                                                                            sessionsSteps[j].reference);
                                                                    await deleteDocument(
                                                                        collection:
                                                                            sessionsRef,
                                                                        document:
                                                                            sessions[i].reference);
                                                                  }
                                                                }
                                                                models.FileList
                                                                    fileList =
                                                                    await listStorageFiles(
                                                                        bucketId:
                                                                            airsRef.path);
                                                                if (fileList
                                                                        .files
                                                                        .length >
                                                                    0) {
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          fileList
                                                                              .files
                                                                              .length;
                                                                      i++) {
                                                                    print(
                                                                        '(DF1)${fileList.files[i].$id}');

                                                                    await storage.deleteFile(
                                                                        bucketId:
                                                                            airsRef
                                                                                .path!,
                                                                        fileId: fileList
                                                                            .files[i]
                                                                            .$id);
                                                                  }
                                                                }
                                                                print('(DD1)');
                                                                await printAppDirListing();
                                                              },
                                                              child: const Text(
                                                                  'Confirm'),
                                                            ),
                                                          ]);
                                                    });
                                              })
                                          : Container(),
                                    ],
                                  ),
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(0.95, 0.0),
                                    child: Text(
                                      '\u00a92026 Hyperbook Ltd.    ${versionNumber.toString()}  ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w100,
                                            fontSize: 15,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        /*
                        const SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: custom_widgets.SetIntroductionHyperbook(
                            width: 20.0,
                            height: 20.0,
                          ),
                        ),*/

                        SizedBox(height: 50),
                        // PaywallScreen(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

/*


*/
