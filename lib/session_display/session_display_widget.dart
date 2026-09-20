// import 'dart:js_interop';

import 'dart:ffi';
import 'dart:ui' as ui;

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
import 'session_display_model.dart';
import '../../app_state.dart';
import '/app_state.dart';
// import 'package:flutter_intro/flutter_intro.dart';
import '/custom_code/widgets/permissions.dart';
export 'session_display_model.dart';
import 'dart:math';
import '../../appwrite_interface.dart';
// import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as models;
// import '/../custom_code/widgets/appwrite_realtime_subscribe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../menu.dart';
import '../../localDB.dart';
import '../../login/login_widget.dart';
//import '../../paypal/paypal_widget.dart';
import '../../session_step_display/session_step_display_widget.dart';
import '../../templates_page/templates_page_widget.dart';
// import 'package:ffmpeg_kit_flutter_new_min/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter_new_min/session.dart';
// import '../../platform/audio_recorder_platform.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'dart:convert';
// import 'package:ffmpeg_kit_flutter_new_min/return_code.dart';
import 'package:image/image.dart' as image2;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io' as Io;
import 'package:image/image.dart' as superImage;
import '../../clients_page/clients_page_widget.dart';
import '../purchase3.dart';
import 'package:davinci/davinci.dart';
import 'package:appwrite/appwrite.dart';
import 'generate_video.dart';

Utf8Encoder? _utf8Encoder;
int _count = 0;
bool _iHaveRequests = false;
List<DocumentReference?> _hyperbookListRequesting = [];
String failureMessage = '';

class SessionDisplayWidget extends StatefulWidget {
  const SessionDisplayWidget({super.key});

  @override
  _SessionDisplayWidgetState createState() => _SessionDisplayWidgetState();
}

