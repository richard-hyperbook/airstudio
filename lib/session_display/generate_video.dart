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
import 'package:ffmpeg_kit_flutter_new_min/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_min/session.dart';
// import '../../platform/audio_recorder_platform.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'dart:convert';
import 'package:ffmpeg_kit_flutter_new_min/return_code.dart';
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

      final String tempPhotoPath = '${tempDirPath}/photo_${(step).toString()}.jpg';
      final String tempVideoPath = '${tempDirPath}/video_${(step).toString()}.mp4';
      print('(VA11)${tempPhotoPath}....${tempVideoPath}');
      String audioPath = getFilePath(FileKind.aac, sessionStepsList![step].reference!.path!);
      String tempAudioPath = '${tempDirPath}/audio_${(step).toString()}.wav';
      final String audioConvertCommand = '-y -i "${audioPath}" "${tempAudioPath}"';
      await executeFFmpeg(audioConvertCommand);
      print('(VA12)${step}~~~${audioPath}====${generateAudioStorageFilenameMp3(sessionStep)}');
      print(
          '(VA13)${step}~~~~${generatePhotoStorageFilename(sessionStep)},,,,${tempPhotoPath}====');
      String sourcePhotoFilePath =
      getFilePath(FileKind.photo, sessionStepsList![step].reference!.path!);
      if (!(await isFileInAppDir(sourcePhotoFilePath))) {
        if (lastPhotoPath == '') {
          toast(context!, 'Photo missing from Step ${step.toString()}', ToastKind.error);
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
      superImage.Image? resizedImage = superImage.copyResize(image!, width: 500, height: 500);
      File(tempPhotoPath).writeAsBytesSync(superImage.encodeJpg(resizedImage));
      print('(VA14B)${resizedImage.frameType}');
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
      //  setState(() {
      logString += '\n✅ Processing completed!\n';
      logString += 'Return code: $returnCode\n';
      logString += 'Duration: ${duration}ms\n';
      logString += 'Output: $output\n';
      //  isProcessing = false;
      //});

      debugPrint('session: $output');
      print('(VA20)${logString}');

      //  print('(VC5A)${ffMpegResponse.getReturnCode()}....${ffMpegResponse.getState()},,,,${videoPath}');
      /* int maxVideoVersion = await getMaxVersionNumber(
            bucketId: artTheopyAIRvideosRef.path!,
            fileId: sessions![currentSessionIndex].reference!.path!);*/
      String videoStorageId = generateVideoStorageFilename(sessions![currentSessionIndex]);
      print('(VA21)${videoStorageId},,,,${tempVideoPath}');
      // await storeStorageFile(
      //   bucketId: artTheopyAIRvideosRef.path,
      //   storageFileId: videoStorageId,
      //   localFilePath: videoPath,
      // );

      /*(Log log) {
          // setState(() {
          logString += log.getMessage();
          // });
          debugPrint('log: ${log.getMessage()}');
        },
        (Statistics statistics) {
          // setState(() {
          logString +=
              '\n📊 Progress: ${statistics.getSize()} bytes, ${statistics.getTime()}ms\n';
          // });
          debugPrint('statistics: ${statistics.getSize()}');
        },*/
    }
  }
  return true;
}


Future<void> makeVideo(BuildContext context, {int index = 0, SessionsRecord? session, StateSetter? setState}) async {

  ((sessions![index].videoCreated!) && (!session!.sessionModified!))
      ? null
      : () async {
    //currentSession = sessions![index];
    currentSessionIndex = index;
    showAlertDialog(context);
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
      bool ok = await generateStepVideo(context, step: i);
      if (!ok) {
        print('(VA6B)${sessionStepsList!.length}....${i}');
        Navigator.pop(context);
        return;
      }
      concatList = concatList + 'file ${tempDirPath}/video_${i.toString()}.mp4\n';
    }
    /*       final String videoPath = tempDirPath!;
                        Directory videoDir = Directory(videoPath);
                        int directoryLength = await videoDir.list().length;
                        int fileIndex = 0;
                        videoDir.listSync().forEach((e) {
                          final size = e.statSync().size;
                          print('(VA30A)${size}....${e.path}');
                          if ((e.path).contains('video')) {
                            concatList = concatList + 'file ${e.path}\n';
                            print('(VA30B),,,,file ${e.path}\n....${concatList}++++');
                          }
                        });
                 */
    print('(VA31)${concatList}');
    final File concatFile =
    await File("${tempDirPath}/concat.txt").writeAsString(concatList);
    final String concatedVideo = "${tempDirPath}/video.mp4";
    final String concatCommand =
        '-y -f concat -safe 0 -i "${tempDirPath}/concat.txt" -c copy "${concatedVideo}"';
    print('(VA32)${concatedVideo}....${concatCommand}');

    await executeFFmpeg(concatCommand);
    /*Session ffmpegSession2 =
                            await FFmpegKit.execute(concatCommand);
                        print('(VA33)${concatCommand}');

                        final output = await ffmpegSession2.getOutput();
                        final returnCode = await ffmpegSession2.getReturnCode();
                        final duration = await ffmpegSession2.getDuration();
                        print(
                            '(VA34)${returnCode!.toString()}....${returnCode},,,,${output!.length}----${output.characters.length}>>>>${duration}');
                       */
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
    print('(VA36A)${fileId}');
    if (fileId.length > 0) {
      await deleteStorageFile(bucketId: artTheopyAIRvideosRef.path, fileId: fileId);
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
    Navigator.pop(context);
    // String  command =
    // " -y -framerate 1 -pattern_type sequence -i $pictureFilenames -c:v libx264 -r 30 -pix_fmt yuv420p ${generatedFile.path}";
  };


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
