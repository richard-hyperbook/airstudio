import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '/../custom_code/widgets/email_sender.dart';
import '/../custom_code/widgets/toast.dart';
// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
//import '/backend/push_notifications/push_notifications_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'session_step_display_model.dart';
import '../../app_state.dart';
import '/app_state.dart';
// import 'package:flutter_intro/flutter_intro.dart';
import '/custom_code/widgets/permissions.dart';
export 'session_step_display_model.dart';
import 'dart:math';
import '../../appwrite_interface.dart';
// import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as models;
// import '/../custom_code/widgets/appwrite_realtime_subscribe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../menu.dart';
import '../../localDB.dart';
import '../../login/login_widget.dart';
// import '../../map_display/map_display_widget.dart';
// import '../../chapter_display/chapter_display_widget.dart';
// import '../../paypal/paypal_widget.dart';
// import '../../audio/audio_player.dart';
// import '../../audio/audio_recorder.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import '../../platform/audio_recorder_platform.dart';

import 'package:http/http.dart' as http;
import 'package:appwrite/appwrite.dart' as appwrite;

import 'package:appwrite/models.dart' as models;
import 'package:appwrite/enums.dart' as enums;
// import 'package:compressor/compressor.dart';
// import '/custom_code/widgets/audio_trimmer.dart';

import 'package:ffmpeg_kit_flutter_new_video/ffprobe_kit.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:intl/intl.dart' show DateFormat;
import '../../custom_code/widgets/trimmer3.dart';
import '../../session_display/session_display_widget.dart';

http.Client _http = http.Client();

int _count = 0;
bool _iHaveRequests = false;
List<DocumentReference?> _hyperbookListRequesting = [];

Future<double> getFileDuration(String mediaPath) async {
  final mediaInfoSession = await FFprobeKit.getMediaInformation(mediaPath);
  final mediaInfo = mediaInfoSession.getMediaInformation()!;

  // the given duration is in fractional seconds
  final duration = double.parse(mediaInfo.getDuration()!);
  print('(EP10)Duration: $duration');
  return duration;
}

class SessionStepDisplayWidget extends StatefulWidget {
  const SessionStepDisplayWidget({super.key});

  @override
  _SessionStepDisplayWidgetState createState() =>
      _SessionStepDisplayWidgetState();
}