class _SessionDisplayWidgetState
    extends State<SessionDisplayWidget> /*with AudioRecorderMixin*/ {
  late SessionDisplayModel _model;

  TextEditingController? enteredHyperbookTitleController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Intro? intro;
  _SessionDisplayWidgetState() {}

  int? externalSetState() {
    //>print('(R10X)${context}');
    setState(() {});
    return null;
  }

  // VideoPlayerController videoController = VideoPlayerController.file(File(''));

  @override
  void initState() {
    print('(XXDI-1)${hyperbookDisplayIsSubscribed}....${currentUser}');
    super.initState();
    _model = createModel(context, () => SessionDisplayModel());
    enteredHyperbookTitleController = TextEditingController();
    enteredHyperbookTitleController.text = '';

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
    super.dispose();
  }

/*

  Future<void> generateQuestionImage(BuildContext context,
      {String caption = 'Question', String filename = ''}) async {
    Uint8List u8List = await DavinciCapture.offStage(
      const PreviewWidget(),
      context: context,
      returnImageUint8List: true,
      openFilePreview: false,
    );
    print('(FU1)${filename}');
    File file = await File(filename).create();
    print('(FU2)${filename}');
    file.writeAsBytesSync(u8List);
    print('(FU3)${file.length()}');
    var response = await storeStorageFile(
      bucketId: airsRef.path!,
      storageFileId: ID.unique(),
      localFilePath: filename,
      deleteIfNecessary: true,
    );
    print('(FU4)${response}');
  }
*/

/*
  Future<bool> generateStepVideo(int step) async {
    SessionStepsRecord sessionStep = sessionStepsList![step];
    currentSessionStep = sessionStepsList![step];
    final String tempPhotoPath =
        '${tempDirPath}/photo_${(step).toString()}.jpg';
    String audioPath =
        getFilePath(FileKind.aac, sessionStepsList![step].reference!.path!);
    String tempAudioPath = '${tempDirPath}/audio_${(step).toString()}.wav';
    final String audioConvertCommand =
        '-y -i "${audioPath}" "${tempAudioPath}"';
    await executeFFmpeg(audioConvertCommand);
    String sourcePhotoFilePath =
        getFilePath(FileKind.photo, sessionStepsList![step].reference!.path!);
    if (!(await isFileInAppDir(sourcePhotoFilePath))) {
      if (lastPhotoPath == '') {
        toast(context, 'Photo missing from Step ${step.toString()}',
            ToastKind.error);
        return false;
      } else {
        sourcePhotoFilePath = lastPhotoPath;
      }
    } else {
      lastPhotoPath = sourcePhotoFilePath;
    }
    superImage.Image? image =
        superImage.decodeImage(File(sourcePhotoFilePath).readAsBytesSync());
    superImage.Image? resizedImage =
        superImage.copyResize(image!, width: 500, height: 500);
    File(tempPhotoPath).writeAsBytesSync(superImage.encodeJpg(resizedImage));
    Image modifiedImage = Image(
      image: ResizeImage(
        FileImage(File(tempPhotoPath)),
        width: 500,
        height: 500,
      ),
    );
    print('(VA15)${step},,,,${tempPhotoPath}<');
    dir = Directory.fromRawPath(utf8Encoder!.convert(tempDirPath!));
    await printTempDirListing();
    final String command =
        '-loop 1 -i "${tempPhotoPath}" -i "${tempAudioPath}" -shortest "${tempVideoPath}"';
    print('(VA17)${command}');
    String logString = 'Logs will appear here...';
    Session ffmpegSession = await FFmpegKit.execute(command);
    print('(VA18)${logString}');
    final output = await ffmpegSession.getOutput();
    final returnCode = await ffmpegSession.getReturnCode();
    final duration = await ffmpegSession.getDuration();
    print(
        '(VA19)${returnCode!.toString()}....${returnCode.getValue()},,,,${output!.length}----${output.characters.length}>>>>${duration}');
    logString += '\n✅ Processing completed!\n';
    logString += 'Return code: $returnCode\n';
    logString += 'Duration: ${duration}ms\n';
    logString += 'Output: $output\n';
    debugPrint('session: $output');
    print('(VA20)${logString}');
    String videoStorageId = generateVideoStorageFilename(sessions![currentSessionIndex]);
    print('(VA21)${videoStorageId},,,,${tempVideoPath}');
    return true;
  }
*/

  void dumpVC() {
    print('(VA100)${sessions}');
    if (sessions != null) {
      print('(VA101)${sessions!.length}');
      for (int i = 0; i < sessions!.length; i++) {
        print('(VA102)${sessions![i].videoController}');
      }
    }
  }

  Future<void> loadVideo(int index) async {
    currentSessionIndex = index;
    final String videoStorageId =
        'video${sessions![currentSessionIndex].reference!.path}.mp4';
    final String videoPlayPath = '${tempDirPath}/video.mp4';
    print('(VA200)${videoStorageId}....${videoPlayPath}');
    bool okVideo = await copySessionStepStorageFiletoLocal(
      bucketId: artTheopyAIRvideosRef.path,
      fileId: videoStorageId,
      localPath: videoPlayPath,
      fileKind: FileKind.video,
    );
    print(
        '(VA201A)${okVideo}....${videoStorageId},,,,${videoPlayPath}++++${sessions![index].videoController}');
/*    sessions![index].videoController =
        VideoPlayerController.file(File(videoPlayPath),)
          ..initialize().then((_) {
            print('(VA202)${index},,,,${sessions![index].videoController}....${videoPlayPath}');
            setState(() {
              */ /*  sessions![currentSessionIndex].videoController!.value.isPlaying
                  ? sessions![currentSessionIndex].videoController!.pause()
                  :*/ /*

            });
          });*/
    sessions![index].videoController = await VideoPlayerController.file(
      File(videoPlayPath),
    );
    print('(VA201B)${await sessions![index].videoController!.dataSource}');
    await sessions![index].videoController!.initialize();
    print('(VA201C)${await sessions![index].videoController!.value}');

    dumpVC();
  }

  Widget showAIRDeleteButton(int index) {
    return FlutterFlowIconButton(
        showLoadingIndicator: true,
        caption: 'Delete AIR',
        tooltipMessage: 'Remove all stored data',
        borderColor: Colors.transparent,
        borderRadius: 0.0,
        borderWidth: 1.0,
        buttonSize: 40.0,
        buttonWidth: kSessionIconButtonWidth,
        icon: kIconDelete,
        onPressed: /*(!session.videoCreated!) ? null :*/
            () async {
          BuildContext enclosingContext = context;
          print('(DA22)${context}');
          showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Text('Delete AIR'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Text('Deleting an AIR Cannot be undone')],
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
                          print('(DA23)');
                          //SessionsRecord session = sessions![index];
                          await deleteAIR(index);
                          setState((){});
                          context.pop();
                        },
                        child: const Text('Confirm'),
                      )
                    ],
                  );
                });
              });
        });
  }

  Widget showCreateArchiveButton(int index) {
    return FlutterFlowIconButton(
        showLoadingIndicator: true,
        caption: 'Save AIR in cloud',
        tooltipMessage: 'Archive complete AIR',
        borderColor: Colors.transparent,
        borderRadius: 0.0,
        borderWidth: 1.0,
        buttonSize: 40.0,
        buttonWidth: kSessionIconButtonWidth,
        icon: Icon(Icons.archive_outlined),
        onPressed: /*(!session.videoCreated!) ? null :*/
            () async {
          SessionStepsRecord firstSessionStep =
              (await listSessionStepList(thisSessionIndex: index)).first;
          bool archiveExists = await doesStorageFileExist(
              bucketId: airsRef.path,
              fileId: 'aac' + firstSessionStep.reference!.path! + '.aac');
          print(
              '(DA40)${'aac' + firstSessionStep.reference!.path! + '.aac'}....${archiveExists}');
          showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                      title: Text('Store AIR in cloud'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              archiveExists ? 'Overwrite existing archive' : '')
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
                            child: const Text('Confirm'),
                            onPressed: () async {
                              await storeAIRInCloud(index);
                              context.pop();
                            })
                      ]);
                });
              });
        });
  }

  Widget showArchiveRestoreButton(int index) {
    return FlutterFlowIconButton(
        showLoadingIndicator: true,
        caption: 'Restore AIR from cloud',
        tooltipMessage: 'Restore complete AIR',
        borderColor: Colors.transparent,
        borderRadius: 0.0,
        borderWidth: 1.0,
        buttonSize: 40.0,
        buttonWidth: kSessionIconButtonWidth,
        icon: Icon(Icons.archive_outlined),
        onPressed: /*(!session.videoCreated!) ? null :*/
            () async {
          SessionStepsRecord firstSessionStep =
              (await listSessionStepList(thisSessionIndex: index)).first;
          bool archiveExists = await doesStorageFileExist(
              bucketId: airsRef.path,
              fileId: 'aac' + firstSessionStep.reference!.path! + '.aac');
          print(
              '(DA60)${'aac' + firstSessionStep.reference!.path! + '.aac'}....${archiveExists}');
          showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                      title: Text('Restore AIR from cloud'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(archiveExists
                              ? 'Restore from cloud'
                              : 'No archive exists')
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
                            child: const Text('Confirm'),
                            onPressed: () async {
                              print('(DA50)');
                              await restoreAIRFromCloud(index);
                              context.pop();
                            })
                      ]);
                });
              });
        });
  }

  Widget displaySession(SessionsRecord session, int sessionIndex) {
    print('(VC50A)${sessionIndex}....${session}');
    if (session.videoCreated == null) {
      session.videoCreated = false;
    }
    if (session.sessionModified == null) {
      session.sessionModified = false;
    }
    print(
        '(VC50B)${session.videoCreated}....${session.sessionModified},,,,${((session.videoCreated!) && (!session.sessionModified!))}');
    print('(MV99)${sessions![sessionIndex].videoCreated!}');
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        width: MediaQuery.sizeOf(context).width * 1.0,
        // height: 350.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 15.0,
              color: Color(0x1F000000),
              offset: Offset(0.0, 4.0),
            )
          ],
          border: Border.all(
            color: FlutterFlowTheme.of(context).lineColor,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // key: infoCount == 1
                    // ? intro!.keys[2]
                    // : UniqueKey(),
                    child: Text(
                      'Client: ${session.clientDisplayName}',
                      softWrap: false,
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                  SingleChildScrollView(
                    // key: infoCount == 1
                    //     ? intro!.keys[3]
                    //     : UniqueKey(),
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      softWrap: false,
                      'Date: ${(DateFormat.yMMMd().format(session.$createdAt!))}',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // key: infoCount == 1
                      //     ? intro!.keys[4]
                      //     : UniqueKey(),
                      children: <Widget>[
                        Text(
                          '',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Row(children: [
                    FlutterFlowIconButton(
                      caption: 'Edit',
                      tooltipMessage: 'Edit session',
                      borderColor: Colors.transparent,
                      borderRadius: 0.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      buttonWidth: kSessionIconButtonWidth,
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        FFAppState().update(() {});
                        // print('(S1A)${session.clientId}');

                        // currentSession = session;
                        currentSessionIndex = sessionIndex;
                        currentTherapist =
                            await getUser(document: session.therapistId);
                        currentClient =
                            await getUser(document: session.clientId);
                        await updateDocument(
                            collection: sessionsRef,
                            document: sessions![currentSessionIndex].reference,
                            data: {
                              kSessionSessionModified: true,
                            });

                        // print('(S1C)${session.clientId}');
                        if (currentUser!.archiveSessions ?? false) {
                          await restoreAIRFromCloud(sessionIndex);
                        }
                        Navigator.push(
                            context,
                            PageTransition(
                              type: kStandardPageTransitionType,
                              duration: kStandardTransitionTime,
                              reverseDuration: kStandardReverseTransitionTime,
                              child: SessionStepDisplayWidget(),
                            )).then((_) => setState(() {}));
                      },
                    ),
                  ]),
                  SizedBox(height: kIconButtonGap),
                  FlutterFlowIconButton(
                      // showLoadingIndicator: true
                      caption: ((session.videoCreated!) &&
                              (!session.sessionModified!))
                          ? 'Video available'
                          : 'Make video',
                      tooltipMessage: 'Speech to text',
                      borderColor: Colors.transparent,
                      borderRadius: 0.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      buttonWidth: kSessionIconButtonWidth,
                      icon: Icon(Icons.movie),
                      onPressed: () async {
                        await listSessionStepList(thisSessionIndex: sessionIndex);
                        failureMessage = '';
                        await makeVideo(
                            context: context,
                            externalSetState: setState,
                            index: sessionIndex,
                            sessionIndex: sessionIndex,
                            session: session,
                            setState: setState,
                            totalSteps: sessions![sessionIndex].totalSteps);
                        Navigator.pop(context);
                      }
                      /*((sessions![index].videoCreated!) &&
                            (!session.sessionModified!))
                        ? null
                        : () async {
                            currentSessionIndex = index;
                            // showAlertDialog(context);
                            sessionStepsList = await listSessionStepList(
                                thisSession: sessions![index]);
                            await emptyTempDirOFPhotosVideosConcat();
                            _utf8Encoder = utf8.encoder;
                            dir = Directory.fromRawPath(
                                _utf8Encoder!.convert(tempDirPath!));
                            String concatList = '';
                            for (int i = 0; i < sessionStepsList!.length; i++) {
                              bool ok = await generateStepVideo(i);
                              if (!ok) {
                                Navigator.pop(context);
                                return;
                              }+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                              concatList = concatList +
                                  'file ${tempDirPath}/video_${i.toString()}.mp4\n';
                            }
                            final File concatFile =
                                await File("${tempDirPath}/concat.txt")
                                    .writeAsString(concatList);
                            final String concatedVideo = "${tempDirPath}/video.mp4";
                            final String concatCommand =
                                '-y -f concat -safe 0 -i "${tempDirPath}/concat.txt" -c copy "${concatedVideo}"';
                            await executeFFmpeg(concatCommand);
                            models.FileList fileList = await listStorageFiles(
                                bucketId: artTheopyAIRvideosRef.path);
                            String fileId = '';
                            for (int i = 0; i < fileList.files.length; i++) {
                              if ((fileList.files[i].$id).contains(
                                  sessions![currentSessionIndex]
                                      .reference!
                                      .path!)) {
                                fileId = fileList.files[i].$id;
                                break;
                              }
                            }
                            if (fileId.length > 0) {
                              await deleteStorageFile(
                                  bucketId: artTheopyAIRvideosRef.path,
                                  fileId: fileId);
                            }
                            // getAppDirListing();
                            int len = await File(concatedVideo).length();
                            var response = await storeStorageFile(
                              bucketId: artTheopyAIRvideosRef.path!,
                              storageFileId: generateVideoStorageFilename(
                                session,
                              ),
                              localFilePath: concatedVideo,
                            );
                            await updateDocument(
                                collection: sessionsRef,
                                document: sessions![currentSessionIndex].reference,
                                data: {
                                  kSessionSessionModified: false,
                                  kSessionVideoCreated: true
                                });
                            setState(() {
                              sessions![currentSessionIndex].videoCreated = true;
                              sessions![currentSessionIndex].sessionModified =
                                  false;
                            });
                            Navigator.pop(context);
                          },*/
                      ),
                  SizedBox(height: kIconButtonGap),
                  FlutterFlowIconButton(
                      showLoadingIndicator: true,
                      caption: (sessions![sessionIndex].videoCreated!)
                          ? 'Load video'
                          : 'Video not available',
                      tooltipMessage: 'Load video',
                      borderColor: Colors.transparent,
                      borderRadius: 0.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      buttonWidth: kSessionIconButtonWidth,
                      icon: (sessions![sessionIndex].videoController == null)
                          ? Icon(Icons.local_movies)
                          : (sessions![sessionIndex]
                                  .videoController!
                                  .value
                                  .isPlaying
                              ? Icon(Icons.pause)
                              : Icon(Icons.slow_motion_video)),
                      onPressed: /*(!session.videoCreated!) ? null :*/
                          () async {
                        print(
                            '(VA203A)${sessionIndex},,,,${sessions![sessionIndex].videoController}');
                        await loadVideo(sessionIndex);
                        print(
                            '(VA203B)${sessionIndex},,,,${sessions![sessionIndex].videoController}');
                        showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: Text('Video'),
                                  content: Container(
                                    width: 400,
                                    height: 400,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black)),
                                    child: sessions![currentSessionIndex]
                                            .videoController!
                                            .value
                                            .isInitialized
                                        ? AspectRatio(
                                            aspectRatio:
                                                sessions![currentSessionIndex]
                                                    .videoController!
                                                    .value
                                                    .aspectRatio,
                                            child: VideoPlayer(
                                                sessions![currentSessionIndex]
                                                    .videoController!),
                                          )
                                        : Container(color: Colors.amber),
                                  ),
                                  actions: [
                                    FlutterFlowIconButton(
                                      showLoadingIndicator: true,
                                      caption: (sessions![sessionIndex]
                                              .videoCreated!)
                                          ? 'Play video'
                                          : 'Video not available',
                                      tooltipMessage: 'Load video',
                                      borderColor: Colors.transparent,
                                      borderRadius: 0.0,
                                      borderWidth: 1.0,
                                      buttonSize: 40.0,
                                      buttonWidth: kSessionIconButtonWidth,
                                      icon: (sessions![sessionIndex]
                                                  .videoController ==
                                              null)
                                          ? Icon(Icons.local_movies)
                                          : (sessions![sessionIndex]
                                                  .videoController!
                                                  .value
                                                  .isPlaying
                                              ? Icon(Icons.pause)
                                              : Icon(Icons.play_arrow)),
                                      onPressed: /*(!session.videoCreated!) ? null :*/
                                          () async {
                                        sessions![currentSessionIndex]
                                            .videoController!
                                            .play();
                                      },
                                    ),
                                  ],
                                );
                              });
                            });
                      }),
                  SizedBox(height: kIconButtonGap),
                  FlutterFlowIconButton(
                      showLoadingIndicator: true,
                      caption: 'Send email',
                      tooltipMessage: 'Send email with link to video',
                      borderColor: Colors.transparent,
                      borderRadius: 0.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      buttonWidth: kSessionIconButtonWidth,
                      icon: Icon(Icons.email_outlined),
                      onPressed: () async {
                        // currentSession = session;
                        currentSessionIndex = sessionIndex;
                        String videoURL = '';
                        models.FileList fileList = await listStorageFiles(
                            bucketId: artTheopyAIRvideosRef.path);
                        bool videoAvailable = false;
                        if (fileList.files.length > 0) {
                          for (int i = 0; i < fileList.files.length; i++) {
                            String fileId = fileList.files[i].$id;
                            if ((fileId.contains('video')) &&
                                (fileId.contains(sessions![currentSessionIndex]
                                    .reference!
                                    .path!))) {
                              videoAvailable = true;
                              final String BUCKET_ID =
                                  artTheopyAIRvideosRef.path!;
                              final String FILE_ID = fileId;
                              final String PROJECT_ID = kProjectID;
                              if (FILE_ID.length > 0) {
                                videoURL =
                                    'https://cloud.appwrite.io/v1/storage/buckets/${BUCKET_ID}/files/${FILE_ID}/view?project=${PROJECT_ID}';
                              }
                            }
                          }
                        }
                        print('(ES1)${videoURL}');
                        BuildContext enclosingContext = context;
                        showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: Text('Send Email'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      videoAvailable
                                          ? Text(
                                              'Send Email with link to the created Video?')
                                          : Text('No video avialable')
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    videoAvailable
                                        ? TextButton(
                                            onPressed: () async {
                                              print(
                                                  '(ES2)${currentUser!.displayName}....${currentUser!.email!}====${videoURL}');
                                              sendEmail(
                                                  context: enclosingContext,
                                                  emailType:
                                                      EmailType.customBody,
                                                  senderDisplayName:
                                                      currentUser!.displayName!,
                                                  senderEmail:
                                                      currentUser!.email!,
                                                  receiverEmail:
                                                      currentUser!.email!,
                                                  hyperbookName: '',
                                                  body:
                                                      'Video available here: ${videoURL}');
                                              context.pop();
                                            },
                                            child: const Text('Confirm'),
                                          )
                                        : Container(),
                                  ],
                                );
                              });
                            });
                      }),
                  SizedBox(height: kIconButtonGap),
                  FlutterFlowIconButton(
                      showLoadingIndicator: true,
                      caption: 'Archive',
                      tooltipMessage: 'Archive functions',
                      borderColor: Colors.transparent,
                      borderRadius: 0.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      buttonWidth: kSessionIconButtonWidth,
                      icon: Icon(Icons.archive),
                      onPressed: () async {
                        // currentSession = session;
                        currentSessionIndex = sessionIndex;
                        String videoURL = '';
                        models.FileList fileList = await listStorageFiles(
                            bucketId: artTheopyAIRvideosRef.path);
                        bool videoAvailable = false;
                        if (fileList.files.length > 0) {
                          for (int i = 0; i < fileList.files.length; i++) {
                            String fileId = fileList.files[i].$id;
                            if ((fileId.contains('video')) &&
                                (fileId.contains(sessions![currentSessionIndex]
                                    .reference!
                                    .path!))) {
                              videoAvailable = true;
                              final String BUCKET_ID =
                                  artTheopyAIRvideosRef.path!;
                              final String FILE_ID = fileId;
                              final String PROJECT_ID = kProjectID;
                              if (FILE_ID.length > 0) {
                                videoURL =
                                    'https://cloud.appwrite.io/v1/storage/buckets/${BUCKET_ID}/files/${FILE_ID}/view?project=${PROJECT_ID}';
                              }
                            }
                          }
                        }
                        print('(ES1)${videoURL}');
                        BuildContext enclosingContext = context;
                        showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: Text('Archive Functions'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      showCreateArchiveButton(sessionIndex),
                                      SizedBox(height: kIconButtonGap),
                                      showArchiveRestoreButton(sessionIndex),
                                      SizedBox(height: kIconButtonGap),
                                      showAIRDeleteButton(sessionIndex),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: const Text('Return'),
                                    ),
                                  ],
                                );
                              });
                            });
                      }),

                  /*        Container(
                    //color: Colors.amber,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: 155,
                      child: FittedBox(
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        child: SizedBox(
                          height: (sessions![index].videoController == null)
                              ? 100
                              : sessions![index].videoController!.value.size.height,
                          width: (sessions![index].videoController == null)
                              ? 100
                              : sessions![index].videoController!.value.size.width,
                          child: (sessions![index].videoController == null)
                              ? Container()
                              : Container(),
                        ),
                      ),
                    ),
                  ),*/
                ]),
           // SizedBox(width: 20),
            Container(
              width: 110,
              height: 220,
              color: FlutterFlowTheme.of(context).primary.withAlpha(0X20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(session.progressText1),
                    Text(session.progressText2),
                    Text(session.progressText3),
                    (session.progressValue > 0.001)
                        ? CircularProgressIndicator(
                            value: session.progressValue)
                        : Container(),
                  ],
                ),
              ),
            )
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
  TemplatesRecord? chosenTemplate;
  UsersRecord? chosenClient;

  void createSessionPopUp(Function enclosingSetState) async {
    TextEditingController clientController = TextEditingController();
    List<TemplatesRecord> templatesList =
        await listOwnedPlusMasterTemplateList();
    if ((templatesList.length ?? 0) > 0) {
      chosenTemplate = templatesList.first;
    }
    List<UsersRecord> clientsList =
        await listUsersClientsOfUser(therapist: currentUser!.reference);
    if ((clientsList.length ?? 0) > 0) {
      chosenClient = clientsList.first;
    }
    bool iSOKToCreateAIR = await checkIfCanCreateSession();
    logString(
        '(PS-102)${currentUser!.cumulativeSessions}....${iSOKToCreateAIR}');
    if (!iSOKToCreateAIR) {
      toast(context, 'Please upgrade app', ToastKind.warning);
      Navigator.push(
          context,
          PageTransition(
            type: kStandardPageTransitionType,
            duration: kStandardTransitionTime,
            reverseDuration: kStandardReverseTransitionTime,
            child: Purchase3(),
          ));
    } else {
      showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            // currentCachedHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
            //>print('(UM6)${message}');
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text('Create AIR'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Please select client'),
                    (clientsList.length == 0)
                        ? Text('No clients available')
                        : DropdownButton<UsersRecord>(
                            //   key: ValueKey(widget),
                            value: chosenClient,
                            hint: const Text('Please select client'),
                            items: clientsList!
                                .map<DropdownMenuItem<UsersRecord>>(
                                    (UsersRecord item) {
                              return DropdownMenuItem<UsersRecord>(
                                value: item,
                                child: Text(
                                  item.displayName!,
                                  // style: FlutterFlowTheme.bodyText1,
                                ),
                              );
                            }).toList(),
                            elevation: 2,
                            onChanged: (UsersRecord? value) {
                              setState(() {
                                chosenClient = value;
                                // FFAppState().chosenModerator = chosenModerator!.reference;
                              });
                              //%//>//>print('(D352)chosenTemplate');
                            },
                            isExpanded: true,
                            focusColor: Colors.transparent,
                          ),
                    SizedBox(height: kIconButtonGap),
                    Text('Please select template'),
                    (templatesList.length == 0)
                        ? Text('No templates available')
                        : DropdownButton<TemplatesRecord>(
                            //  key: ValueKey(widget),
                            value: chosenTemplate,
                            hint: const Text('Please select template'),
                            items: templatesList!
                                .map<DropdownMenuItem<TemplatesRecord>>(
                                    (TemplatesRecord item) {
                              return DropdownMenuItem<TemplatesRecord>(
                                value: item,
                                child: Text(
                                  item.name!,
                                  // style: FlutterFlowTheme.bodyText1,
                                ),
                              );
                            }).toList(),
                            elevation: 2,
                            onChanged: (TemplatesRecord? value) {
                              setState(() {
                                chosenTemplate = value;
                                // FFAppState().chosenModerator = chosenModerator!.reference;
                              });
                              print('(D352)chosenTemplate');
                            },
                            isExpanded: true,
                            focusColor: Colors.transparent,
                          ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      print('(QQ4)${chosenTemplate!.reference!.path}');
                      SessionsRecord session = await createSession(
                          clientId: chosenClient!.reference,
                          therapistId: currentUser!.reference,
                          templateId: chosenTemplate!.reference);
                      print('(CC12)${session.reference}');
                      enclosingSetState();
                      setState(() {});
                      toast(context, 'Created AIR', ToastKind.success);
                      context.pop();
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              );
            });
          });
    }
  }

  Future<List<SessionsRecord>> loadSessions() async {
    List<SessionsRecord> sessionList =
        await listSessionList(justCurrentUserAsTherapist: true);
    models.FileList videoFileList =
        await listStorageFiles(bucketId: artTheopyAIRvideosRef.path);
    for (int i = 0; i < sessionList.length; i++) {
      //sessionList[i].videoCreated = false;
      for (int j = 0; j < videoFileList.files.length; j++) {
        String v = videoFileList.files[j].$id;
        String s = sessionList[i].reference!.path!;
        bool c = v.contains(s);
        print('(VC100A)$i,,,,$j----${v}....${s}****${c}');
        /* if (c){
          print('(VC100B)${sessionsRef}....${currentSession!.reference}****${kSessionVideoCreated})}');*/
        /*await updateDocument(
              collection: sessionsRef,
              document: currentSession!.reference,
              data: {kSessionVideoCreated: true});
          sessionList[i].videoCreated = true;*/
        // }
        print('(VC51)');
      }
    }
    return sessionList;
  }

  void enclosingSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('(AAT20)${currentUser}');
    print('(AAT21)${currentUser!.email}');
    String requestedRole = '';
    _hyperbookListRequesting.clear();
    _iHaveRequests = false;
    void showRoleRequestDialog() {}

    int infoCount = 0;
    MenuDetails sessionDisplayMenuDetails = MenuDetails(
      menuLabelList: [
        'Templates',
        'Clients',
        'Login',
      ],
      menuIconList: [
        Icon(Icons.list_alt),
        kIconProfile,
        kIconLogin,
      ],
      menuTargets: [
        (context) {
          Navigator.push(
              context,
              PageTransition(
                type: kStandardPageTransitionType,
                duration: kStandardTransitionTime,
                reverseDuration: kStandardReverseTransitionTime,
                child: TemplatesPageWidget(),
              ));
        },
        (context) {
          Navigator.push(
              context,
              PageTransition(
                type: kStandardPageTransitionType,
                duration: kStandardTransitionTime,
                reverseDuration: kStandardReverseTransitionTime,
                child: ClientsPageWidget(),
              ));
        },
        (context) {
          //# context.goNamedAuth('login', context.mounted);
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

    return FutureBuilder<List<SessionsRecord>>(
        future: loadSessions(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print('(VA400)${snapshot}');
            oldSessions = sessions;
            sessions = snapshot.data;
            print('(VA401)${sessions}');
            print('(VA402`)${sessions!.length}');
            if ((oldSessions != null) && (oldSessions!.length > 0)) {
              for (int i = 0; i < oldSessions!.length; i++) {
                print('(VA403`)${i}....${oldSessions![i].videoController}');
                if ((oldSessions![i].videoController != null) &&
                    (sessions != null) &&
                    (sessions!.length > 0)) {
                  sessions![i].videoController =
                      oldSessions![i].videoController;
                }
              }
            }
            return Title(
                title: 'session_display',
                color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
                child: Scaffold(
                    key: scaffoldKey,
                    backgroundColor: const Color(0xFFF5F5F5),
                    /*                   floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          sessions![currentSessionIndex]
                                  .videoController!
                                  .value
                                  .isPlaying
                              ? sessions![currentSessionIndex]
                                  .videoController!
                                  .pause()
                              : sessions![currentSessionIndex]
                                  .videoController!
                                  .play();
                        });
                      },
                      child: Icon(
                        (currentSessionIndex == -1)
                            ? Icons.code_off
                            : (sessions![currentSessionIndex].videoController ==
                                    null)
                                ? Icons.cloud_off_outlined
                                : (sessions![currentSessionIndex]
                                        .videoController!
                                        .value
                                        .isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow),
                      ),
                    ),
 */
                    appBar: AppBar(
                      leading: BackButton(color: Colors.white),
                      backgroundColor: FlutterFlowTheme.of(context).primary,
                      automaticallyImplyLeading: false,
                      title: Text(
                        'AIRs',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Rubik',
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                      ),
                      actions: [
                        // insertOutstandingRequestsButton(context),

                        FlutterFlowIconButton(
                          caption: 'Add\nAIR',
                          enabled: true,
                          fillColor: Colors.white,
                          tooltipMessage: 'Create AIR',
                          borderColor: FlutterFlowTheme.of(context).primary,
                          borderRadius: 20,
                          borderWidth: 1,
                          buttonSize: 50,
                          buttonWidth: 100,
                          onPressed: () {
                            createSessionPopUp(enclosingSetState);
                          },
                          icon: kIconAdd,
                        ),
                        SizedBox(width: kIconButtonGap),
                        insertMenu(
                            context: context,
                            menuDetails: sessionDisplayMenuDetails,
                            externalSetState: setState,
                            caption: 'Menu',
                            width: 100,
                            height: 50),
                      ],
                      centerTitle: false,
                      elevation: 2.0,
                    ),
                    body: SafeArea(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: SingleChildScrollView(
                          // controller: hyperbookDisplayscrollController,
                          physics: ScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Wrap(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    /* Container(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('XXX1'),
                                    ),
                                    SizedBox(width: 20),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FFButtonWidget(
                                        // key: intro!.keys[1],
                                        tooltipMessage:
                                        'Click to create a new hyperbook',
                                        onPressed: () async {
                                          print(('AAT1'));
                                        },
                                        text: 'Create session',
                                        options: FFButtonOptions(
                                          //width: 200.0,
                                          height: 30.0,
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10.0, 0.0, 10.0, 0.0),
                                          iconPadding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme
                                              .of(context)
                                              .primary,
                                          textStyle: FlutterFlowTheme
                                              .of(context)
                                              .titleSmall
                                              .override(
                                            fontFamily: 'Rubik',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          elevation: 2.0,
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),*/
                                    (currentUser!.role! == kRoleAdministrator)
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FFButtonWidget(
                                              text: 'check',
                                              onPressed: () async {
                                                String? message =
                                                    currentUser!.userMessage;
                                                //>print('(UM4)${message}');
                                                if ((message != null) &&
                                                    (message != '')) {
                                                  //>print('(UM5)${message}');
                                                  showDialog<bool>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        // currentCachedHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
                                                        //>print('(UM6)${message}');
                                                        return StatefulBuilder(
                                                            builder: (context,
                                                                setState) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('Message'),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(message)
                                                              ],
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        false),
                                                                child: const Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  toast(
                                                                      context,
                                                                      '',
                                                                      ToastKind
                                                                          .success);
                                                                  context.pop();
                                                                },
                                                                child: const Text(
                                                                    'Confirm'),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                      });
                                                }
                                              },
                                              options: FFButtonOptions(
                                                //width: 200.0,
                                                height: 30.0,
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'Rubik',
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                elevation: 2.0,
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
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
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'Rubik',
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                elevation: 2.0,
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  child: (sessions!.length < 1)
                                      ? Text('No AIRs available',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium)
                                      : ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: sessions!.length,
                                          //#cachedHyperbookList.length,
                                          itemBuilder: (BuildContext context,
                                              int listViewIndex) {
                                            print(
                                                '(VC101)${sessions![listViewIndex].reference!.path}....${sessions![listViewIndex].videoCreated}');
                                            return displaySession(
                                                sessions![listViewIndex],
                                                listViewIndex);
                                          }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )));
          }
        });
  }
}

