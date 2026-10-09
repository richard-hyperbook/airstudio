import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
// import '/backend/firebase_storage/storage.dart';
import '../index.dart';
import '../localDB.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'help_model.dart';
import '../../appwrite_interface.dart';
import 'package:appwrite/models.dart' as models;
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import '../../conditional.dart';
export 'help_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '/../custom_code/widgets/toast.dart';
// import '../../map_display/map_display_widget.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// import '../../paypal/paypal_widget.dart';

class HelpWidget extends StatefulWidget {
  const HelpWidget({super.key});

  @override
  _HelpWidgetState createState() => _HelpWidgetState();
}

class _HelpWidgetState extends State<HelpWidget> {
  late HelpModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // late VideoPlayerController videoPlayercontroller;
  bool videoIsInitialized = false;
  AnimatedTextController? animatedTextController;

  /* Future<void> initVideo() async {
    videoIsInitialized = false;
    videoPlayercontroller = await VideoPlayerController.networkUrl(Uri.parse(
        // 'https://tin.syi.mybluehost.me/images/woodland7.mp4',
        // 'https://fra.cloud.appwrite.io/v1/storage/buckets/6976480a000f753c7f66/files/69764845002270220aa0/view?project=696ddda6001b28f2352e&mode=admin',
        'https://fra.cloud.appwrite.io/v1/storage/buckets/6976480a000f753c7f66/files/697b914d000bc9a390e2/view?project=696ddda6001b28f2352e&mode=admin'))
      ..initialize().then((_) {
        startupVideo();
        // video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    ;
    print(
        '(SA1) ${videoPlayercontroller!.value.isInitialized}++++${videoIsInitialized}');
    videoPlayercontroller!.setLooping(true);
    videoIsInitialized = true;
  }*/

/*
  Future<void> startupVideo() async {
    print(
        '(SA4) ${videoPlayercontroller!.value.isInitialized}++++${videoIsInitialized}');
    videoPlayercontroller!.setVolume(0);
    await videoPlayercontroller!.play();
    print(
        '(SA7) ${videoPlayercontroller!.value.isInitialized}++++${videoIsInitialized}');
    videoPlayercontroller!.setLooping(true);
  }
*/

  @override
  void initState() {
    print('(SA40)');
    super.initState();
    _model = createModel(context, () => HelpModel());
    animatedTextController = AnimatedTextController();
    // initVideo();
    _model.textController ??= TextEditingController(text: currentUserDisplayName);
    print('(SA41)');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await initVideo();
      print('(SA42)');

      setState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle kPanelTextStyleSmaller = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      /*shadows: <Shadow>[
        Shadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 3.0,
          color: Colors.grey,
        ),
        Shadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 8.0,
          color: Colors.grey,
        ),
      ],*/
      fontFamily: 'Rubik',
    );

