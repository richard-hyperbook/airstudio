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
import 'package:davinci/davinci.dart';
import 'package:appwrite/appwrite.dart';

List<SessionStepsRecord>? sessionStepsList;
Utf8Encoder? utf8Encoder;
// String? tempDirPath;

Directory? dir;

String lastPhotoPath = '';

class PreviewWidget extends StatelessWidget {
  const PreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      color: Colors.orange,
      child: const Center(
        child: Text(
          "This widget was not in widget tree",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

Future<void> ffmpegCommand(String command) async {
  String logString = 'Logs will appear here...';
  Session ffmpegSession = await FFmpegKit.execute(command);
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
  print('(FFM4)${logString}');
}

Future<void> generateQuestionVideo(BuildContext context, {int step = 0}) async {
  final String filenamePNG = '${tempDirPath}/question_${step}.png';
  final String filenameJPG = '${tempDirPath}/question_${step}.jpg';
  var questionImage = await DavinciCapture.offStage(
    const PreviewWidget(),
    context: context,
    returnImageUint8List: true,
    saveToDevice: false,
    openFilePreview: true,
    //fileName: 'question_${step}.jpg',
    //albumName: 'questions',
  );
  // image2.Image u8Image = image2.Image.fromBytes(bytes: u8List, width: 500);

  print('(FU11)${filenamePNG}....${questionImage}');
  await File(filenamePNG).writeAsBytes(questionImage);
  int quetionPNGFileLength = await File(filenamePNG).length();
  print('(FU13A)${quetionPNGFileLength}');
  final image = image2.decodeImage(File(filenamePNG).readAsBytesSync())!;
  print('(FU13B)${image}');
  await File(filenameJPG).writeAsBytes(image2.encodeJpg(image));
  int quetionJPGFileLength = await File(filenamePNG).length();
  print('(FU13C)${quetionJPGFileLength}');

  var response = await storeStorageFile(
    bucketId: airsRef.path!,
    storageFileId: ID.unique(),
    localFilePath: filenameJPG,
    deleteIfNecessary: true,
  );
  print('(FU14)${response}');
  final String tempVideoPath =
      '${tempDirPath}/question_${(step).toString()}.mp4';
  // final String command =
  //     '-loop 1 -f h264 -i "${filename}" -an -c:v libx264 -r 30 -t 2 -pix_fmt yuv420p -s 500x500 "${tempVideoPath}"';
  // final String command =
  //     ' -loop 1 -i "${filename}" -t 5 -vf scale=500:500  -c:v libx264 -pix_fmt yuv420p -c:a aac -ar 44100 -b:a 96k -ac 2 -threads 2 -f mp4 "${tempVideoPath}"';
  final String command =
      ' -loop 1 -i "${filenameJPG}" -t 5 -s 500x500 "${tempVideoPath}"';
  print('(FU15)${command}');
  // await ffmpegCommand(command);
  // File mp4File = File(tempVideoPath);
  // int vLength = await mp4File.length();
  // print('(FU16)${vLength}');
  /*response = await storeStorageFile(
    bucketId: airsRef.path!,
    storageFileId: ID.unique(),
    localFilePath: tempVideoPath,
    deleteIfNecessary: true,
  );*/
}

Future<bool> generateStepVideo(BuildContext context, {int step = 0}) async {
  SessionStepsRecord sessionStep = sessionStepsList![step];
  currentSessionStep = sessionStepsList![step];
  //sessionStepIndex = step;
  print('(VA10)${currentSessionStep!.reference!.path}....${step}');
  if (true /*(currentSessionStep!.audio!.path ?? '').length > 0*/) {
    if (true /*(currentSessionStep!.audio!.path ?? '').length > 0*/) {
      // await setMaxVersionNumbersCurrentSessionStep();
      // final int maxAudioVersion = currentSessionStep!.maxAudioVersion!;
      // final int maxPhotoVersion = currentSessionStep!.maxPhotoVersion!;

      final String tempPhotoPath =
          '${tempDirPath}/photo_${(step).toString()}.jpg';
      final String questionImagePath =
          '${tempDirPath}/question_${(step).toString()}.jpg';
      final String tempVideoPath =
          '${tempDirPath}/video_${(step).toString()}.mp4';
      print('(VA11)${tempPhotoPath}....${tempVideoPath}');
      String audioPath =
          getFilePath(FileKind.aac, sessionStepsList![step].reference!.path!);
      String tempAudioPath = '${tempDirPath}/audio_${(step).toString()}.wav';
      final String audioConvertCommand =
          '-y -i "${audioPath}" "${tempAudioPath}"';
      await ffmpegCommand(audioConvertCommand);
      print(
          '(VA12)${step}~~~${audioPath}====${generateAudioStorageFilenameMp3(sessionStep)}');
      print(
          '(VA13)${step}~~~~${generatePhotoStorageFilename(sessionStep)},,,,${tempPhotoPath}====');
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

      print('(VA15)${step},,,,${tempPhotoPath}++++${questionImagePath}<');
      dir = Directory.fromRawPath(utf8Encoder!.convert(tempDirPath!));

      final String command =
          '-loop 1 -i "${tempPhotoPath}" -i "${tempAudioPath}" -shortest "${tempVideoPath}"';
      print('(VA17)${command}');
      await ffmpegCommand(command);
      //  print('(VC5A)${ffMpegResponse.getReturnCode()}....${ffMpegResponse.getState()},,,,${videoPath}');
      /* int maxVideoVersion = await getMaxVersionNumber(
            bucketId: artTheopyAIRvideosRef.path!,
            fileId: sessions![currentSessionIndex].reference!.path!);*/

      FFmpegKit.execute('-i ${tempDirPath}/video_${step.toString()}.mp4 -c:v mpeg4 ${tempDirPath}/info.mp4}')
          .then((session) async {
        var logs = await session.getLogs();
        for (var log in logs){
          print('(VA17Z)${log.getMessage()}');
        }
      });
      // final String questionVideoCommand =
      // '''-f lavfi -i color=size=500x500:duration=10:rate=30:color=blue -vf "drawtext=fontfile=/system/fonts/DroidSans.ttf:fontsize=30:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:text='Stack Overflow'" ${tempDirPath}/question_${step.toString()}.mp4''';
      final String questionVideoCommand =
      '''-f lavfi -i color=size=500x500:duration=2:rate=30:color=black -vf "drawtext=fontfile=/system/fonts/DroidSans.ttf:fontsize=30:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:text='Stack Overflow'" -pix_fmt yuv420p ${tempDirPath}/question_${step.toString()}.mp4''';
      await ffmpegCommand(questionVideoCommand);
      String videoStorageId =
          generateVideoStorageFilename(sessions![currentSessionIndex]);
      print('(VA21)${videoStorageId},,,,${tempVideoPath}');
      await storeStorageFile(
       bucketId: artTheopyAIRvideosRef.path,
         storageFileId:  'question_${step.toString()}.mp4',
         localFilePath: '${tempDirPath}/question_${step.toString()}.mp4',
         deleteIfNecessary: true,
       );
    }
  }
  return true;
}

Future<void> makeVideo(BuildContext context,
    {int index = 0, SessionsRecord? session, StateSetter? setState}) async {
  print(
      '(FW1)${index}....${sessions![index].videoCreated},,,,${!session!.sessionModified!}++++${((sessions![index].videoCreated!) && (!session!.sessionModified!))}~~~~${session.reference}');
/*  ((sessions![index].videoCreated!) && (!session!.sessionModified!))
      ? null
      : () async {*/
  //currentSession = sessions![index];
  print('(FW2)${index}');
  currentSessionIndex = index;
  // showAlertDialog(context);
  sessionStepsList = await listSessionStepList(thisSession: sessions![index]);
  // tempDirPath = await getTempDir
  await emptyTempDirOFPhotosVideosConcat();
  print('(VA1)${tempDirPath}....${sessionStepsList!.length}');
  await printTempDirListing();
  utf8Encoder = utf8.encoder;
  dir = Directory.fromRawPath(utf8Encoder!.convert(tempDirPath!));
  String concatList = '';
  for (int i = 0; i < sessionStepsList!.length; i++) {
    print('(VA6A)${sessionStepsList!.length}....${i}');
    // await generateQuestionVideo(context, step: i);
    bool ok = await generateStepVideo(context, step: i);
    if (!ok) {
      print('(VA6B)${sessionStepsList!.length}....${i}');
      Navigator.pop(context);
      return;
    }
    concatList = concatList + "file '${tempDirPath}/question_${i.toString()}.mp4'\n";
    concatList = concatList + "file '${tempDirPath}/video_${i.toString()}.mp4'\n";
  }
  final File concatFile =
  await File("${tempDirPath}/concat.txt").writeAsString(concatList);
  String conatContents = await File("${tempDirPath}/concat.txt").readAsString();
  print('(VA31)${concatList}....${tempDirPath}/concat.txt}++++${conatContents}');
  await printTempDirListing();
  final String concatedVideo = "${tempDirPath}/video.mp4";
  final String concatCommand =
      '-y -safe 0 -f concat -i ${tempDirPath}/concat.txt -c copy "${concatedVideo}"';
  print('(VA32)${concatedVideo}....${concatCommand}');
  await ffmpegCommand(concatCommand);
  models.FileList fileList =
      await listStorageFiles(bucketId: artTheopyAIRvideosRef.path);
  String fileId = '';
  for (int i = 0; i < fileList.files.length; i++) {
    if ((fileList.files[i].$id)
        .contains(sessions![currentSessionIndex].reference!.path!)) {
      fileId = fileList.files[i].$id;
      break;
    }
  }
 /* FFmpegKit.execute('-i ${concatedVideo} -c:v mpeg4 ${tempDirPath}/info.mp4}')
      .then((session) async {
        var logs = await session.getLogs();
        for (var log in logs){
          print('(VA36Z)${log.getMessage()}');
        }
  });*/
  print('(VA36A)${fileId}');
  if (fileId.length > 0) {
    await deleteStorageFile(
        bucketId: artTheopyAIRvideosRef.path, fileId: fileId);
  }
  print('(VA36B)${concatedVideo}....${generateVideoStorageFilename(
    session!,
  )}');
  var response = await storeStorageFile(
    bucketId: artTheopyAIRvideosRef.path!,
    storageFileId: generateVideoStorageFilename(
      session,
    ),
    localFilePath: concatedVideo,
  );
  print(
      '(VA37)${concatedVideo}....${response}~~~~${currentSessionIndex}****${sessions!.length}');
  await updateDocument(
      collection: sessionsRef,
      document: sessions![currentSessionIndex].reference,
      data: {kSessionSessionModified: false, kSessionVideoCreated: true});
  setState!(() {
    sessions![currentSessionIndex].videoCreated = true;
    sessions![currentSessionIndex].sessionModified = false;
  });
  print(
      '(VA38)${sessions![currentSessionIndex].videoCreated}++++${sessions![currentSessionIndex].sessionModified}----${concatedVideo}....${currentSessionIndex}****${sessions!.length}');
  // Navigator.pop(context);
  // String  command =
  // " -y -framerate 1 -pattern_type sequence -i $pictureFilenames -c:v libx264 -r 30 -pix_fmt yuv420p ${generatedFile.path}";
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(
            margin: EdgeInsets.only(left: 5), child: Text('   Please wait')),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