class BackupFileDetail {
  String? hyperbookName;
  int? versionNumber;
  DocumentReference hyperbookReference;
  models.File? file;
  BackupFileDetail(this.hyperbookName, this.versionNumber,
      this.hyperbookReference, this.file);
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
          '(CP2)${cpList[i].count}>>>>${cpList[i].chapterPath}<<<<<${cpList[i].parentPath}');
    }
  }
}

Future<void> deleteAIR(int sessionIndex) async {
  Utf8Encoder? utf8Encoder = utf8.encoder;
  List<SessionStepsRecord> sessionSteps =
      await listSessionStepList(thisSessionIndex: sessionIndex);
  utf8Encoder = utf8.encoder;
  Directory appDir = Directory.fromRawPath(utf8Encoder!.convert(appDirPath!));
  List<String> appDirPathList = await getAppDirListing();
  for (int j = 0; j < sessionSteps.length; j++) {
    await deleteDocument(
        collection: sessionStepsRef, document: sessionSteps[j].reference);
    print('(DA2)${j}....${sessionSteps[j].reference!.path}');
    for (int k = 0; k < appDirPathList.length; k++) {
      print(
          '(DA3)${k}....${appDirPathList[k]},,,,${sessionSteps[j].reference!.path}');
      if ((appDirPathList[k]).contains(sessionSteps[j].reference!.path!)) {
        await deleteFile(appDirPathList[k]);
        print('(DA4)${k}....${appDirPathList[k]}');
      }
    }

  }
  await deleteDocument(
      collection: sessionsRef,
      document: sessions![currentSessionIndex].reference);

  print('(DA5)${sessions![currentSessionIndex].reference!.path}');
}