    final TextStyle kPanelTextStyleLarger = TextStyle(
      color: Colors.amber,
      fontWeight: FontWeight.bold,
      fontSize: 32,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(5.0, 5.0),
          blurRadius: 3.0,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        Shadow(
          offset: Offset(5.0, 5.0),
          blurRadius: 8.0,
          color: Color.fromARGB(125, 0, 0, 255),
        ),
      ],
      fontFamily: 'Rubik',
    );

    Widget svgLogo() {
      return SvgPicture.asset(
        'assets/images/paintbrush2.svg',
        width: 50,
        height: 50,
      );
    }

      const String loginScreenshot = 'https://fra.cloud.appwrite.io/v1/storage/buckets/680cd737001f208054fb/files/6ac79b09003d2ff593ce/preview?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbklkIjoiNmFjNzliM2VjZGE3OGE1NTNiNGIiLCJyZXNvdXJjZUlkIjoiNjgwY2Q3MzcwMDFmMjA4MDU0ZmI6NmFjNzliMDkwMDNkMmZmNTkzY2UiLCJyZXNvdXJjZVR5cGUiOiJmaWxlcyIsInJlc291cmNlSW50ZXJuYWxJZCI6IjY4MTAzOjIiLCJpYXQiOjE3OTE0NjYzMDJ9.bEafq52kBHWlb72qGE43xQWAnJ1kqxR56kkk02m_a7s&project=696ddda6001b28f2352e';
    const String sessionScreenshot = 'https://fra.cloud.appwrite.io/v1/storage/buckets/680cd737001f208054fb/files/6ac8b9a2001a8cb23c24/preview?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbklkIjoiNmFjOGZhNjk1ZTExZjljNDY2NjUiLCJyZXNvdXJjZUlkIjoiNjgwY2Q3MzcwMDFmMjA4MDU0ZmI6NmFjOGI5YTIwMDFhOGNiMjNjMjQiLCJyZXNvdXJjZVR5cGUiOiJmaWxlcyIsInJlc291cmNlSW50ZXJuYWxJZCI6IjY4MTAzOjMiLCJpYXQiOjE3OTE1NTYyMDF9.GC-xlfmqOA0EWxtItPDhiQKlThA0jYYm0SaOY22cAW4&project=696ddda6001b28f2352e';
          const String editAirScreenshot = 'https://fra.cloud.appwrite.io/v1/storage/buckets/680cd737001f208054fb/files/6ac8ba5d001680340d8e/preview?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbklkIjoiNmFjOGJhNjZlZjJjZjQxY2MzYWEiLCJyZXNvdXJjZUlkIjoiNjgwY2Q3MzcwMDFmMjA4MDU0ZmI6NmFjOGJhNWQwMDE2ODAzNDBkOGUiLCJyZXNvdXJjZVR5cGUiOiJmaWxlcyIsInJlc291cmNlSW50ZXJuYWxJZCI6IjY4MTAzOjQiLCJpYXQiOjE3OTE1Mzk4MTR9.eAXVukmI3HPpM2_vtYhnffjWgU2oS_zkf2u_EWpJ6eM&project=696ddda6001b28f2352e';
          const String clientsScreenshot = 'https://fra.cloud.appwrite.io/v1/storage/buckets/680cd737001f208054fb/files/6ac8e90a0012b85a0116/preview?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbklkIjoiNmFjOGU5MzZjMWFlYjYyMTcwOGIiLCJyZXNvdXJjZUlkIjoiNjgwY2Q3MzcwMDFmMjA4MDU0ZmI6NmFjOGU5MGEwMDEyYjg1YTAxMTYiLCJyZXNvdXJjZVR5cGUiOiJmaWxlcyIsInJlc291cmNlSW50ZXJuYWxJZCI6IjY4MTAzOjgiLCJpYXQiOjE3OTE1NTE3OTh9.w7OYyG95BjbfPZRMulYG4Nc3xsT0wsSvafrILwLdXZc&project=696ddda6001b28f2352e';
        const String templatesScreenshot = 'https://fra.cloud.appwrite.io/v1/storage/buckets/680cd737001f208054fb/files/6ac8e8cf0022b88eb4b5/preview?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbklkIjoiNmFjOGU5YzJhOTFmODBjOTQ1OTgiLCJyZXNvdXJjZUlkIjoiNjgwY2Q3MzcwMDFmMjA4MDU0ZmI6NmFjOGU4Y2YwMDIyYjg4ZWI0YjUiLCJyZXNvdXJjZVR5cGUiOiJmaWxlcyIsInJlc291cmNlSW50ZXJuYWxJZCI6IjY4MTAzOjciLCJpYXQiOjE3OTE1NTE5Mzh9.XwSmgLVcgV88NKmWv0WGcISuB-n6LVBAc67ix_-SWYo&project=696ddda6001b28f2352e';
          const String profileScreenshot = 'https://fra.cloud.appwrite.io/v1/storage/buckets/680cd737001f208054fb/files/6ac8e8800025b9b0723e/preview?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbklkIjoiNmFjOGU5ZjBlMWM3NTg5MTM4NjAiLCJyZXNvdXJjZUlkIjoiNjgwY2Q3MzcwMDFmMjA4MDU0ZmI6NmFjOGU4ODAwMDI1YjliMDcyM2UiLCJyZXNvdXJjZVR5cGUiOiJmaWxlcyIsInJlc291cmNlSW50ZXJuYWxJZCI6IjY4MTAzOjYiLCJpYXQiOjE3OTE1NTE5ODR9.XlXyeOLRJRRyV2yXf9Gicx45f7V-EniKQSNZiHOCpW8&project=696ddda6001b28f2352e';
          const String editAIRScreenshot = 'https://fra.cloud.appwrite.io/v1/storage/buckets/680cd737001f208054fb/files/6ac8e8800025b9b0723e/preview?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbklkIjoiNmFjOGU5ZjBlMWM3NTg5MTM4NjAiLCJyZXNvdXJjZUlkIjoiNjgwY2Q3MzcwMDFmMjA4MDU0ZmI6NmFjOGU4ODAwMDI1YjliMDcyM2UiLCJyZXNvdXJjZVR5cGUiOiJmaWxlcyIsInJlc291cmNlSW50ZXJuYWxJZCI6IjY4MTAzOjYiLCJpYXQiOjE3OTE1NTE5ODR9.XlXyeOLRJRRyV2yXf9Gicx45f7V-EniKQSNZiHOCpW8&project=696ddda6001b28f2352e';
    const String editRecordingScreenshot = 'https://fra.cloud.appwrite.io/v1/storage/buckets/680cd737001f208054fb/files/6ac8ea99003d6d880dac/preview?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbklkIjoiNmFjOGVhYTRkMjdkZTkzYzQ3YzciLCJyZXNvdXJjZUlkIjoiNjgwY2Q3MzcwMDFmMjA4MDU0ZmI6NmFjOGVhOTkwMDNkNmQ4ODBkYWMiLCJyZXNvdXJjZVR5cGUiOiJmaWxlcyIsInJlc291cmNlSW50ZXJuYWxJZCI6IjY4MTAzOjkiLCJpYXQiOjE3OTE1NTIxNjR9.GCQbHrMJ1iSU9WJgPpObUvNCIYReZ9nTmSmgG4yrnSA&project=696ddda6001b28f2352e';
    // const String Screenshot = '';
    // const String Screenshot = '';



    const String helpAirStudio =

    '''An AIR (Art Intervention Recording) is a video of the artwork created by an Art Therapist's client together with their responses to a series of questions.  AIR Studio is an app developed to allow Art Therapists to produce AIRs with the minimum of effort, handling all aspects of the creation of the desired video.
<br>
<img style="width: 50%; height: 50%; float:right" src="${loginScreenshot}">
<br><br>1. Start on the 'Login' page: click on 'Create account', enter your email address and a password.  You will be directed to the 'Profile' page where you should enter name (as you wish it to be displayed in the app).
If you click on the chexkbox labelled "Store AIRs in cloud", then each time you edit an AIR, it will be retained in cloud storage.  Making this choice will slpw operation, but you will be able to edit each AIR on multiple devices.
<img style="width: 50%; height: 50%; float:right" src="${profileScreenshot}">
<br><br>2. On returning to the 'Login' page, enter your email adress and password, and click 'Login'.
<br><br>3. You will enter the 'AIRs' page which will list all the AIRs you have worked on, with the most recent at the head of the list.
<img style="width: 50%; height: 50%; float:right" src="${sessionScreenshot}">
<br><br>4. Before creating a new AIR, you will need to ensure that you have entered your client's name in the Client list.  Click on the 'Menu' button on the 'AIRs' page and select 'Clients'.
<br><br>5. The 'Clients' page will show a list of your clients.  Additions can me made by clicking the 'Add client' button.  
<img style="width: 50%; height: 50%; float:right" src="${clientsScreenshot}">
<br><br>6. To create a new AIR, click the 'Create AIR' button at the top of the page.  You will be asked to select a Template and a Client for this new AIR.  The template can either be predefined or user-generated (please see Step 16).
<br><br>7. To start or continue the editing of an AIR, click on the 'Edit' button,  Which will take you to the 'Edit AIR' page.
<img style="width: 50%; height: 50%; float:right" src="${editAirScreenshot}">
<br><br>8. Each AIR is composed of a series of steps, each step is labeled with a question (defined in the template chosen in the creation of the AIR)
<br><br>9. For each step, take a photo of the client's artwork, ask the client the question amd click on the microphone icon to record their response.
<br><br>10. Click the 'Select photo' button and choose the image from the phone's photo gallery.
<br><br>11. You can click the 'Transcribe' button to see your client's words as text.  Please be aware that this may take some time.
<br><br>12. You can also click the 'Edit recording' button if you wish to trim the audio recording.
<img style="width: 50%; height: 50%; float:right" src="${editRecordingScreenshot}">
<br><br>13. On returning to the 'AIRs' page, you can click the 'Make video' button which will create a video from the recordings and images (this can take several minutes).
<br><br>14. If the next button is labled 'Load video', then clicking it will show the created video in a pop-up window.
<br><br>15. Clicking the final button in this list will result in an email being sent to your email address.  The video will include a link which, when clicked, will download the created video.
<br><br>16. To create your own template, click on the 'Menu' button on the 'AIRs' page.  This will take you to the 'Templates' page which lists all the templates.
<img style="width: 50%; height: 50%; float:right" src="${templatesScreenshot}">

        ''';

    Widget showHelpTextWidget() {
      // return Text(helpAirStudio,
      //   softWrap: true,
      //   style: kPanelTextStyleSmaller,
      // );
      return HtmlWidget(helpAirStudio,textStyle: TextStyle(fontSize: 15),);


    }

    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Air Studio Help',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Rubik',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: showHelpTextWidget(),
          ),
        ));
  }
}
