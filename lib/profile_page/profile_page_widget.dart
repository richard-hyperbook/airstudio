import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
import '../appwrite_interface.dart';
import '../edit_profile/edit_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'profile_page_model.dart';
import '../../menu.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';

export 'profile_page_model.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_intro/flutter_intro.dart';
import '../../login/login_widget.dart';
import '../../change_password/change_password_widget.dart';
import '../../edit_profile/edit_profile_model.dart';
import '../../custom_code/widgets/toast.dart';
import '../../session_display/session_display_widget.dart';
import '../../localDB.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late ProfilePageModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
/*  Intro? intro;
  _ProfilePageWidgetState() {
    //%//>print('(XI3)');
    intro = Intro(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      stepCount: 6,
      maskClosable: true,
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        texts: [
          'Avatar of user',
          "User's display name",
          "User's email adddress",
          "Click to change user's details",
          'Click to reset password',
          'Click to logout',
        ],
        buttonTextBuilder: (currPage, totalPage) {
          //--//////%//>print('(XI1)${currPage}%${totalPage}');
          return currPage < totalPage - 1 ? 'Next' : 'Finish';
        },
      ),
    );
    intro!.setStepConfig(
      0,
      borderRadius: BorderRadius.circular(64),
    );
  }*/
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());
    _model.textControllerFullName ??= TextEditingController(text: currentUser!.displayName);
    _model.textControllerConfirmationDeleteAccount ??= TextEditingController(text: '?');
    print(
        '(CC60)${currentUser!.reference!.path}++++${currentUser!.displayName}----${_model.textControllerFullName.text}');
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget editProfileTree() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 16.0),
            child: /*AuthUserStreamWidget(
                      builder: (BuildContext context) =>*/
                TextFormField(
              controller: _model.textControllerFullName,
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Lexend Deca',
                      color: const Color(0xFF95A1AC),
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                hintText: 'Your full name...',
                hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Lexend Deca',
                      color: const Color(0xFF95A1AC),
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFDBE2E7),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Lexend Deca',
                    color: const Color(0xFF14181B),
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
              validator: _model.textControllerValidatorFullName.asValidator(context),
            ),
          ),
          /*  ),*/
          if (functions.returnFalse())
            Text(
              'Role: ',
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          if (functions.returnFalse())
            FlutterFlowDropDown<String>(
              controller: _model.dropDownValueController ??= FormFieldController<String>(
                _model.dropDownValue ??= 'Reader',
              ),
              options: ['Reader', 'Contributor', 'Moderator', 'Administrator'],
              onChanged: (String? val) => setState(() => _model.dropDownValue = val),
              width: 180.0,
              height: 50.0,
              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Rubik',
                    color: Colors.black,
                  ),
              hintText: 'Please select role...',
              fillColor: Colors.white,
              elevation: 2.0,
              borderColor: Colors.transparent,
              borderWidth: 0.0,
              borderRadius: 0.0,
              margin: const EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 4.0),
              hidesUnderline: true,
            ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.05),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        /* await currentUserReference!.update(<Object, Object?>{
                                  ...createUsersRecordData(
                                    displayName: _model.textController.text,
                                  ),
                                  'chapter_colors_ints': functions
                                      .setCChosenColorsDatabaseFieldFromLocalState(
                                          FFAppState().chosenColors.toList()),
                                });*/

                        currentUser!.displayName = _model.textControllerFullName.text;

                        if (currentUser!.userLevel == kUserLevelNotLoggedIn) {
                          String colorString = '';

       /*                   globalSharedPrefs.setString(
                              currentUser!.reference!.path! + '.' + kConectedUserColors,
                              colorString);*/
                          //>print('(SU70)${colorString}');
                        } else {
                          await updateDocument(
                            collection: usersRef,
                            document: currentUser!.reference,
                            data: {'displayName': _model.textControllerFullName.text},
                          );
/*                          models.DocumentList connctedUserList =
                              await listDocumentsWithOneQueryString(
                            collection: connectedUsersRef,
                            attribute: 'user',
                            value: currentUser!.reference!.path,
                          );*/
                          /* print(
                              '(SE30)${currentUser!.reference!.path}%%%%${connctedUserList.documents.length}----${_model.textController.text}');
                          print(
                              '(SE31)${connctedUserList}%%%%${connctedUserList.documents.length}----${_model.textController.text}');
                         */ /*if (connctedUserList.documents.isNotEmpty) {
                            for (models.Document c
                                in connctedUserList.documents) {
                              print('(SE32)${c}++++${kAttConnectedUserDisplayName}----${_model.textController.text}');

                              await localDB.updateConnectedUser(
                                hyperbookIndex: null,
                                connectedUserIndex:
                                cp: kAttConnectedUserDisplayName,
                                value: _model.textController.text,
                              );
                              */ /*#await updateDocument(
                                collection: connectedUsersRef,
                                document: DocumentReference(path: c.$id),
                                data: {
                                  'displayName': _model.textController.text
                                },
                              );*/ /*
                              //>print('(CU1)${c.$id}');
                            }
                          }*/
                        }
                        if ((_model.textControllerFullName.text == '') ||
                            (_model.textControllerFullName.text == 'Unknown')) {
                          requireSetFullName(context);
                        } else {
                          context.pop();
                        }
                      },
                      text: 'Save Changes',
                      options: FFButtonOptions(
                        width: 340.0,
                        height: 60.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                        elevation: 2.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    MenuDetails profileMenuDetails = MenuDetails(
      menuLabelList: [
        'Login',
      ],
      menuIconList: [
        kIconLogin,
      ],
      menuTargets: [
        (context) {
          // context.goNamedAuth('login', context.mounted);
          Navigator.push(
              context,
              PageTransition(
                type: kStandardPageTransitionType,
                duration: kStandardTransitionTime,
                reverseDuration: kStandardReverseTransitionTime,
                child: LoginWidget(),
              ));
        },
      ],
    );

    // final UsersRecord profilePageUsersRecord = snapshot.data!;
    return Title(
        title: 'profilePage',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(

              iconTheme: IconThemeData(color: Colors.white),
              leading: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    if ((_model.textControllerFullName.text == '') ||
                        (_model.textControllerFullName.text == 'Unknown')) {
                      requireSetFullName(context);
                    } else {
                      context.pop();
                    }
                  }),
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: true,
              title: Text(
                'User Profile',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Rubik',
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
              ),
              actions: [
                insertMenu(
                    context: context,
                    menuDetails: profileMenuDetails,
                    externalSetState: setState,
                    caption: 'Menu',
                    width: 100,
                    height: 50),
              ],
              centerTitle: false,
              elevation: 2.0,
            ),
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                    child: Text(
                      // key: intro!.keys[1],
                      valueOrDefault<String>(
                        currentUser!.displayName,
                        'Balla #1',
                      ),
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                            fontFamily: 'Lexend Deca',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  // ],
                  // ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                        child: Text(
                          // key: intro!.keys[2],
                          (currentUser!.userLevel == kUserLevelNotLoggedIn)
                              ? 'Not logged in'
                              : loggedInUser!.email,
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Lexend Deca',
                                color: FlutterFlowTheme.of(context).primary,
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 5.0, 0.0, 12.0),
                        child: Text(
                          'Account Settings',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Lexend Deca',
                                color: const Color(0xFF090F13),
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  // ],
                  // ),
                  editProfileTree(),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          // key: intro!.keys[4],
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.push(
                                context!,
                                PageTransition(
                                  type: kStandardPageTransitionType,
                                  duration: kStandardTransitionTime,
                                  reverseDuration: kStandardReverseTransitionTime,
                                  child: ChangePasswordWidget(),
                                ));

                            // context.pushNamed('changePassword');
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).grayLines,
                                width: 2.0,
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Reset Password',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Lexend Deca',
                                          color: const Color(0xFF090F13),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                                const Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0.9, 0.0),
                                    child: kIconArrowForward,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlutterFlowIconButton(
                          tooltipMessage: 'Log out',
                          borderColor: Colors.transparent,
                          borderRadius: 0.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          buttonWidth: kSessionIconButtonWidth,
                          icon: Icon(Icons.logout),
                          onPressed: () async {
                            GoRouter.of(context).prepareAuthEvent();
                            //await authManager.signOut();
                            await appwriteLogout();
                            loggedIn = false;
                            await setupTutorialUser(context);
                            GoRouter.of(context).clearRedirectLocation();
                            // context.goNamedAuth(
                            //     'introduction', context.mounted);
                            Navigator.push(
                                context!,
                                PageTransition(
                                  type: kStandardPageTransitionType,
                                  duration: kStandardTransitionTime,
                                  reverseDuration: kStandardReverseTransitionTime,
                                  child: LoginWidget(),
                                ));
                          },
                          caption: 'Log Out',
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlutterFlowIconButton(
                          tooltipMessage: 'Delete account',
                          borderColor: Colors.transparent,
                          borderRadius: 0.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          buttonWidth: kSessionIconButtonWidth,
                          icon: Icon(Icons.delete),
                          caption: 'Delete Account',
                          onPressed: () async {
                            showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(builder: (context, setState) {
                                    return AlertDialog(
                                      title: Text('Delete Account'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Deleting an AIR Studio account annot be undone'),
                                          Text(
                                              'Enter your email address to confirm\nyou wish to delete your account.'),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                20.0, 20.0, 20.0, 16.0),
                                            child: TextFormField(
                                              onChanged: (value){print('(DD80)${value}....${_model.textControllerConfirmationDeleteAccount.text}');},
                                              controller:
                                                  _model.textControllerConfirmationDeleteAccount,
                                              decoration: InputDecoration(
                                                labelText: 'Your email address',
                                                labelStyle: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: const Color(0xFF95A1AC),
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                hintText: 'Your email address...',
                                                hintStyle: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: const Color(0xFF95A1AC),
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFDBE2E7),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                focusedErrorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                        20.0, 24.0, 0.0, 24.0),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Lexend Deca',
                                                        color: const Color(0xFF14181B),
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                              validator: _model
                                                  .textControllerValidatorConfirmationDeleteAccount
                                                  .asValidator(context),
                                            ),
                                          ),

                                          ////
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            print(
                                                '(DD1)${_model.textControllerConfirmationDeleteAccount.text}....${currentUser!.email}');
                                            if (_model
                                                    .textControllerConfirmationDeleteAccount.text ==
                                                currentUser!.email) {
                                              toast(context,
                                                  'Your account will now be deleted',
                                                  ToastKind.warning);
                                              List<SessionsRecord> sessions =
                                              await listSessionList();
                                              for (int i = 0; i <
                                                  sessions.length; i++) {
                                                print('(DD2)${sessions[i]
                                                    .reference!.path}');
                                                await deleteAIR(sessions[i]);
                                              }

                                              await deleteDocument(
                                                  collection: usersRef,
                                                  document: currentUser!
                                                      .reference);
                                              print('(DD3)${currentUser!
                                                  .reference!.path}');
                                              await deleteUser();
                                               print('(DD4)${currentUser!
                                                  .reference!.path}');
                                            } else {
                                              toast(context, 'Email address incorrect', ToastKind.warning);
                                            }
                                            context.pop();
                                          },
                                          child: const Text('Confirm'),
                                        )
                                      ],
                                    );
                                  });
                                });
                          },
                        ),
                      ],
                    ),
                  ),

                  // ],
                  // ),
                ]),
              ),
            )));
  }
}