Future<void> restoreAIRFromCloud(int? index) async {
  //SessionsRecord session = sessions![index ?? 0];
  List<SessionStepsRecord> sessionSteps =
      await listSessionStepList(thisSessionIndex: index?? 0);
  _utf8Encoder = utf8.encoder;
  List<String> appDirPathList = await getAppDirListing();
  for (int j = 0; j < sessionSteps.length; j++) {
    // print('(DA51A)${j}....${sessionSteps[j].reference!.path}');
    models.FileList filesOfStorageStep = await listStorageFilesOfStorageStep(
        bucketId: airsRef.path, sessionStepId: sessionSteps[j].reference!.path);
    for (int k = 0; k < filesOfStorageStep.files.length; k++) {
      // print('(DA52A)${k}....${filesOfStorageStep.files[k]},,,,${sessionSteps[j].reference!.path}');
      for (int l = 0; l < appDirPathList.length; l++) {
        final String filePath =
            appDirPath! + '/' + filesOfStorageStep.files[k].$id;
        await copyAnyStorageFiletoLocal(
          bucketId: airsRef.path,
          fileId: filesOfStorageStep.files[k].$id,
          localPath: filePath,
        );
        // print('(DA53A)${k}....${l},,,,${filesOfStorageStep.files[k].$id}++++${filePath}');
      }
    }
  }
}

