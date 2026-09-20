import 'dart:ffi';
import 'dart:ui' as ui;

import 'package:airstudio/session_display/session_display_widget.dart';
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
import 'package:ffmpeg_kit_flutter_new_video/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_video/session.dart';
// import '../../platform/audio_recorder_platform.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'dart:convert';
import 'package:ffmpeg_kit_flutter_new_video/return_code.dart';
import 'package:image/image.dart' as image2;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io' as Io;
import 'package:image/image.dart' as superImage;
import '../../clients_page/clients_page_widget.dart';
import '../purchase3.dart';
// import 'package:davinci/davinci.dart';
import 'package:appwrite/appwrite.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

List<SessionStepsRecord>? sessionStepsList;
Utf8Encoder? utf8Encoder;
// String? tempDirPath;
const maxSessionsPerUser = 500;

Directory? dir;

String lastPhotoPath = '';
ProgressDialog? progressDialog;

void showProgress({
  required BuildContext? context,
  required Function? externalSetState,
  required int sessionIndex,
  required String message1,
  required String message2,
  required String message3,
  required double progressValue,
  required bool isError,
}) {
  //externalSetState!(() {

  if (isError) {
    showDialog<bool>(
        context: context!,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Error in video creation'),
              actions: <Widget>[],
              content: Container(
                  width: 500,
                  height: 1000,
                  child: SingleChildScrollView(
                      child: Text(message1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w400)))));
        });
  } else {
    progressDialog!.update(
      message: message1,
      progress: progressValue,
      progressWidget: Container(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
              backgroundColor: Colors.yellow,
              strokeWidth: 5,
              value: progressValue)),
    );
  }
  sessions![sessionIndex].progressText1 = message1;
  sessions![sessionIndex].progressText2 = message2;
  sessions![sessionIndex].progressText3 = message3;
  sessions![sessionIndex].progressValue = progressValue;
  print('(FFM8)${message1}....${progressValue}');
  //});
}

Future<void> ffmpegCommand(
    {required BuildContext? context,
    required Function? externalSetState,
    required String? command,
    required int? step,
    required String? operation,
    required int sessionIndex,
    required int totalSteps}) async {
  String logString = 'Logs will appear here...';
  Session ffmpegSession = await FFmpegKit.execute(command!);
  print('(FFM1)${command}');

  final output = await ffmpegSession.getOutput();
  final returnCode = await ffmpegSession.getReturnCode();
  final duration = await ffmpegSession.getDuration();
  print(
      '(FFM2)${returnCode!.toString()}....${returnCode.getValue()},,,,${output!.length}----${output.characters.length}>>>>${duration}');
  //  setState(() {
  logString += '\n✅ Processing completed!\n';
  logString += 'Return code: $returnCode\n';
  logString += 'Duration: ${duration}ms\n';
  logString += 'Output: $output\n';
  //  isProcessing = false;
  //});
  debugPrint('(FFM3)$output');
  print('(FFM4)${step},,,,${totalSteps}++++${returnCode}^^^^${logString}....');
  if (returnCode.getValue() != 0) {
    failureMessage = 'Error: Q${step! + 1}, ${output}';
    print('(M1)${returnCode.getValue()}....${failureMessage}');
  }
  showProgress(
      context: context,
      externalSetState: externalSetState,
      sessionIndex: sessionIndex,
      message1: (failureMessage == '')
          ? 'Question: ${((step!) + 1).toString()}'
          : failureMessage,
      message2: operation!,
      message3: returnCode.toString(),
      progressValue: step! / (totalSteps - 1),
      isError: (failureMessage != ''));
}

