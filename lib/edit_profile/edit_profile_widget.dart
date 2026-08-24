import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
// import '/backend/firebase_storage/storage.dart';
import '../localDB.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
// import '/flutter_flow/upload_data.dart';
import 'edit_profile_model.dart';
import '../../appwrite_interface.dart';
import 'package:appwrite/models.dart' as models;

export 'edit_profile_model.dart';

void requireSetFullName(BuildContext context) {
  showDialog<bool>(
      context: context,
      builder: (BuildContext alertDialogContext) {
        //>print('(N4101)${requestedRole}');
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            title: Text('Please enter full name'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(alertDialogContext, false);
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
      });
}


class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late EditProfileModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfileModel());

    _model.textController ??=
        TextEditingController(text: currentUser!.displayName);
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

    return
        SingleChildScrollView(
      child: Column(
        children: [
          const Row(),
          Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 16.0),
            child: /*AuthUserStreamWidget(
                      builder: (BuildContext context) =>*/
                TextFormField(
              controller: _model.textController,
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
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Lexend Deca',
                    color: const Color(0xFF14181B),
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
              validator: _model.textControllerValidator.asValidator(context),
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
              controller: _model.dropDownValueController ??=
                  FormFieldController<String>(
                _model.dropDownValue ??= 'Reader',
              ),
              options: ['Reader', 'Contributor', 'Moderator', 'Administrator'],
              onChanged: (String? val) =>
                  setState(() => _model.dropDownValue = val),
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
              margin:
                  const EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 4.0),
              hidesUnderline: true,
            ),
          Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Text(
                    'Select Chapter colours',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).headlineSmall,
                  ),
                ),
                /*AuthUserStreamWidget(
                          builder: (BuildContext context) =>*/
                /*SizedBox(
                  width: MediaQuery.sizeOf(context).width *
                      kStateSelectorWidthFactor,
                  height: kStateSelectorHeight,
                  child: custom_widgets.MyColorPicker(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 50.0,
                    label: 'Not seen',
                    index: 0,

                    stateIndex: 0,
                    icon: const Icon(
                      FFIcons.keyeSlash,
                    ),
                  ),
                ),*/
                /* ),*/
                /*AuthUserStreamWidget(
                          builder: (BuildContext context) =>*/
                /*SizedBox(
                  width: MediaQuery.sizeOf(context).width *
                      kStateSelectorWidthFactor,
                  height: kStateSelectorHeight,
                  child: custom_widgets.MyColorPicker(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 50.0,
                    label: 'Visited',
                    index: 1,

                    stateIndex: 1,
                    icon: const Icon(
                      FFIcons.kprogressOne,
                    ),
                  ),
                ),*/
                /* ),*/
                /* AuthUserStreamWidget(
                          builder: (BuildContext context) =>*/
                /*SizedBox(
                  width: MediaQuery.sizeOf(context).width *
                      kStateSelectorWidthFactor,
                  height: kStateSelectorHeight,
                  child: custom_widgets.MyColorPicker(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 50.0,
                    label: 'Partially read',
                    index: 2,

                    stateIndex: 2,
                    icon: const Icon(
                      FFIcons.kprogressTwo,
                    ),
                  ),
                ),*/
                /* ),*/
                /* AuthUserStreamWidget(
                          builder: (BuildContext context) =>*/
                /*SizedBox(
                  width: MediaQuery.sizeOf(context).width *
                      kStateSelectorWidthFactor,
                  height: kStateSelectorHeight,
                  child: custom_widgets.MyColorPicker(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 50.0,
                    label: 'Fully read',
                    index: 3,

                    stateIndex: 3,
                    icon: const Icon(
                      FFIcons.kprogressFull,
                    ),
                  ),
                ),*/
                /* ),*/
                /*AuthUserStreamWidget(
                          builder: (BuildContext context) =>*/
                /*SizedBox(
                  width: MediaQuery.sizeOf(context).width *
                      kStateSelectorWidthFactor,
                  height: kStateSelectorHeight,
                  child: custom_widgets.MyColorPicker(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 50.0,
                    label: 'Highlighted',
                    index: 4,

                    stateIndex: 4,
                    icon: const Icon(
                      FFIcons.khighlight,
                    ),
                  ),
                ),*/
                /* ),*/
                /*AuthUserStreamWidget(
                          builder: (BuildContext context) =>*/
                /*SizedBox(
                  width: MediaQuery.sizeOf(context).width *
                      kStateSelectorWidthFactor,
                  height: kStateSelectorHeight,
                  child: custom_widgets.MyColorPicker(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 50.0,
                    label: 'Depreciated',
                    index: 5,

                    stateIndex: 5,
                    icon: const Icon(
                      FFIcons.kthumbsDown,
                    ),
                  ),
                ),*/
                /*  ),*/
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.05),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 24.0, 0.0, 0.0),
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

                        currentUser!.displayName = _model.textController.text;


                        if (currentUser!.userLevel == kUserLevelNotLoggedIn) {
                          String colorString = '';

/*                          globalSharedPrefs.setString(
                              currentUser!.reference!.path! +
                                  '.' +
                                  kConectedUserColors,
                              colorString);*/
                          //>print('(SU70)${colorString}');
                        } else {
                          await updateDocument(
                            collection: usersRef,
                            document: currentUser!.reference,
                            data: {
                              'displayName': _model.textController.text
                            },
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
                        if ((_model.textController.text == '') ||
                            (_model.textController.text == 'Unknown')) {
                          requireSetFullName(context);
                        } else {
                          context.pop();
                        }
                      },
                      text: 'Save Changes',
                      options: FFButtonOptions(
                        width: 340.0,
                        height: 60.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
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
    // )
    // );
  }
}