Future<void> storeAIRInCloud(int index) async {
  print('(DA50A)');
  SessionsRecord session = sessions![index];
  List<SessionStepsRecord> sessionSteps =
      await listSessionStepList(thisSessionIndex: index);
  _utf8Encoder = utf8.encoder;
  List<String> appDirPathList =
      await getSessionStepAppDirListing(session.reference!.path!);
  for (int j = 0; j < sessionSteps.length; j++) {
    print('(DA51B)${j}....${sessionSteps[j].reference!.path}');
    for (int k = 0; k < appDirPathList.length; k++) {
      final String storageFileId = appDirPathList[k].split('/').last;
      print(
          '(DA53B)${k}....${appDirPathList[k]},,,,${sessionSteps[j].reference!.path}++++${storageFileId}');
      // bool fileExists = false;
      // for (int m = 0; m < storageFilesOfStep.files.length; m++){
      //   if (storageFilesOfStep.files[m].$id.contains(storageFileId)){
      //     fileExists = true;
      //     break;
      //   }
      // }
      // if (fileExists) {
      //   print('(DA54B)${storageFileId}');
      //   await deleteStorageFile(bucketId: airsRef.path, fileId: storageFileId);
      // }

      print('(DA55B)');
      var response = await storeStorageFile(
        bucketId: airsRef.path!,
        storageFileId: storageFileId,
        localFilePath: appDirPathList[k],
        deleteIfNecessary: true,
      );
      print('(DA56B)${k}....${appDirPathList[k]},,,,${response}');
    }
  }
  await printAppDirListing();
}