Future<bool> generateStepVideo(
    {required BuildContext? context,
    required Function? externalSetState,
    required int sessionIndex,
    int step = 0,
    SessionsRecord? session,
    required int totalSteps}) async {
  SessionStepsRecord sessionStep = sessionStepsList![step];
  currentSessionStep = sessionStepsList![step];
  //sessionStepIndex = step;
  print('(VA10)${currentSessionStep!.reference!.path}....${step}');
  if (true /*(currentSessionStep!.audio!.path ?? '').length > 0*/) {
    if (true /*(currentSessionStep!.audio!.path ?? '').length > 0*/) {
      final String tempPhotoPath =
          '${tempDirPath}/photo_${(step).toString()}.jpg';
      final String questionImagePath =
          '${tempDirPath}/question_${(step).toString()}.jpg';
      final String tempVideoPath =
          '${tempDirPath}/video_${(step).toString()}.mp4';
      final String tempShortVideoPath =
          '${tempDirPath}/shortvideo_${(step).toString()}.mp4';

      // print('(VA11)${tempPhotoPath}....${tempVideoPath}');
      String audioPath =
          getFilePath(FileKind.aac, sessionStepsList![step].reference!.path!);
      String tempAudioPath = '${tempDirPath}/audio_${(step).toString()}.wav';
      final String audioConvertCommand =
          '-y -i "${audioPath}" "${tempAudioPath}"';
      await ffmpegCommand(
        context: context,
        externalSetState: externalSetState,
        command: audioConvertCommand,
        sessionIndex: sessionIndex,
        step: step,
        operation: 'aac-wav',
        totalSteps: totalSteps,
      );

      // print(
      //     '(VA12)${step}~~~${audioPath}====${generateAudioStorageFilenameMp3(sessionStep)}');
      // print(
      //     '(VA13)${step}~~~~${generatePhotoStorageFilename(sessionStep)},,,,${tempPhotoPath}====');
      String sourcePhotoFilePath =
          getFilePath(FileKind.photo, sessionStepsList![step].reference!.path!);
      if (!(await isFileInAppDir(sourcePhotoFilePath))) {
        if (lastPhotoPath == '') {
          toast(context!, 'Photo missing from Step ${step.toString()}',
              ToastKind.error);
          print('(VA14A)');
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
      print('(VA14B)${resizedImage.frameType}');
      Image modifiedImage = Image(
        image: ResizeImage(
          FileImage(File(tempPhotoPath)),
          width: 500,
          height: 500,
        ),
      );
      // print('(VA15)${step},,,,${tempPhotoPath}++++${questionImagePath}<');
      dir = Directory.fromRawPath(utf8Encoder!.convert(tempDirPath!));
      final String command =
          '-loop 1 -i "${tempPhotoPath}" -i "${tempAudioPath}" -shortest "${tempVideoPath}"';
      // print('(VA17)${command}');
      await ffmpegCommand(
        context: context,
        externalSetState: externalSetState,
        command: command,
        sessionIndex: sessionIndex,
        step: step,
        operation: 'aud+pho',
        totalSteps: totalSteps,
      );

      if (step == 0) {
        final String shortCommand =
            '-ss 0 -i "${tempVideoPath}" -t 0.1 -map 0 -c copy "${tempShortVideoPath}"';
        // print('(VA17)${command}');
        await ffmpegCommand(
          context: context,
          externalSetState: externalSetState,
          command: shortCommand,
          sessionIndex: sessionIndex,
          step: step,
          operation: 'short',
          totalSteps: totalSteps,
        );
      }
      

      final String questionText = sessionStep.question!;
      const maxCharsQuestionLine = 20;
      String formatedQuestionText = '';
      if (questionText.length < maxCharsQuestionLine) {
        formatedQuestionText = formatedQuestionText;
      } else {
        List<String> questionSplit = questionText.split(' ');
        int charCount = 0;
        for (int i = 0; i < questionSplit.length; i++) {
          formatedQuestionText = formatedQuestionText + ' ' + questionSplit[i];
          charCount = charCount + questionSplit[i].length + 1;
          if (charCount > maxCharsQuestionLine) {
            formatedQuestionText = formatedQuestionText + '\n';
            charCount = 0;
          }
        }
      }
      print('(VC5A)${questionText}....${formatedQuestionText}');
      final String questionVideoCommand =
          '''-f lavfi -i color=size=500x500:duration=2:rate=30:color=black -vf "drawtext=fontfile=/system/fonts/DroidSans.ttf:fontsize=30:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:text='${formatedQuestionText}'" -pix_fmt yuv420p ${tempDirPath}/question_${step.toString()}.mp4''';
      await ffmpegCommand(
        context: context,
        externalSetState: externalSetState,
        command: questionVideoCommand,
        sessionIndex: sessionIndex,
        step: step,
        operation: 'question',
        totalSteps: totalSteps,
      );
      String videoStorageId =
          generateVideoStorageFilename(sessions![currentSessionIndex]);
      // print('(VA21)${videoStorageId},,,,${tempVideoPath}++++${questionText}');
/*
      await storeStorageFile(
       bucketId: artTheopyAIRvideosRef.path,
         storageFileId:  'question_${step.toString()}.mp4',
         localFilePath: '${tempDirPath}/question_${step.toString()}.mp4',
         deleteIfNecessary: true,
       );
*/
    }
  }
  return true;
}

Future<void> makeVideo(
    {required BuildContext? context,
    required Function? externalSetState,
    required int sessionIndex,
    int index = 0,
    SessionsRecord? session,
    StateSetter? setState,
    required int totalSteps}) async {
  // print(
  //     '(FW1)${index}....${sessions![index].videoCreated},,,,${!session!.sessionModified!}++++${((sessions![index].videoCreated!) && (!session!.sessionModified!))}~~~~${session.reference}');
  // print('(FW2)${index}');
  progressDialog = ProgressDialog(context!,
      type: ProgressDialogType.normal, isDismissible: true, showLogs: true);
  progressDialog!.style(
      message: 'Making video...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(value: 0.0),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 1.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  await progressDialog!.show();
  currentSessionIndex = index;
  sessionStepsList = await listSessionStepList(thisSessionIndex: index);
  await emptyTempDirOFPhotosVideosConcat();
  // print('(VA1)${tempDirPath}....${sessionStepsList!.length}');
  await printTempDirListing();
  utf8Encoder = utf8.encoder;
  dir = Directory.fromRawPath(utf8Encoder!.convert(tempDirPath!));
  String concatList = '';
  for (int i = 0; i < sessionStepsList!.length; i++) {
    // print('(VA6A)${sessionStepsList!.length}....${i}');
    await generateStepVideo(
      context: context,
      externalSetState: externalSetState,
      sessionIndex: sessionIndex,
      step: i,
      session: session,
      totalSteps: totalSteps,
    );
    if (i == 0) {
      concatList =
          concatList + "file '${tempDirPath}/shortvideo_${i.toString()}.mp4'\n";
    }
    concatList =
        concatList + "file '${tempDirPath}/question_${i.toString()}.mp4'\n";
    concatList =
        concatList + "file '${tempDirPath}/video_${i.toString()}.mp4'\n";
  }
  final File concatFile =
      await File("${tempDirPath}/concat.txt").writeAsString(concatList);
  String conatContents = await File("${tempDirPath}/concat.txt").readAsString();
  print(
      '(VA31)${concatList}....${tempDirPath}/concat.txt}++++${conatContents}');
  final String concatedVideo = "${tempDirPath}/video.mp4";
  final String concatCommand =
      '-y -safe 0 -f concat -i ${tempDirPath}/concat.txt -c copy "${concatedVideo}"';
  // print('(VA32)${concatedVideo}....${concatCommand}');
  await ffmpegCommand(
    context: context,
    externalSetState: externalSetState,
    command: concatCommand,
    sessionIndex: sessionIndex,
    step: totalSteps ,
    operation: 'concat',
    totalSteps: totalSteps,
  );
  models.FileList fileList =
      await listStorageFiles(bucketId: artTheopyAIRvideosRef.path);
  String fileId = '';
  print('(VA36A)${fileId}');
  if (fileId.length > 0) {
    await deleteStorageFile(
        bucketId: artTheopyAIRvideosRef.path, fileId: fileId);
  }
  print('(VA36B)${concatedVideo}....${generateVideoStorageFilename(session!)}');
  var response = await storeStorageFile(
    bucketId: artTheopyAIRvideosRef.path!,
    storageFileId: generateVideoStorageFilename(
      session,
    ),
    localFilePath: concatedVideo,
    deleteIfNecessary: true,
  );
  // print(
  //     '(VA37)${concatedVideo}....${response}~~~~${currentSessionIndex}****${sessions!.length}');
  await updateDocument(
      collection: sessionsRef,
      document: sessions![currentSessionIndex].reference,
      data: {kSessionSessionModified: false, kSessionVideoCreated: true});
  await progressDialog!.hide();
  setState!(() {
    sessions![currentSessionIndex].videoCreated = true;
    sessions![currentSessionIndex].sessionModified = false;

  });
}