class _SessionStepDisplayWidgetState
    extends State<SessionStepDisplayWidget> /* with AudioRecorderMixin*/ {
  late SessionStepDisplayModel _model;

  TextEditingController? enteredHyperbookTitleController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Intro? intro;
  _SessionStepDisplayWidgetState() {}

  int? externalSetState() {
    //>print('(R10X)${context}');
    setState(() {});
    return null;
  }

  List<SessionStepsRecord>? sessionSteps;

  ScrollController? scrollController;

  @override
  void initState() {
    print('${sessions![currentSessionIndex]}');
    super.initState();
    _model = createModel(context, () => SessionStepDisplayModel());
    enteredHyperbookTitleController = TextEditingController();
    enteredHyperbookTitleController.text = '';
    // scrollController = ScrollController()
    //   ..addListener(_scrollListener);

    // hyperbookDisplayscrollController = ScrollController();
    // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    // hyperbookDisplayscrollController!.dispose();
    //>print('(XXDD)${hyperbookDisplayIsSubscribed}');
    if (hyperbookDisplayIsSubscribed) {
      // hyperbookDisplaySubscription!.close();
      hyperbookDisplayIsSubscribed = false;
    }
    // scrollController!.removeListener(_scrollListener);

    super.dispose();
  }

  String audioPath = '';

  Future<void> setCurrentSessionStepAndIndex(int index) async {
    models.DocumentList sessionStepList = await listDocumentsWithTwoQueries(
      collection: sessionStepsRef,
      attribute1: kSessionStepSessionId,
      value1: sessions![currentSessionIndex].reference!.path,
      attribute2: kSessionStepIndex,
      value2: index,
    );
    if (sessionStepList.documents.length > 0) {
      currentSessionStep = extractSessionStepRecord(
        sessionStepList.documents.first,
      );
    } else {
      toast(context, 'Error in database', ToastKind.error);
    }
  }

  // String imageNetworkPath = '';
  String localImagePath = '';

  // String transcription = '';
  List<String> transcriptionList = [];

  //int? maxVersion;

  Widget displayThumbnail(SessionStepsRecord sessionStep) {
    print(
        '(DE410A)${sessionStep.reference!.path}....${sessionStep.photoFileValid}');
    if (sessionStep!.photoFileValid ?? false) {
      print(
          '(DE410B)${sessionStep.reference!.path}....${sessionStep.photoFileValid}');

      return Image.file(
        key: UniqueKey(),
        File(appDirPath! + '/photo' + sessionStep.reference!.path! + '.jpg'),
        width: (MediaQuery.sizeOf(context).width * 0.9) -
            kIconButtonWidth -
            kIconButtonGap,
        height: (kIconButtonHeight * 2) + kIconButtonGap,
        fit: BoxFit.contain,
      );
    } else {
      return Container();
    }
  }

  Widget editRecordingsButton(SessionStepsRecord sessionStep, int index) {
    return FlutterFlowIconButton(
        showLoadingIndicator: true,
        caption: 'Edit recording',
        //captionFontSize: basicFontSize,
        tooltipMessage: 'Edit recording',
        borderColor: Colors.transparent,
        borderRadius: 0.0,
        borderWidth: 1.0,
        buttonSize: 40.0,
        buttonWidth: kIconButtonWidth,
        icon: Icon(Icons.edit_note),
        onPressed: () async {
          currentSessionStep = sessionStep;
          final String filePath =
              getFilePath(FileKind.aac, sessionStep.reference!.path!);
          // await setMaxVersionNumbersCurrentSessionStep();
          // int maxVersion = currentSessionStep!.maxAudioVersion!;
          if (!(await isFileInAppDir(filePath))) {
            toast(
              context,
              'No recording stored',
              ToastKind.warning,
            );
          } else {
            double duration = await getFileDuration(filePath);

            print('(DE101)${filePath}....${duration}');
            showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  // currentCachedHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
                  currentSessionStep = sessionStep;
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                        title: Text('Edit Recording'),
                        content: Container(
                          width: MediaQuery.sizeOf(context).width * 0.95,
                          child: Trimmer3(
                              sessionStepId: sessionStep.reference!.path,
                              duration: duration),
                          // FileSelectorWidget(
                          //     filePath: filePath,
                          //     dirPath: appDirPath!,
                          //     maxVersion: 0,
                          //     sessionStepId: sessionStep.reference!.path!), //AudioTrimmerPopup()),
                        ));
                  });
                });
          }
        });
  }

  Widget displaySessionStep(
      {required SessionStepsRecord sessionStep, required int index
      // int maxVersion,
      }) {
    print('(ss111)${index}');
    loadImageLocalPath(sessionStep /*, maxVersion*/);
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: kSessionStepCardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 15.0,
              color: Color(0x1F000000),
              offset: Offset(0.0, 4.0),
            ),
          ],
          border: Border.all(
            color: FlutterFlowTheme.of(context).lineColor,
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // key: infoCount == 1
              // ? intro!.keys[2]
              // : UniqueKey(),
              child: Text(
                'Step: ${(index + 1).toString()}',
                softWrap: false,
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            ),
            // SingleChildScrollView(
            // key: infoCount == 1
            //     ? intro!.keys[3]
            //     : UniqueKey(),
            // scrollDirection: Axis.horizontal,
            // child:
            Text(
              softWrap: true,
              'Question: ${sessionStep.question}',
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
            RecordPlay(title: 'AirStudio', sessionStep: sessionStep),
            Row(
              children: [
                Column(
                  children: [
                    editRecordingsButton(sessionStep, index),
                    SizedBox(height: kIconButtonGap),
                    FlutterFlowIconButton(
                      showLoadingIndicator: true,
                      caption: 'Select photo',
                      // captionFontSize: basicFontSize,
                      tooltipMessage: 'Select photo from gallery',
                      borderColor: Colors.transparent,
                      borderRadius: 0.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      buttonWidth: kIconButtonWidth,
                      icon: Icon(Icons.camera),
                      onPressed: () async {
                        FFAppState().update(() {});
                        currentSessionStep = sessionStep;
                        // await setMaxVersionNumbersCurrentSessionStep();
                        insertPicture(context, sessionStep);
                        sessions![currentSessionIndex].sessionModified = true;
                        await updateDocument(
                            collection: sessionsRef,
                            document: sessions![currentSessionIndex].reference,
                            data: {kSessionSessionModified: true});
                        print('(DE444)');
                        imageCache.clear();
                        imageCache.clearLiveImages();
                        enclosingSetState();
                      },
                    ),
                    SizedBox(height: kIconButtonGap),
                    FlutterFlowIconButton(
                      showLoadingIndicator: true,
                      caption: 'Transcribe',
                      // captionFontSize: basicFontSize,
                      tooltipMessage: 'Speech to text',
                      borderColor: Colors.transparent,
                      borderRadius: 0.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      buttonWidth: kIconButtonWidth,
                      icon: Icon(Icons.speaker_notes),
                      onPressed: () async {
                        await storeStorageFile(
                            bucketId: artTheopyAIRaudiosRef.path!,
                            storageFileId:
                                'aac' + sessionStep.reference!.path! + '.aac',
                            localFilePath: getFilePath(
                                FileKind.aac, sessionStep.reference!.path!),
                            deleteIfNecessary: true);

                        currentSessionStep = sessionStep;
                        //                      final uri = Uri.parse('698718ad000f1cc14442.fra.appwrite.run');
                        print(
                          '(PQ1)${currentSessionStep}++++${sessionStep.reference!.path!}....${sessionStep.maxAudioVersion.toString()}',
                        );
                        final uri = Uri.parse(
                          'https://698718ad000f1cc14442.fra.appwrite.run',
                        );
                        //final creds = base64.encode(utf8.encode('$clientId:$secret'));
                        final respAccessToken = await _http.post(
                          uri,
                          headers: {
                            // 'Authorization': 'Basic $creds',
                            'Content-Type': 'application/json',
                          },
                          body: 'aac' +
                              sessionStep.reference!.path! +
                              /*sessionStep.maxAudioVersion.toString()*/
                              '.aac',
                        );
                        print('(PQ2)${respAccessToken.statusCode}');

                        print(respAccessToken.body);
                        var respDynamic = jsonDecode(respAccessToken.body);
                        Map<String, dynamic> respObject =
                            respDynamic as Map<String, dynamic>;

                        showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              // currentCachedHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
                              //>print('(UM6)${message}')
                              currentSessionStep = sessionStep;
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: Text('Transcription'),
                                  content: SingleChildScrollView(
                                    child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.85,
                                        child: Text(
                                            respObject['transcription']!
                                                as String,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium)),
                                  ),
                                );
                              });
                            });

                        print(
                          '(PQ4)${index}~~~~${respDynamic}....${respObject},,,,${transcriptionList[index]}',
                        );
                        if (respAccessToken.statusCode < 200 ||
                            respAccessToken.statusCode >= 300) {
                          toast(
                            context,
                            'Error in transcription',
                            ToastKind.error,
                          );
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Expanded(child: displayThumbnail(sessionStep)),
              ],
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.9,
              child: Text(transcriptionList[index],
                  style: TextStyle(
                      fontSize: basicFontSize, fontWeight: FontWeight.bold)),
            ),

            ////////////////////
          ],
        ),
      ),
    );
  }

  BackupFileDetail? chosenFileDetail;

  Future<void> restoreHyperbookBackup({
    models.File? chosenHyperbookFile,
  }) async {}

  List<BackupFileDetail> backupFileDetailList = [];

  void loadImageLocalPath(
    SessionStepsRecord sessionStep,
  ) {
    localImagePath =
        appDirPath! + '/photo' + sessionStep.reference!.path! + '.jpg';
    print('(SS212)${localImagePath}');
  }

  void insertPicture(
    BuildContext context,
    SessionStepsRecord sessionStep,
  ) async {
    // //> print('(X400)${jobData[kJrAMS][0]}');
    // String? role = Provider.of<ScaffoldData>(context, listen: false).cUserRole;
    ImagePicker picker;
    const bool KIsWeb = identical(0, 0.0);

    if (!KIsWeb) {
      //((Platform.isAndroid) || (Platform.isIOS)) {
      // //> print('(XJJP0)');
      picker = ImagePicker();
      PickedFile pickedFile;

      XFile? imageFile = await picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 500,
          maxHeight: 500,
          imageQuality: 50);
      final String savedFilePath =
          appDirPath! + '/photo' + sessionStep.reference!.path! + '.jpg';
      await deleteFile(savedFilePath);
      await printAppDirListing();
      File savedFile = File(savedFilePath);
      final FileImage fileImage = FileImage(savedFile);
      bool evictSuccess = await fileImage.evict();
      File renewedSavedFile = await File(imageFile!.path).copy(savedFilePath);
      print(
          '(DE410C)${imageFile.path},,,,${await imageFile.length()}....${savedFile.path}++++${await savedFile.length()}!!!!${evictSuccess}~~~~${renewedSavedFile.path}');
      await printAppDirListing();
      /* var result = await FlutterImageCompress.compressWithFile(
        imageFile.path,
        minWidth: 500,
        minHeight: 500,
        quality: 94,
      );
      print('(FF21)${imageFile.length()}....${result!.length}...${result}');
*/
      // Compressor compressor = Compressor(path: imageFile.path, isLocal: true);
      // String result = compressor.compressVideo(); // Replace with a real image compression method in future updates

      String localFilePath = imageFile!
          .path; //= await getPath(sessionStepId: sessionStep.reference!.path!, fileKind: FileKind.photo);
      print(
        '(DE400)${localFilePath}....${sessionStep.reference!.path!}',
      );
/*      await storeStorageFile(
        bucketId: artTheopyAIRphotosRef.path!,
        storageFileId: generatePhotoStorageFilename(
          sessionStep,

        ),
        localFilePath: localFilePath,
      );*/
      setState(() {
        loadImageLocalPath(
          sessionStep,
        );
      });

      print(
        '(DE401)${localFilePath}....${sessionStep.reference!.path!}',
      );

      // //> print('(XJJP9A)±${snapshot}');
      //File file = File(snapshot!.path);
      // //> print('(XJJPAA)${cloudStoragePathname}±${snapshot.path}±${file}');
      //   await storeFileInStorage(
      //       prefix: 'photo', bucketId: artTheopyAIRphotosRef.path, contents: contents);
      // //> print('(XJJPB)${snapshot2}');
      // //> print('(XJJPD)${e}');
    } else {
      // //> print('(XJJQ0)${cloudStoragePathname}');
      // Deploy.storeWebImage(context, jobId, cloudStoragePathname);
    }
  }

  void enclosingSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('(SS2)${sessions![currentSessionIndex]}`}');
    print('(SS3)${sessions![currentSessionIndex].clientDisplayName}');
    sessions![currentSessionIndex].sessionModified = true;
    MenuDetails hyperbookDisplayMenuDetails = MenuDetails(
      menuLabelList: ['Login'],
      menuIconList: [kIconLogin],
      menuTargets: [
        (context) async {
          //# context.goNamedAuth('login', context.mounted);
          if (currentUser!.archiveSessions ?? false) {
            await storeAIRInCloud(currentSessionIndex);
          }
          print('(FF1)');
          Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: LoginWidget(),
            ),
          );
        },
      ],
    );
    print('(SS4)${sessions![currentSessionIndex]}');
    print('(SS5)${sessions![currentSessionIndex]!.clientDisplayName}');

    return FutureBuilder<List<SessionStepsRecord>>(
      future: listSessionStepList(thisSession: sessions![currentSessionIndex]),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          // while data is loading:
          return Center(child: CircularProgressIndicator());
        } else {
          print('(SS80)${snapshot}');
          sessionSteps = snapshot.data;

          print('(SS81)${sessionSteps}');
          print(
            '(SS82)${sessionSteps!.length}',
          );
          if (transcriptionList.length < 1) {
            transcriptionList.clear();
            for (int i = 0; i < sessionSteps!.length; i++) {
              transcriptionList.add('');
            }
          }

          return Title(
            title: 'Edit AIR',
            color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: const Color(0xFFF5F5F5),
              appBar: AppBar(
                leading: BackButton(
                  color: Colors.white,
                  onPressed: () async {
                    await storeAIRInCloud(currentSessionIndex);
                    print('(FF1)');
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: FlutterFlowTheme.of(context).primary,
                automaticallyImplyLeading: false,
                title: Text(
                  'Edit AIR',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Rubik',
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                ),
                actions: [
                  // insertOutstandingRequestsButton(context),

                  insertMenu(
                      context: context,
                      menuDetails: hyperbookDisplayMenuDetails,
                      externalSetState: setState),
                ],
                centerTitle: false,
                elevation: 2.0,
              ),
              body: SafeArea(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: SingleChildScrollView(
                    // controller: hyperbookDisplayscrollController,
                    physics: ScrollPhysics(),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                20.0,
                                0.0,
                                20.0,
                                0.0,
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                // key: infoCount == 1
                                // ? intro!.keys[2]
                                // : UniqueKey(),
                                child: Text(
                                  'Client: ${sessions![currentSessionIndex].clientDisplayName}',
                                  softWrap: false,
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                20.0,
                                0.0,
                                20.0,
                                0.0,
                              ),
                              child: SingleChildScrollView(
                                // key: infoCount == 1
                                //     ? intro!.keys[3]
                                //     : UniqueKey(),
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  softWrap: false,
                                  'Date: ${(DateFormat.yMMMd().format(sessions![currentSessionIndex].$createdAt!))}',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0,
                              0.0,
                              20.0,
                              0.0,
                            ),
                            child: Container(
                              // child: Scrollbar(
                              //   controller: scrollController,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: sessionSteps!.length,
                                //#cachedHyperbookList.length,
                                itemBuilder:
                                    (BuildContext context, int listViewIndex) {
                                  return displaySessionStep(
                                      sessionStep: sessionSteps![listViewIndex],
                                      index: listViewIndex);
                                },
                              ),
                            ),
                          ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _scrollListener() {
    print('(FX1)${scrollController!.position.extentAfter}');
  }
}

class BackupFileDetail {
  String? hyperbookName;
  int? versionNumber;
  DocumentReference hyperbookReference;
  models.File? file;
  BackupFileDetail(
    this.hyperbookName,
    this.versionNumber,
    this.hyperbookReference,
    this.file,
  );
}

List<CP> cpList = [];

class CP {
  String chapterPath = '';
  String parentPath = '';
  int count = 0;
  CP(this.chapterPath, this.parentPath, this.count);
}

void findAndIncrementCP(String hyperbook, String parent) {
  for (int i = 0; i < cpList.length; i++) {
    if ((hyperbook == cpList[i].chapterPath) &&
        (parent == cpList[i].parentPath)) {
      cpList[i].count++;
      return;
    }
  }
  cpList.add(CP(hyperbook, parent, 1));
}

void listCP() {
  //>print('(CP1)${cpList.length}');
  for (int i = 0; i < cpList.length; i++) {
    if (cpList[i].count > 1) {
      print(
        '(CP2)${cpList[i].count}>>>>${cpList[i].chapterPath}<<<<<${cpList[i].parentPath}',
      );
    }
  }
}

class RecordPlay extends StatefulWidget {
  final String title;
  final SessionStepsRecord sessionStep;

  const RecordPlay({super.key, required this.title, required this.sessionStep});

  @override
  State<RecordPlay> createState() => _RecordPlayState();
}

class _RecordPlayState extends State<RecordPlay> {
  late FlutterSoundRecorder _recordingSession;
  final AudioPlayer audioPlayer = AudioPlayer();
  String? _recordedFilePath;
  bool _playAudio = false;
  String _timerText = '00:00';
  StreamSubscription? _recorderSubscription;
  bool _isRecording = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _isInitialized = false;
  }

  @override
  void dispose() {
    _recorderSubscription?.cancel();
    _recordingSession.closeRecorder();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> initializer() async {
    if (!_isInitialized) {
      _isInitialized = true;
      if (widget.sessionStep.audioFileValid ?? false) {
        _recordedFilePath =
            getFilePath(FileKind.aac, widget.sessionStep.reference!.path!);
      }
      print(
          '(IF40)${widget.sessionStep.reference!.path}....${widget.sessionStep.audioFileValid},,,,${_recordedFilePath}');
      _recordingSession = FlutterSoundRecorder();
      await _recordingSession.openRecorder();
      await _recordingSession
          .setSubscriptionDuration(const Duration(milliseconds: 10));
    }
    // await [Permission.microphone, Permission.storage].request();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // const SizedBox(height: 40),

          Center(
            child: Text(
              _timerText,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              createElevatedButton(
                icon: _isRecording ? Icons.stop : Icons.mic,
                iconColor: Colors.black,
                onPressFunc: () async {
                  await initializer();
                  if (_isRecording) {
                    stopRecording();
                  } else {
                    startRecording();
                  }
                },
              ),
              // const SizedBox(width: 30),
              /*createElevatedButton(
                    icon: Icons.stop,
                    iconColor: Colors.black,
                    onPressFunc: stopRecording,
                  ),*/
              // const SizedBox(width: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    elevation: 9.0, backgroundColor: Colors.black),
                onPressed: _recordedFilePath == null
                    ? null
                    : () async {
                        await initializer();
                        setState(() {
                          _playAudio = !_playAudio;
                        });
                        if (_playAudio) playFunc();
                        if (!_playAudio) stopPlayFunc();
                      },
                icon: _playAudio
                    ? const Icon(Icons.stop, color: Colors.white)
                    : const Icon(Icons.play_arrow, color: Colors.white),
                label: _playAudio
                    ? const Text(
                        "Stop",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      )
                    : const Text(
                        "Play",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ElevatedButton createElevatedButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback? onPressFunc,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(6.0),
        side: const BorderSide(
          color: Colors.black,
          width: 4.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        elevation: 9.0,
      ),
      onPressed: onPressFunc,
      icon: Icon(
        icon,
        color: iconColor,
        size: 38.0,
      ),
      label: const Text(''),
    );
  }

  Future<void> goRecording(String path) async {
    try {
      await _recordingSession.startRecorder(
        toFile: path,
        codec: Codec.aacMP4,
      );
      setState(() {
        _isRecording = true;
      });
      _recorderSubscription?.cancel();
      _recorderSubscription = _recordingSession.onProgress?.listen((e) {
        var date = DateTime.fromMillisecondsSinceEpoch(
            e.duration.inMilliseconds,
            isUtc: true);
        var timeText = DateFormat('mm:ss', 'en_GB').format(date);
        setState(() {
          _timerText = timeText.substring(0, 5);
        });
      });
    } catch (e) {
      print('(IF1)Error starting recording: $e');
    }
  }

  Future<void> startRecording() async {
    // var appDir = await getApplicationDocumentsDirectory();
    var path = getFilePath(FileKind.aac, widget.sessionStep.reference!.path!);
    if (await isFileInAppDir(path)) {
      showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            // currentCachedHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text('Overwrite recording?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await goRecording(path);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Confirm',
                    ),
                  ),
                ],
              );
            });
          });
    } else {
      await goRecording(path);
    }

    // String path = '${appDir.path}/airStudio/$fileName';

    print('(IF20)${path}');
  }

  Future<void> stopRecording() async {
    try {
      _recordedFilePath = await _recordingSession.stopRecorder();
      _recorderSubscription?.cancel();
      final String path =
          getFilePath(FileKind.aac, widget.sessionStep.reference!.path!);
      final String backupPath = path.replaceAll('/aac', '/BACKUPaac');
      File backupFile = await File(path).copy(backupPath);

      setState(() {
        _isRecording = false;
        _timerText = '00:00';
      });
      print(
          '(IF10)${_recordingSession.recorderState}....${backupPath},,,,${await backupFile.length()}');
      printAppDirListing();
    } catch (e) {
      print('(IF2)Error stopping recording: $e');
    }
  }

  Future<void> playFunc() async {
    print('(IF21A)${_recordedFilePath}');
    if (_recordedFilePath != null) {
      try {
        Stream<void> playingStream = audioPlayer.onPlayerComplete;
        playingStream.listen((e) {
          setState(() {
            _playAudio = false;
          });
          print('(IF21C)');
        });
        await audioPlayer.play(DeviceFileSource(_recordedFilePath!));
        print('(IF21B)${_recordedFilePath}');
      } catch (e) {
        print('(IF3)Error playing audio: $e');
      }
    }
  }

  Future<void> stopPlayFunc() async {
    try {
      await audioPlayer.stop();
    } catch (e) {
      print('(IF4)Error stopping playback: $e');
    }
  }

  Widget uknownWidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          (currentUser!.role! == kRoleAdministrator)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FFButtonWidget(
                    text: 'check',
                    onPressed: () async {
                      String? message = currentUser!.userMessage;
                      //>print('(UM4)${message}');
                      if ((message != null) && (message != '')) {
                        //>print('(UM5)${message}');
                        showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            // currentCachedHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
                            //>print('(UM6)${message}');
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: Text('Message'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(message),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                        context,
                                        false,
                                      ),
                                      child: const Text(
                                        'Cancel',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        toast(
                                          context,
                                          '',
                                          ToastKind.success,
                                        );
                                        context.pop();
                                      },
                                      child: const Text(
                                        'Confirm',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                    options: FFButtonOptions(
                      //width: 200.0,
                      height: 30.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0,
                        0.0,
                        10.0,
                        0.0,
                      ),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                      ),
                      color: FlutterFlowTheme.of(
                        context,
                      ).primary,
                      textStyle: FlutterFlowTheme.of(
                        context,
                      ).titleSmall.override(
                            fontFamily: 'Rubik',
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                      elevation: 2.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                  ),
                )
              : Container(),
          (currentUser!.role! == kUserLevelSupervisor)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FFButtonWidget(
                    text: 'loadDB',
                    onPressed: () async {},
                    options: FFButtonOptions(
                      //width: 200.0,
                      height: 30.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0,
                        0.0,
                        10.0,
                        0.0,
                      ),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                      ),
                      color: FlutterFlowTheme.of(
                        context,
                      ).primary,
                      textStyle: FlutterFlowTheme.of(
                        context,
                      ).titleSmall.override(
                            fontFamily: 'Rubik',
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                      elevation: 2.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
