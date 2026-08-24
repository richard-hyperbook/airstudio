import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_code/widgets/permissions.dart';
// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'create_account_model.dart';
import '../../appwrite_interface.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_svg/flutter_svg.dart';
// import '../../phone_sign_in/phone_sign_in_widget.dart';
import '../../profile_page/profile_page_widget.dart';
import '../../edit_profile/edit_profile_widget.dart';
import '../../login/login_widget.dart';
import '../../custom_code/widgets/toast.dart';

export 'create_account_model.dart';

class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({super.key});

  @override
  _CreateAccountWidgetState createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  late CreateAccountModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateAccountModel());

    _model.emailAddressController ??= TextEditingController();
    _model.passwordController ??= TextEditingController();
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

    return Title(
      title: 'createAccount',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF262D34),
        appBar: AppBar(
          title: Text('Create Account',
              style: TextStyle(color: Colors.white)),
          backgroundColor: FlutterFlowTheme.of(context).primary,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF368BF4), Color(0xFF5B00FF)],
              stops: <double>[0.0, 1.0],
              begin: AlignmentDirectional(0.0, -1.0),
              end: AlignmentDirectional(0, 1.0),
            ),
          ),
          child: Align(
            alignment: const AlignmentDirectional(0.0, 1.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
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
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'AIR Studio',
                          overflow: TextOverflow.fade,
                          //   style: FlutterFlowTheme.of(context)
                          //      .headlineMedium,),
                          style: FlutterFlowTheme.of(
                            context,
                          ).displaySmall,
                          ),
                        ),
                      ),
                    ]),


                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    16.0,
                    0.0,
                    0.0,
                  ),
                  child:  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        3.0,
                        0.0,
                        0.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0,
                              16.0,
                              20.0,
                              0.0,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: AutoSizeText(
                                    'Get Started with AIR Studio',
                                    style: FlutterFlowTheme.of(
                                      context,
                                    ).displaySmall ,
                                  ),
                                ),
               /*                 InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    // context.pushNamed('phoneSignIn');
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: kStandardPageTransitionType,
                                        duration: kStandardTransitionTime,
                                        reverseDuration:
                                            kStandardReverseTransitionTime,
                                        child: const PhoneSignInWidget(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFFDBE2E7),
                                      ),
                                    ),
                                    child: kIconTelephone,
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0,
                              16.0,
                              20.0,
                              0.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: _model.emailAddressController,
                                    decoration: InputDecoration(
                                      labelText: 'Email Address',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Rubik',
                                            color: const Color(0xFF95A1AC),
                                          ),
                                      hintText: 'Enter your email here...',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Rubik',
                                            color: const Color(0xFF95A1AC),
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFDBE2E7),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(
                                        context,
                                      ).white,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            16.0,
                                            24.0,
                                            0.0,
                                            24.0,
                                          ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
                                          color: const Color(0xFF2B343A),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0,
                              16.0,
                              20.0,
                              0.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: _model.passwordController,
                                    obscureText: !_model.passwordVisibility,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Rubik',
                                            color: const Color(0xFF95A1AC),
                                          ),
                                      hintText: 'Enter your password here...',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Rubik',
                                            color: const Color(0xFF95A1AC),
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFDBE2E7),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(
                                        context,
                                      ).white,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            16.0,
                                            24.0,
                                            0.0,
                                            24.0,
                                          ),
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => _model.passwordVisibility =
                                              !_model.passwordVisibility,
                                        ),
                                        focusNode: FocusNode(
                                          skipTraversal: true,
                                        ),
                                        child: _model.passwordVisibility
                                            ? kIconVisible
                                            : kIconNotVisible,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
                                          color: const Color(0xFF2B343A),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0,
                              12.0,
                              20.0,
                              16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FFButtonWidget(
                                  tooltipMessage: 'Click to create an account',
                                  onPressed: () async {
                                    UsersRecord? user;
                                    GoRouter.of(context).prepareAuthEvent();
                                    print(
                                      '(N91A)${_model.emailAddressController.text}',
                                    );
                                    try {
                                      user = await appwriteCreateAccount(
                                        _model.emailAddressController.text,
                                        _model.passwordController.text,
                                      );
                                    } on AppwriteException catch(e) {
                                      print('(N91Z)${_model.emailAddressController.text}....${_model.passwordController.text},,,,${e.message}');
                                      toast(context, e.message?? 'Error in creating account', ToastKind.warning);
                                    }
                                    // loggedInUser = user!;
                                    currentUser = await getUser(
                                      document: DocumentReference(
                                        path: user!.reference!.path,
                                      ),
                                    );

                                    loggedIn = true;
                                    // hyperbookCacheValid = false;
                                    // coonectedUsersCacheValid = false;

                                    /*# await loadCachedHyperbookLists(
                                          DocumentReference(
                                              path: loggedInUser!
                                                  .$id) );*/

                                    /*£ final BaseAuthUser? user =
                                          await authManager
                                              .createAccountWithEmail(
                                        context,
                                        _model.emailAddressController.text,
                                        _model.passwordController.text,
                                      );*/
                                    /*£if (user == null) {
                                        return;
                                      }*/

                                    /*£UsersRecord.collection
                                          .doc(user.uid)
                                          .update(<Object, Object?>{
                                        ...createUsersRecordData(
                                          createdTime: getCurrentTimestamp,
                                          isModerator: true,
                                        ),
                                        'chapter_colors_ints': functions
                                            .returnDefaultChapterColorsInts(),
                                      });
                                      List<HyperbooksRecord> hypebookList =
                                          <HyperbooksRecord>[];
                                      hypebookList =
                                          await queryHyperbooksRecordOnce(
                                        queryBuilder: (Query<Object?>
                                                HyperbooksR ecord) =>
                                            HyperbooksRecord.where('type',
                                                isEqualTo:
                                                    kHyperbookTutorialTypeNumber),
                                      );*/
                                    /*£  if (hypebookList.isNotEmpty) {
                                        FFAppState().introductionHyperbook =
                                            hypebookList[0].reference;
                                        hyperbookTutorialReference =
                                            hypebookList[0].reference;
                                        ChaptersRecord chapterRec =
                                            await ChaptersRecord
                                                .getDocumentOnce(hypebookList[0]
                                                    .startChapter!);
                                      */ /*  await createReadReference(
                                            hyperbookTutorialReference!,
                                          chapter: chapterRec.reference,
                                          chapterAuthor: listViewChaptersRecord.author,
                                          chapterXCoord:  listViewChaptersRecord.xCoord,
                                          chapterYCoord:  listViewChaptersRecord.yCoord,); */ /*

                                        await createReadReference(
                                          hyperbookTutorialReference!,
                                          chapterRec.reference,
                                          chapterRec.author,
                                          chapterRec.xCoord,
                                          chapterRec.yCoord,);

                                      } else {
                                        FFAppState().introductionHyperbook =
                                            null;
                                      }*/
                                    /* context.pushNamedAuth(
                                          'profilePage', context.mounted);*/
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: kStandardPageTransitionType,
                                        duration: kStandardTransitionTime,
                                        reverseDuration:
                                            kStandardReverseTransitionTime,
                                        child: const ProfilePageWidget(),
                                      ),
                                    );
                                  },
                                  text: 'Create Account',
                                  options: FFButtonOptions(
                                    width: 170.0,
                                    height: 50.0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                    color: FlutterFlowTheme.of(context).primary,
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
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              12.0,
                              0.0,
                              24.0,
                            ),
                            child: FFButtonWidget(
                              onPressed: () async {
                                /*                                  context.pushNamed(
                                    'login',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: const TransitionInfo(
                                        hasTransition: true,
                                        duration: Duration(milliseconds: 250),
                                      ),
                                    },
                                  );*/
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: kStandardPageTransitionType,
                                    duration: kStandardTransitionTime,
                                    reverseDuration:
                                        kStandardReverseTransitionTime,
                                    child: const LoginWidget(),
                                  ),
                                );
                              },
                              text: 'Login',
                              options: FFButtonOptions(
                                width: 170.0,
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  0.0,
                                  0.0,
                                  0.0,
                                ),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                    ),
                                color: FlutterFlowTheme.of(context).white,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Rubik',
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).primary,
                                    ),
                                elevation: 0.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

            ]),
          ),
        ),
      ),
    );
  }
}
