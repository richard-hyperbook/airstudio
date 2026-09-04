//import 'dart:js_interop';

//import 'dart:js_interop';

// import 'dart:js_interop';

// import 'dart:js_interop';

// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'dart:math';
import 'package:date_format/date_format.dart';
import '/flutter_flow/custom_functions.dart' as functions;

import 'app_state.dart';
// import 'custom_code/widgets/get_hyperbooks.dart';
import 'custom_code/widgets/permissions.dart';

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io' as dartio;
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../custom_code/widgets/toast.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import '/custom_code/actions/index.dart' as actions;
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/random_data_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'localDB.dart';
import '../session_display/session_display_widget.dart';
import 'dart:async';
// import 'dart:html' as html show window;
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:web/web.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:io';
import 'dart:convert';
import '../app_state.dart';
import 'package:video_player/video_player.dart';
// import '../platform/audio_recorder_platform.dart';

// part 'appwrite_interface.g.dart';
import 'package:ffmpeg_kit_flutter_new_video/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_video/session.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;

/*

Future<void> handlePermission(permissionHandler.Permission permission, String name) async {
  var status = await permission.request();

  if (status.isGranted) {
    Fluttertoast.showToast(msg: '$name permission granted');
  } else if (status.isPermanentlyDenied) {
    Fluttertoast.showToast(msg: '$name permission permanently denied. Enable it in settings.');
    openAppSettings();
  } else if (status.isRestricted) {
    Fluttertoast.showToast(msg: '$name permission restricted by system.');
  } else if (status.isLimited) {
    Fluttertoast.showToast(msg: '$name permission limited access granted.');
  } else {
    Fluttertoast.showToast(msg: '$name permission denied');
  }
}
*/

enum FileKind { /*audio,*/ photo, video, wav, mp3, aac }

const String _numericChars = '1234567890';
Random _numericRnd = Random();

String getRandomNumericString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) =>
            _numericChars.codeUnitAt(_numericRnd.nextInt(_numericChars.length)),
      ),
    );

/*
//localhost
const endpoint = 'http://localhost/v1';
const project = '67cd5b6e000fe41c331e';
const DocumentReference databaseRef = DocumentReference(
  path: '67cd5e2c0011a37a550c',
);
const DocumentReference hyperbooksRef = DocumentReference(
  path: '67d25aaf003d6b9507b6',
);
const DocumentReference connectedUsersRef = DocumentReference(
  path: '67d26456000deb78fa6a',
);
const DocumentReference chaptersRef = DocumentReference(
  path: '67d260ec0037564b2569',
);
const DocumentReference aaMilneUserRef = DocumentReference(
  path: '67cdf1e76e9881bd3a5c',
);


 */
//intelvid.co.uk

late Timer timer;
const kEndpoint = 'https://fra.cloud.appwrite.io/v1';
const kProjectID = '696ddda6001b28f2352e';
const kDevKey =
    // '4de99514ee3d5a8fb3cdf236ba66a91e9bdb37c8397f9f98542530bd2f6a71797d93b068276fc23c0aba27cbd1e41912d4362456a9a167150bc5a2d66265b86a94229cfaf7d63181b173898e5f322b28f4d1c9a6c3470fa129f933062428ceb4806c26ca5bfa8e91d7e88f8dcbc430d1eb864016906a31d0dd78bf6a9450794d';
    '208620233cb2c5e9b25390faaf083a63e134e35af4909eca15b6e4ff70a25f3c76c43dcc258f18683a5f5adc222804a3b13f2508b40a6e60c11c9c8f00e3829870e4a66b296e838ecfcea659170c3870d20ba82f86216fe55ac4db3f0cf72c3b8ffa8e1774186657e1f9bfa1929853a9d04b4350bdff1f919199e4e5a7eea31a';
const imageFilenameHead = kEndpoint + '/storage/buckets';

final DocumentReference databaseRef = DocumentReference(
  path: '698c8fce0029ddaaecdb',
);
final DocumentReference sessionStepsRef = DocumentReference(
  path: 'sessionsteps',
);
final DocumentReference sessionsRef = DocumentReference(path: 'sessions');
final DocumentReference usersRef = DocumentReference(path: 'users');
final DocumentReference infoRef =
    DocumentReference(path: '69a9253600091c44ad9f');
final DocumentReference backupStorageRef = DocumentReference(
  path: '680746de003983073d29',
);
final DocumentReference artTheopyAIRphotosRef = DocumentReference(
  path: '698c93550005c8307b67',
);
final DocumentReference artTheopyAIRaudiosRef = DocumentReference(
  path: '698c93a00006c743c31f',
);
final DocumentReference artTheopyAIRvideosRef = DocumentReference(
  path: '69a00b070018aac953fa',
);
final DocumentReference templatesRef = DocumentReference(
  path: 'templates',
);
final DocumentReference airsRef = DocumentReference(
  path: '69d229dd000910a8aad9',
);

final DocumentReference logRef = DocumentReference(
  path: 'log',
);
final DocumentReference purchasesRef = DocumentReference(
  path: 'purchases',
);

final DocumentReference constraintsRef = DocumentReference(path: '');
final DocumentReference infoDocumentRef =
    DocumentReference(path: '69a925d2001d220fb19e');

// LocalDB localDB = LocalDB();

UsersRecord? currentUser;
String currentUserDisplayName = '';
String currentUserEmail = '';
List<SessionsRecord>? sessions;
List<SessionsRecord>? oldSessions;
// SessionsRecord? currentSession;
int currentSessionIndex = -1;
SessionStepsRecord? currentSessionStep;
int currentSessionStepIndex = -1;
List<SessionStepsRecord>? sessionSteps;

double basicFontSize = 15;

String? currentLocalAudioPath;
UsersRecord? currentTherapist;
UsersRecord? currentClient;
String? tempDirPath;
String? appDirPath;

RealtimeSubscription? hyperbookDisplaySubscription;
RealtimeSubscription? hyperbookEditSubscription;
RealtimeSubscription? chapterChapterSubscription;
RealtimeSubscription? chapterReadReferenceSubscription;
List<String> chapterSubscriptionStringList = [];
List<String> readReferenceSubscriptionStringList = [];
// RealtimeSubscription? drawMapPageChapterSubscription;
// RealtimeSubscription? drawMapPageReadReferenceSubscription;

const databaseId = 'default';
const bucketId = 'testBucket';
const collectionId = 'usernames';

const double kPhonewWidthThreashold = 650;
const double kIntroductionChapterXCoord = 50.1;
const double kIntroductionChapterYCoord = 100.2;
const double kMinRandomXCoord = 20;
const double kMinRandomYCoord = 20;
const double kMaxRandomXCoord = 300;
const double kMaxRandomYCoord = 300;
const double zoomChangeMultiplyer = 1.1;

const String kStorageFilenameSpitString = '_';
const String kStorageFilenameStartString = '/*';
const String kStorageFilenameEndString = '*/';

const double kChickletHeight = 40;
const double kHeightMapTitle = 50;

const double kMapPreferenceButtonWidth = 100;
const double kNodeButtonWidth = 40;
const double kMapNodeBorderWidth = 5;
const int kMaxBlurbLengthOnMap = 50;

const String kMessageSpitCharacter = '~';

const double kStateSelectorWidthFactor = 0.8;
const double kStateSelectorHeight = 35.0;

Random random = Random();
Client? client;
Databases? appwriteDatabases;
String result = 'XXX';
List<Map<String, dynamic>> items = [];
Account? account;
models.User? loggedInUser;
bool loggedIn = false;
bool hyperbookDisplayIsSubscribed = false;
bool hyperbookEditIsSubscribed = false;
bool chapterReadPageChapterAppIsSubscribed = false;
bool chapterReadPageReadReferenceAppIsSubscribed = false;
bool drawMapPageChapterAppIsSubscribed = false;
bool drawMapPageReadReferenceAppIsSubscribed = false;
bool isDrawingMap = false;
// DocumentReference chapterClicked = DocumentReference(path: '');
bool resetPasswordCommandRecived = false;
bool chapterHasBeenEdited = false;
double logoSize = 100;


const int kUserLevelNotLoggedIn = 0;
const int kUserLevelFree = 1;
const int kUserLevelPro = 2;
const int kUserLevelSupervisor = 99;

const double kAbbBarButtonSize = 40;
const double kArrowPadSize = 100;
const double mapShiftIncrement = 15.0;
const double kDefaultNodeSize = 40.0;

const String kGuestUserDisplayName = 'Guest';

const kConectedUserNodeSizePrefLabel = 'conectedUserNodeSize';
const kConectedUserXCoordPrefLabel = 'xCoord';
const kConectedUserYCoordPrefLabel = 'yCoord';
const kConectedUserReadStateIndexPrefLabel = 'readStateIndex';
const kConectedUserColors = 'colors';

const double kMapNodeMoveMinChange = 2.0;
const int kLimitDatabaseListDocuments = 1000;
const int kLimitStorageListDocuments = 1000;

const PageTransitionType kStandardPageTransitionType =
    PageTransitionType.leftToRight;
const Duration kStandardTransitionTime = Duration(milliseconds: 1000);
const Duration kStandardReverseTransitionTime = Duration(milliseconds: 300);

bool showLogoEtcOnMap = true;
bool isIncomingResetPassword = false;

DocumentReference? _currentHyperbook;
DocumentReference? get currentHyperbook => _currentHyperbook;
set currentHyperbook(DocumentReference? value) {
  _currentHyperbook = value;
}

class ConstraintsRecord {
  int? noOfHyperbooks;
  int? noOfUsersPerHyperbook;
  int? level;
  ConstraintsRecord({
    this.noOfHyperbooks,
    this.noOfUsersPerHyperbook,
    this.level,
  });
}

List<ConstraintsRecord> constraintsMatrix = [];
DateTime? lastCheckedConstraints;

Future<void> loadConstraisMatrix() async {
  print('(CC6)');
  if (lastCheckedConstraints != null) {
    print('(CC3)${DateTime.now().difference(lastCheckedConstraints!).inDays}');
  } else {
    print('(CC4)');
  }
  /*  if ((lastCheckedConstraints == null) ||
      (DateTime.now().difference(lastCheckedConstraints!).inDays > 1)) {
    constraintsMatrix = await listConstraintsList();
  }*/
}

TablesDB? tablesDB;
Future<void> initAppwrite() async {
  print('(AAT30)');

  client = Client()
      .setEndpoint(kEndpoint)
      .setProject(kProjectID)
      // .setDevKey(kDevKey)
      .setSelfSigned();
  account = Account(client!);
  tablesDB = TablesDB(client!);
  print('(AAT31)${client},,,,${account}++++${tablesDB}');
}

@JsonSerializable()
class DocumentReference {
  String? path;
  DocumentReference({this.path = '0'});
  /*  factory DocumentReference.fromJson(Map<String, dynamic> json) =>
      _$DocumentReferenceFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentReferenceToJson(this);*/
}

@JsonSerializable()
class SessionsRecord {
  DocumentReference? reference;
  DocumentReference? clientId;
  DocumentReference? therapistId;
  String? clientDisplayName;
  bool? videoCreated;
  bool? videoLoaded;
  bool? sessionModified;
  VideoPlayerController? videoController;
  DateTime? $createdAt;
  DateTime? $updatedAt;

  SessionsRecord({
    this.reference,
    this.clientId,
    this.therapistId,
    this.clientDisplayName,
    required this.videoCreated,
    required this.videoLoaded,
    required this.sessionModified,
    this.$createdAt,
    this.$updatedAt,
  });

  /* factory SessionStepsRecord.fromJson(Map<String, dynamic> json) =>
      _$SessionStepsRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SessionStepsRecordToJson(this);*/
}

@JsonSerializable()
class SessionStepsRecord {
  DocumentReference? reference;
  DocumentReference? sessionId;
  DocumentReference? photo;
  DocumentReference? audio;
  bool? completed;
  String? transcription;
  int? index;
  String? question;
  DateTime? $createdAt;
  DateTime? $updatedAt;
  int? maxAudioVersion;
  int? maxPhotoVersion;
  bool? photoFileValid;
  bool? audioFileValid;

  SessionStepsRecord({
    this.reference,
    this.sessionId,
    this.photo,
    this.audio,
    this.completed,
    this.transcription,
    this.index,
    this.question,
    this.$createdAt,
    this.$updatedAt,
    this.maxAudioVersion,
    this.maxPhotoVersion,
    this.photoFileValid,
    this.audioFileValid,
  });

  /* factory SessionStepsRecord.fromJson(Map<String, dynamic> json) =>
      _$SessionStepsRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SessionStepsRecordToJson(this);*/
}

@JsonSerializable()
class UsersRecord {
  DocumentReference? reference;
  String? email;
  String? displayName;

  String? phoneNumber;
  int? userLevel;
  String? userMessage;
  String? role;
  String? therapistId;
  String? originalAppUserId;
  DateTime? $createdAt;
  DateTime? $updatedAt;

  // String? productId;
  String? applicationUserName;
  // String? purchaseID;
  // bool? pendingCompletePurchase;
  // String? purchaseDetailsStatus;
  // String? localVerificationData;
  // String? serverVerificationData;
  // DateTime? transactionDateTime;
  int? cumulativeSessions;
  // String? purchaseStatus;
  bool? archiveSessions;

  DocumentReference? userReference;

  UsersRecord({
    this.reference,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.userReference,
    this.userLevel,
    this.userMessage,
    this.role,
    this.therapistId,
    this.originalAppUserId,
    this.$createdAt,
    this.$updatedAt,
    // this.productId,
    this.applicationUserName,
    // this.purchaseID,
    // this.pendingCompletePurchase,
    // this.purchaseDetailsStatus,
    // this.localVerificationData,
    // this.serverVerificationData,
    // this.transactionDateTime,
    this.cumulativeSessions,
    // required this.purchaseStatus,
    this.archiveSessions,
  });

  /*  factory UsersRecord.fromJson(Map<String, dynamic> json) =>
      _$UsersRecordFromJson(json);
  Map<String, dynamic> toJson() => _$UsersRecordToJson(this);
}*/
}

@JsonSerializable()
class TemplatesRecord {
  DocumentReference? reference;
  String? name;
  List<String>? questions;
  bool? isMaster;
  DocumentReference? creatorId;
  DateTime? $createdAt;
  DateTime? $updatedAt;

  TemplatesRecord({
    this.reference,
    this.name,
    this.questions,
    this.isMaster,
    this.creatorId,
    this.$createdAt,
    this.$updatedAt,
  });
}

class PurchasesRecord {
  DocumentReference? reference;
  String? email;
  String? details;
  String? purchaseToken;
  String? productId;
  String? transactionDate;
  String? transactionId;
  String? obfuscatedAccountIdAndroid;
  String? actualDate;
  DateTime? $createdAt;
  DateTime? $updatedAt;

  PurchasesRecord({
    this.reference,
    this.email,
    this.details,
    this.purchaseToken,
    this.productId,
    this.transactionDate,
    this.transactionId,
    this.obfuscatedAccountIdAndroid,
    this.actualDate,
    this.$createdAt,
    this.$updatedAt,
  });
}

Future<models.Document> createDocument({
  required DocumentReference? collection,
  required Map? data,
  String id = '',
}) async {
  if (id == '') {
    id = ID.unique();
  }
  appwriteDatabases = Databases(client!);
  // print(
  //     '(N100A)${id}////${data}::::${collection!.path},,,,${databaseRef.path}@@@@${collection.path}');
  models.Document doc = await appwriteDatabases!.createDocument(
    databaseId: databaseRef.path!,
    collectionId: collection!.path!,
    documentId: id,
    data: data!,
  );
  // print('(N100B)${doc.data}....${collection.path}');
  return doc;
}

Future<models.DocumentList> listDocuments({
  DocumentReference? collection,
  String? orderByAttribute,
}) async {
  appwriteDatabases = Databases(client!);
  print(
    '(N11A)${appwriteDatabases!.client.endPoint}////${collection!.path}((((${orderByAttribute}',
  );
  print('(N11B)${databaseRef.path}////${collection.path}');
  models.DocumentList? docs;
  if (orderByAttribute == null) {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection.path!,
      queries: [Query.limit(kLimitDatabaseListDocuments)],
    );
    print('(N11C)${docs}');
  } else {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection.path!,
      queries: [
        Query.limit(kLimitDatabaseListDocuments),
        Query.orderAsc(orderByAttribute),
      ],
    );
    print('(N11E)${docs}');
  }
  print('(N11F)${docs.documents.length}');
  print('(N11G)${docs!.documents}');
  return docs;
}

Future<models.Document> getDocument({
  DocumentReference? collection,
  DocumentReference? document,
}) async {
  appwriteDatabases = Databases(client!);
  print(
    '(N2011A)${databaseRef.path}<<<<${collection!.path}++++${document!.path}',
  );
  models.Document? doc;
  try {
    doc = await appwriteDatabases!.getDocument(
      databaseId: databaseRef.path!,
      collectionId: collection.path!,
      documentId: document.path!,
      queries: [],
    ) /*as models.Document*/;
  } on AppwriteException catch (e) {
    print('(AAT42)${e.type}****${e.message}');
    //   toast(context, 'Login failure: ${e.message}', ToastKind.error);
  }
  print('(N2011B)${doc!.$id}');
  return doc;
}

Future<models.Row> getRow({
  DocumentReference? collection,
  DocumentReference? document,
}) async {
  // appwriteDatabases = Databases(client!);
  print(
    '(N2011A)${databaseRef.path}<<<<${collection!.path}++++${document!.path}',
  );
  models.Row? row;
  try {
    row = await tablesDB!.getRow(
      databaseId: databaseRef.path!,
      tableId: collection.path!,
      rowId: document.path!,
      queries: [],
    );
  } on AppwriteException catch (e) {
    print('(AAT52)${e.type}****${e.message}');
    //   toast(context, 'Login failure: ${e.message}', ToastKind.error);
  }
  print('(N2011B)${row!.$id}');
  return row;
}

Future<void> updateDocument({
  DocumentReference? collection,
  DocumentReference? document,
  Map<String, dynamic>? data,
}) async {
  // appwriteDatabases = Databases(client!);
  // print('(N2011C)${data}////${collection!.path}++++${document!.path}');
  models.Document doc = await appwriteDatabases!.updateDocument(
    databaseId: databaseRef.path!,
    collectionId: collection!.path!,
    documentId: document!.path!,
    data: data,
  );
  // print('(N2021D)${document.path}');
  return;
}

Future<void> updateRow({
  DocumentReference? collection,
  DocumentReference? document,
  Map<String, dynamic>? data,
}) async {
  // appwriteDatabases = Databases(client!);
  //>print('(N2011C)${data}////${collection!.path}++++${document!.path}');688c919e8a6d84adb201
  try {
    models.Row row = await tablesDB!.updateRow(
      databaseId: databaseRef.path!,
      tableId: collection!.path!,
      rowId: document!.path!,
      data: data,
    );
  } on AppwriteException catch (e) {
    print('(ND6)${e.message}&&&&${e.code}====${e.code}');
  }
  // //>print('(N2021D)${document.path}');
  return;
}

Future<void> deleteDocument({
  required DocumentReference? collection,
  required DocumentReference? document,
}) async {
  appwriteDatabases = Databases(client!);
  //>print('(ND4)${collection!.path}++++${document!.path}');
  try {
    await appwriteDatabases!.deleteDocument(
      databaseId: databaseRef.path!,
      collectionId: collection!.path!,
      documentId: document!.path!,
    );
  } on AppwriteException catch (e) {
    print('(ND6)${e.message}&&&&${e.code}====${e.code}');
  }
  //>print('(ND5)');
  return;
}

Future<void> deleteRow({
  required DocumentReference? collection,
  required DocumentReference? document,
}) async {
  // appwriteDatabases = Databases(client!);
  //>print('(ND4)${collection!.path}++++${document!.path}');
  try {
    await tablesDB!.deleteRow(
      databaseId: databaseRef.path!,
      tableId: collection!.path!,
      rowId: document!.path!,
    );
  } on AppwriteException {
    //>print('(ND6)${e.message}&&&&${e.code}====${e.code}');
  }
  //>print('(ND5)');
  return;
}

Future<models.DocumentList> listDocumentsWithOneQueryDocumentReference({
  DocumentReference? collection,
  String attribute = '',
  DocumentReference? value,
  String? orderByAttribute,
}) async {
  appwriteDatabases = Databases(client!);
  models.DocumentList docs = models.DocumentList(total: 0, documents: []);
  try {
    if (orderByAttribute == null) {
      docs = await appwriteDatabases!.listDocuments(
        databaseId: databaseRef.path!,
        collectionId: collection!.path!,
        queries: [
          Query.equal(attribute, value!.path),
          Query.limit(kLimitDatabaseListDocuments),
        ],
      );
    } else {
      print(
          '(TTP9A)${collection!.path}<<<<${attribute}....${value!.path}++++${orderByAttribute}');
      docs = await appwriteDatabases!.listDocuments(
        databaseId: databaseRef.path!,
        collectionId: collection!.path!,
        queries: [
          Query.equal(attribute, value!.path),
          Query.limit(kLimitDatabaseListDocuments),
          Query.orderAsc(orderByAttribute),
        ],
      );
      print('(TTP9B)${docs.documents.length}....${docs.total}++++${docs}');
    }
  } on AppwriteException catch (e) {
    print('(N8B)${e}');
  }
  return docs;
}

Future<models.DocumentList> listDocumentsWithOneQueryBool({
  DocumentReference? collection,
  String attribute = '',
  bool? value,
  String? orderByAttribute,
}) async {
  appwriteDatabases = Databases(client!);
  models.DocumentList docs = models.DocumentList(total: 0, documents: []);
  try {
    if (orderByAttribute == null) {
      docs = await appwriteDatabases!.listDocuments(
        databaseId: databaseRef.path!,
        collectionId: collection!.path!,
        queries: [
          Query.equal(attribute, value!),
          Query.limit(kLimitDatabaseListDocuments),
        ],
      );
    } else {
      docs = await appwriteDatabases!.listDocuments(
        databaseId: databaseRef.path!,
        collectionId: collection!.path!,
        queries: [
          Query.equal(attribute, value!),
          Query.limit(kLimitDatabaseListDocuments),
          Query.orderDesc(orderByAttribute),
        ],
      );
    }
  } on AppwriteException catch (e) {
    print('(N8G)${e}');
  }
  return docs;
}

Future<models.RowList> listRowsWithOneQueryDocumentReference({
  DocumentReference? collection,
  String attribute = '',
  DocumentReference? value,
  String? orderByAttribute,
}) async {
  // appwriteDatabases = Databases(client!);
  models.RowList rows = models.RowList(total: 0, rows: []);
  //>  print(
  //>   '(N7A)${attribute}&&&&${value!.path}////${databaseRef.path}ÅÅÅÅ${collection!.path}',
  // );
  //>print('(N7ZA)${appwriteDatabases}>>>>${collection}<<<<${value}');
  try {
    if (orderByAttribute == null) {
      rows = await tablesDB!.listRows(
        databaseId: databaseRef.path!,
        tableId: collection!.path!,
        queries: [
          Query.equal(attribute, value!.path),
          Query.limit(kLimitDatabaseListDocuments),
        ],
      );
    } else {
      rows = await tablesDB!.listRows(
        databaseId: databaseRef.path!,
        tableId: collection!.path!,
        queries: [
          Query.equal(attribute, value!.path),
          Query.limit(kLimitDatabaseListDocuments),
          Query.orderAsc(orderByAttribute),
        ],
      );
    }
  } on AppwriteException catch (e) {
    print('(N8A)${e.message}&&&&${e.code}====${e.code}');
    print('(N8B)${e}');
  }
  // //>print('(N9A)${docs.documents.length}');
  // if(docs.documents.length > 0) {
  //   //>print('(N9)${docs.documents.length}>>>>${docs.documents.first.$id}<<<<${docs.documents.first.data.entries}');
  // }
  return rows;
}

Future<models.DocumentList> listDocumentsWithTwoQueryDocumentReferences({
  DocumentReference? collection,
  String attribute1 = '',
  DocumentReference? value1,
  String attribute2 = '',
  DocumentReference? value2,
}) async {
  appwriteDatabases = Databases(client!);
  models.DocumentList docs = models.DocumentList(total: 0, documents: []);
  //> print(
  //>  '(NY10)${attribute1}&&&&${value1!.path}////${databaseRef.path}ÅÅÅÅ${collection!.path}',
  //> );
  //>print('(NY11)${appwriteDatabases}>>>>${collection}<<<<${value1}');
  try {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection!.path!,
      queries: [
        Query.equal(attribute1, value1!.path),
        Query.equal(attribute2, value2!.path),
        Query.limit(kLimitDatabaseListDocuments),
      ],
    );
  } /*on AppwriteException */ catch (e) {
    //  //>print('(N8A)${e.message}&&&&${e.code}====${e.code}');
    //>print('(NY12${e}');
  }
  //>print('(NY13)${docs.documents.length}>>>>${docs.documents}<<<<${docs.total}');
  return docs;
}

Future<models.DocumentList> listDocumentsWithTwoQueries({
  DocumentReference? collection,
  String attribute1 = '',
  dynamic value1,
  String attribute2 = '',
  dynamic value2,
}) async {
  appwriteDatabases = Databases(client!);
  models.DocumentList docs = models.DocumentList(total: 0, documents: []);
  //> print(
  //>  '(NY10)${attribute1}&&&&${value1!.path}////${databaseRef.path}ÅÅÅÅ${collection!.path}',
  //> );
  //>print('(NY11)${appwriteDatabases}>>>>${collection}<<<<${value1}');
  try {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection!.path!,
      queries: [
        Query.equal(attribute1, value1!),
        Query.equal(attribute2, value2!),
        Query.limit(kLimitDatabaseListDocuments),
      ],
    );
  } /*on AppwriteException */ catch (e) {
    //  //>print('(N8A)${e.message}&&&&${e.code}====${e.code}');
    //>print('(NY12${e}');
  }
  //>print('(NY13)${docs.documents.length}>>>>${docs.documents}<<<<${docs.total}');
  return docs;
}

Future<models.DocumentList> listDocumentsWithOneQueryString({
  DocumentReference? collection,
  String attribute = '',
  String? value,
}) async {
  appwriteDatabases = Databases(client!);
  models.DocumentList? docs;
  //> print(
  //>   '(N207A)${attribute}&&&&${value}////${databaseRef.path}ÅÅÅÅ${collection!.path}',
  //>  );
  //>print('(N7ZB)${appwriteDatabases}>>>>${collection}<<<<${value}');
  try {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection!.path!,
      queries: [
        Query.equal(attribute, value!),
        Query.limit(kLimitDatabaseListDocuments),
      ],
    );
  } on AppwriteException {
    //  //>print('(N8A)${e.message}&&&&${e.code}====${e.code}');
    //>print('(N208B)${e}');
  }
  //> print(
  //>     '(N2009)${appwriteDatabases!.client.endPoint}>>>>${collection.path}<<<<${value}');
  return docs!;
}
/*
Future<models.DocumentList> listDocumentsWithOneQueryBool({
  DocumentReference? collection,
  String attribute = '',
  bool? value,
}) async {
  appwriteDatabases = Databases(client!);
  models.DocumentList? docs;
  //> print(
  //>   '(N207A)${attribute}&&&&${value}////${databaseRef.path}ÅÅÅÅ${collection!.path}',
  //>  );
  //>print('(N7ZB)${appwriteDatabases}>>>>${collection}<<<<${value}');
  try {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection!.path!,
      queries: [
        Query.equal(attribute, value!),
        Query.limit(kLimitDatabaseListDocuments),
      ],
    );
  } on AppwriteException {
    //  //>print('(N8A)${e.message}&&&&${e.code}====${e.code}');
    //>print('(N208B)${e}');
  }
  //> print(
  //>     '(N2009)${appwriteDatabases!.client.endPoint}>>>>${collection.path}<<<<${value}');
  return docs!;
}*/

Future<SessionsRecord> createSession({
  required DocumentReference? clientId,
  required DocumentReference? therapistId,
  required DocumentReference? templateId,
  String id = '',
}) async {
  print('(NW60)${id}');
  models.Document doc = await createDocument(
    collection: sessionsRef,
    data: {
      kSessionClientId: clientId!.path,
      kSessionTherapistId: therapistId!.path,
    },
    id: id,
  );
  //>print('(NW61)${doc}');
  SessionsRecord session = SessionsRecord(
    reference: DocumentReference(path: doc.$id),
    clientId: clientId,
    therapistId: therapistId,
    videoCreated: false,
    videoLoaded: false,
    sessionModified: false,
  );
  TemplatesRecord template = await getTemplate(document: templateId);
  List<String> questions = extractQuestions(template.questions);
  print('(QQ2)${templateId!.path},,,,${questions}....${questions.length}');
  for (int i = 0; i < questions.length; i++) {
    var ss = await createSessionStep(
      sessionId: session.reference,
      photo: null,
      audio: null,
      completed: false,
      transcription: null,
      index: i,
      question: questions[i],
    );
    print('(QQ3)${ss}');
  }
  currentUser!.cumulativeSessions = (currentUser!.cumulativeSessions ?? 0) + 1;
  logString('(PS-103)${currentUser!.cumulativeSessions}');

  await updateDocument(
      collection: usersRef,
      document: currentUser!.reference,
      data: {kUserCumulativeSessions: currentUser!.cumulativeSessions});
  return session;
}

Future<SessionStepsRecord> createSessionStep({
  required DocumentReference? sessionId,
  required DocumentReference? photo,
  required DocumentReference? audio,
  required bool? completed,
  required String? transcription,
  required int? index,
  required String? question,
  String id = '',
}) async {
  //>//>('(NW60)${id}');
  models.Document doc = await createDocument(
    collection: sessionStepsRef,
    data: {
      kSessionStepSessionId: sessionId!.path,
      kSessionStepPhoto: '',
      kSessionStepAudio: '',
      kSessionStepCompleted: completed,
      kSessionStepTranscription: '',
      kSessionStepIndex: index,
      kSessionStepQuestion: question,
    },
    id: id,
  );
  //>print('(NW61)${doc}');
  SessionStepsRecord h = SessionStepsRecord(
    reference: DocumentReference(path: doc.$id),
    sessionId: sessionId,
    photo: photo,
    audio: audio,
    completed: completed,
    transcription: transcription,
    index: index,
    question: question,
    maxAudioVersion: 0,
    maxPhotoVersion: 0,
  );
  return h;
}

Future<void> createUser({
  DocumentReference? reference,
  String? email,
  String? displayName,
  String? phoneNumber,
  DocumentReference? userReference,
  int? userLevel,
  String? userMessage,
  String? role,
  String id = '',
  String? therapistId,
}) async {
  //>print('(M10`)${email}');
  models.Document doc = await createDocument(
    collection: usersRef,
    data: {
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      // 'userReference': userReference!.path,
      'userLevel': userLevel,
      'userMessage': userMessage,
      'role': role,
      // 'createdAt': DateTime.now().toIso8601String(),
      'therapistId': therapistId,
      'productId': '',
      'applicationUserName': '',
      'purchaseID': '',
      'pendingCompletePurchase': false,
      'purchaseDetailsStatus': '',
      'localVerificationData': '',
      'serverVerificationData': '',
      'transactionDateTime': null,
      'cumulativeSessions': 0,
      'status': '',
    },
    id: id,
  );
  print('(N9000)${doc}');
}

Future<void> createClient({
  DocumentReference? reference,
  String? email,
  String? displayName,
  String? phoneNumber,
  // int? userLevel,
  String? userMessage,
  // String? role,
  String id = '',
  String? therapistId,
}) async {
  print(
      '(M2110`)${getRandomString(20)}....${displayName}....${DateTime.now().toIso8601String()}....${phoneNumber ?? ''}....${userMessage ?? ''}....${therapistId}');
  models.Document doc = await createDocument(
    collection: usersRef,
    data: {
      'email': email ?? getRandomString(20),
      'displayName': displayName,

      'phoneNumber': phoneNumber ?? '',
      // 'userLevel': kUserLevelNotLoggedIn,
      'userMessage': userMessage ?? '',
      'role': kRoleClient,

      'therapistId': therapistId,
    },
    id: id,
  );
  print('(M2111)${doc.data}');
}

Future<TemplatesRecord> createTemplate({
  required String name,
  required List<String> questions,
  required bool isMaster,
  required DocumentReference creatorId,
  String id = '',
}) async {
  models.Document doc = await createDocument(
    collection: templatesRef,
    data: {
      'name': name,
      'questions': questions,
      'isMaster': isMaster,
      'creatorId': creatorId.path,
    },
    id: id,
  );
  return TemplatesRecord(
    reference: DocumentReference(path: doc.$id),
    name: name,
    questions: questions,
    isMaster: isMaster,
    creatorId: creatorId,
    $createdAt: DateTime.now(),
    $updatedAt: DateTime.now(),
  );
}

Future<TemplatesRecord> getTemplate({DocumentReference? document}) async {
  models.Document doc = await getDocument(
    collection: templatesRef,
    document: document,
  );
  ////>print('(M221)${doc.data['chapterColorInts'].runtimeType}****${doc.data['chapterColorInts']}');
  List<String> qqq = extractQuestions(doc.data['questions']);
  TemplatesRecord t = TemplatesRecord(
    reference: DocumentReference(path: doc.$id),
    name: doc.data['name'] as String,
    questions: qqq, //q?.map((e) => e.toString()).toList() ?? [],
    isMaster: (doc.data['isMaster'] as bool?) ?? false,
    creatorId: DocumentReference(path: (doc.data['creatorId'] as String)),
  );
  //>print('(N5005)${h}');
  return t;
}

List<String> extractQuestions(dynamic q) {
  List<dynamic> qq = q as List<dynamic>;
  print('(QQ6)${qq}....${qq.length}');
  List<String> qqq = [];

  if (qq.length > 0) {
    for (int i = 0; i < qq.length; i++) {
      qqq.insert(i, qq[i] as String);
      print('(QQ5)${qqq}');
    }
  }
  print('(QQ1)${qqq}');
  return qqq;
}

Future<List<TemplatesRecord>> listTemplateList(
    DocumentReference? creatorId) async {
  // models.DocumentList docs = await listDocuments(
  //   collection: templatesRef,
  // );

  models.DocumentList docsMaster = await listDocumentsWithOneQueryBool(
    collection: templatesRef,
    attribute: kTemplateIsMater,
    value: true,
    orderByAttribute: kTemplateName,
  );
  models.DocumentList docsMine = models.DocumentList(total: 0, documents: []);
  if (creatorId != null) {
    docsMine = await listDocumentsWithOneQueryDocumentReference(
      collection: templatesRef,
      attribute: kTemplateCreatorId,
      value: creatorId,
      orderByAttribute: kTemplateName,
    );
  }
  print(
      '(TTP1A)${templatesRef.path}<<<<${creatorId!.path}....${kTemplateCreatorId},,,,${docsMine.documents.length}');

  print('(TTP2)${docsMaster.documents.length}....${docsMine.documents.length}');
  List<TemplatesRecord> items = [];
  for (models.Document doc in docsMaster.documents) {
    print('(TTP4A)${doc.$id}');
    print('(TTP5A)${doc.data['questions']}');
    print('(TTP6A)${doc.data['name']}');
    // List<String>? q = doc.data['questions'] as List<dynamic>;
    List<String> qqq = extractQuestions(doc.data['questions']);
    items.add(TemplatesRecord(
      reference: DocumentReference(path: doc.$id),
      name: doc.data['name'] as String,
      questions: qqq, //q?.map((e) => e.toString()).toList() ?? [],
      isMaster: (doc.data['isMaster'] as bool?) ?? false,
      creatorId: DocumentReference(path: (doc.data['creatorId'] as String)),
    ));
    print('(TTP3A)${doc.$id}');
  }
  for (models.Document doc in docsMine.documents) {
    print('(TTP4B)${doc.$id}');
    print('(TTP5B)${doc.data['questions']}');
    print('(TTP6B)${doc.data['name']}');
    // List<String>? q = doc.data['questions'] as List<dynamic>;
    List<String> qqq = extractQuestions(doc.data['questions']);
    items.add(TemplatesRecord(
      reference: DocumentReference(path: doc.$id),
      name: doc.data['name'] as String,
      questions: qqq, //q?.map((e) => e.toString()).toList() ?? [],
      isMaster: (doc.data['isMaster'] as bool?) ?? false,
      creatorId: DocumentReference(path: (doc.data['creatorId'] as String)),
    ));
    print('(TTP3B)${doc.$id}');
  }
  print('(TTP7)${items.length}');
  return items;
}

Future<List<TemplatesRecord>> listOwnedPlusMasterTemplateList() async {
  models.DocumentList docsUser =
      await listDocumentsWithOneQueryDocumentReference(
    collection: templatesRef,
    attribute: kTemplateCreatorId,
    value: currentUser!.reference,
  );
  models.DocumentList docsMaster = await listDocumentsWithOneQueryBool(
    collection: templatesRef,
    attribute: kTemplateIsMater,
    value: true,
  );
  List<models.Document> docs = List.from(docsUser.documents);
  for (int i = 0; i < docsMaster.documents.length; i++) {
    docs.add(docsMaster.documents[i]);
  }
  print('(TP21)${docs.length}');
  List<TemplatesRecord> items = [];
  for (models.Document doc in docs) {
    print('(TP24)${doc.$id}');
    print('(TP25)${doc.data['questions']}');
    print('(TP26)${doc.data['name']}');
    // List<String>? q = doc.data['questions'] as List<dynamic>;
    var qq = doc.data['questions'] as List<dynamic>;
    List<String> qqq = [];
    if (qq.length > 0) {
      for (int i = 0; i < qq.length; i++) {
        var p = qq[i];
        print('(TP27)${p.runtimeType}...${p}');
        //qqq.add(qq[i] as String);
      }
    }
    items.add(TemplatesRecord(
      reference: DocumentReference(path: doc.$id),
      name: doc.data['name'] as String,
      questions: qqq, //q?.map((e) => e.toString()).toList() ?? [],
      isMaster: (doc.data['isMaster'] as bool?) ?? false,
      creatorId: DocumentReference(path: (doc.data['creatorId'] as String)),
    ));
    print('(TP23)${doc.$id}');
  }
  return items;
}

Future<void> updateTemplateQuestions(
    DocumentReference templateRef, List<String> newQuestions) async {
  await updateDocument(collection: templatesRef, document: templateRef, data: {
    'questions': newQuestions,
  });
}

Future<void> deleteTemplate(DocumentReference templateRef) async {
  await deleteDocument(collection: templatesRef, document: templateRef);
}
// },
// id: id,
// );
// UsersRecord u = UsersRecord(
//   reference: DocumentReference(path: doc.$id),
//   email: email,
//   displayName: displayName,
//   phoneNumber: phoneNumber,
//   role: role,
//   userMessage: userMessage,
// );
// return u;
// }

Future<UsersRecord> getUser({DocumentReference? document}) async {
  models.Row row = await getRow(collection: usersRef, document: document);
  // print('(M1)${row.data}****${row.data['chapterColorInts']}');
  List<int> colorInts = [];
  // print('(M1A)${row.data['displayName']}');
  UsersRecord u = UsersRecord(
    reference: document,
    email: (row.data[kUserEmail]) as String?,
    displayName: (row.data[kUserDisplayName]) as String?,
    phoneNumber: (row.data[kUserPhoneNumber]) as String?,
    role: (row.data[kUserRole]) as String?,
    userMessage: (row.data[kUserUserMessage] as String?),
    therapistId: (row.data[kUserTherapistId] as String?),
    // productId: (row.data[kUserProductId] as String?),
    applicationUserName: (row.data[kUserApplicationUserName] as String?),
    // purchaseID: (row.data[kUserPurchaseID] as String?),
    // pendingCompletePurchase: (row.data[kUserPendingCompletePurchase] as bool?),
    // purchaseDetailsStatus: (row.data[kUserPurchaseDetailsStatus] as String?),
    // localVerificationData: (row.data[kUserLocalVerificationData] as String?),
    // serverVerificationData: (row.data[kUserServerVerificationData] as String?),
    // transactionDateTime: (row.data[kUserTransactionDateTime] as DateTime?),
    cumulativeSessions: (row.data[kUserCumulativeSessions] as int?),
    // purchaseStatus: (row.data[kUserPurchaseStatus] as String?),
    archiveSessions: (row.data[kUserArchiveSessions] as bool?),

  );
  // print('(N2005)${u.email}');
  return u;
}

String generateAudioStorageFilenameWav(
  SessionStepsRecord sessionStep,
) {
  return 'wav${sessionStep.reference!.path}.wav';
}

String generateAudioStorageFilenameMp3(
  SessionStepsRecord sessionStep,
) {
  return 'mp3${sessionStep.reference!.path}.mp3';
}

String generatePhotoStorageFilename(
  SessionStepsRecord sessionStep,
) {
  return 'photo${sessionStep.reference!.path}.jpg';
}

String generateVideoStorageFilename(
  SessionsRecord session,
) {
  return 'video${session.reference!.path}.mp4';
}

Future<List<SessionsRecord>> listSessionList({
  bool justCurrentUserAsTherapist = true,
}) async {
  //>print('(N12)${justCurrentUserAsModerator}');
  models.DocumentList docs;
  if (justCurrentUserAsTherapist) {
    docs = await listDocumentsWithOneQueryDocumentReference(
      collection: sessionsRef,
      attribute: kSessionTherapistId,
      value: currentUser!.reference,
      orderByAttribute: kDBcreatedAt,
    );
  } else {
    docs = await listDocuments(
      collection: sessionsRef,
      orderByAttribute: kDBcreatedAt,
    );
  }
  List<SessionsRecord> hh = [];
  for (models.Document d in docs.documents) {
    //>print('(N1)${d.$id}&&&&${d.data}');
    UsersRecord clientsRecord = await getUser(
      document: DocumentReference(path: (d.data[kSessionClientId] as String?)),
    );
    String clientDisplayName = clientsRecord.displayName!;
    SessionsRecord h = SessionsRecord(
      reference: DocumentReference(path: d.$id),
      clientId: DocumentReference(path: (d.data[kSessionClientId] as String?)),
      therapistId: DocumentReference(
        path: (d.data[kSessionTherapistId] as String?),
      ),
      $createdAt: DateTime.parse(d.$createdAt),
      $updatedAt: DateTime.parse(d.$updatedAt),
      clientDisplayName: clientDisplayName,
      videoCreated: d.data[kSessionVideoCreated] as bool?,
      videoLoaded: d.data[kSessionVideoLoaded] as bool?,
      sessionModified: d.data[kSessionSessionModified] as bool?,
    );
    hh.add(h);
  }
  //>print('(N1AA)${hh.length}');
  return hh;
}

/*
Future<void> setMaxVersionNumbersCurrentSessionStep() async {
  final int maxAudioVersion = await getMaxVersionNumber(
    bucketId: artTheopyAIRaudiosRef.path!,
    fileId: currentSessionStep!.reference!.path!,
  );
  final int maxPhotoVersion = await getMaxVersionNumber(
    bucketId: artTheopyAIRphotosRef.path!,
    fileId: currentSessionStep!.reference!.path!,
  );
  currentSessionStep!.maxAudioVersion = maxAudioVersion;
  currentSessionStep!.maxPhotoVersion = maxPhotoVersion;
  print(
    '(VC5)${currentSessionStep!.maxAudioVersion}....${currentSessionStep!.maxPhotoVersion}',
  );
}
*/

/*
Future<int> getMaxVersionNumber({
  required String bucketId,
  required String fileId,
}) async {
  print('(DE79)${bucketId}....${fileId}');
  models.FileList? fileList;
  try {
    fileList = await storage.listFiles(
      bucketId: bucketId,
      queries: [
        Query.contains(kAttrStorageId, fileId),
        Query.limit(kLimitStorageListDocuments),
      ],
    );
    print('(DE80)${fileList}');
    print('(DE81.0)${fileList.files.length}');
    int maxVersion = 0;
    if (fileList.files.length > 0) {
      // print('(DE81.1)${fileList.files.length}');
      // for (var file in fileList.files) {
      for (int i = 0; i < fileList.files.length; i++) {
        // print('(DE81.2)${i}');
        var file = fileList.files[i];
        // print('(DE81.3)${i}...${file.$id}');
        List<String> filenameSplit1 = file.$id.split('_');
        // print('(DE81.4)${i}...${filenameSplit1}');
        List<String> filenameSplit2 = filenameSplit1[1].split('.');
        // print('(DE81.5)${filenameSplit2}');
        int? version = int.tryParse(filenameSplit2[0]);
        // print('(DE81.6)${version}');
        if (version == null) {
          version = 0;
        }
        if (version > maxVersion) {
          maxVersion = version;
        }
        // print(
          // '(DE81.7)${file.name}....${filenameSplit2[0]}----${version}----${maxVersion}',
        // );
      }
    }
    print('(DE81.8)${maxVersion}');
        return maxVersion;
  } on AppwriteException catch (e) {
    print('(DE83)${e}....${e.code}');
    return 0;
  }
}
*/

Future<List<SessionStepsRecord>> listSessionStepList({
  required SessionsRecord? thisSession,
}) async {
  print('(DE410D)${sessionStepsRef.path}....${thisSession}');
  models.DocumentList docs;
  if (thisSession != null) {
    docs = await listDocumentsWithOneQueryDocumentReference(
      collection: sessionStepsRef,
      attribute: kSessionStepSessionId,
      value: thisSession!.reference,
      orderByAttribute: kSessionStepIndex,
    );
  } else {
    docs = await listDocuments(
      collection: sessionsRef,
      orderByAttribute: kSessionStepIndex,
    );
  }
  print('(SS16)${docs.documents.length}');
  List<SessionStepsRecord> hh = [];

  for (models.Document d in docs.documents) {
    /*  int maxPhotoVersion = await getMaxVersionNumber(
      bucketId: artTheopyAIRphotosRef.path!,
      fileId: d.$id,
    );
    int maxAudioVersion = await getMaxVersionNumber(
      bucketId: artTheopyAIRaudiosRef.path!,
      fileId: d.$id,
    );
    print(
      '(SS13)${d.$id}&&&&${d.data[kSessionStepPhoto]}^^^^${maxPhotoVersion}',
    );

  */

    // bool photoFileValid = await File(appDirPath! + '/photo' + d.$id + '.jpg').exists();
    bool photoFileValid =
        await File(getFilePath(FileKind.photo, d.$id)).exists();
    bool audioFileValid = await File(getFilePath(FileKind.aac, d.$id)).exists();
    print('(PE1)${appDirPath! + '/photo' + d.$id + '.jpg'}....${photoFileValid}');

    SessionStepsRecord h = SessionStepsRecord(
      reference: DocumentReference(path: d.$id),
      sessionId: DocumentReference(
        path: (d.data[kSessionStepSessionId] as String?),
      ),
      photo: DocumentReference(path: (d.data[kSessionStepPhoto] as String?)),
      audio: DocumentReference(path: (d.data[kSessionStepAudio] as String?)),
      completed: d.data[kSessionStepCompleted] as bool,
      transcription: d.data[kSessionStepTranscription] as String,
      index: d.data[kSessionStepIndex] as int,
      question: d.data[kSessionStepQuestion] as String,
      // maxPhotoVersion: maxPhotoVersion,
      // maxAudioVersion: maxAudioVersion,
      photoFileValid: photoFileValid,
      audioFileValid: audioFileValid,
    );
    print('(SS40)${hh.length}....${h.photo},,,,${h.index}');
    hh.add(h);
    print('(SS41)${hh.length}');
  }
  print('(SS42)${hh.length}');
  return hh;
}

SessionStepsRecord extractSessionStepRecord(models.Document d) {
  print('(SS80)${d.$id}&&&&${d.data[kSessionStepPhoto]}');
  SessionStepsRecord h = SessionStepsRecord(
    reference: DocumentReference(path: d.$id),
    sessionId: DocumentReference(
      path: (d.data[kSessionStepSessionId] as String?),
    ),
    photo: DocumentReference(path: (d.data[kSessionStepPhoto] as String?)),
    audio: DocumentReference(path: (d.data[kSessionStepAudio] as String?)),
    completed: d.data[kSessionStepCompleted] as bool,
    transcription: d.data[kSessionStepTranscription] as String,
    index: d.data[kSessionStepIndex] as int,
    question: d.data[kSessionStepQuestion] as String,
  );
  return h;
}

Future<SessionsRecord> getSession({DocumentReference? document}) async {
  models.Document d = await getDocument(
    collection: sessionsRef,
    document: document,
  );
  ////>print('(M1)${doc.data['chapterColorInts'].runtimeType}****${doc.data['chapterColorInts']}');
  SessionsRecord h = SessionsRecord(
    reference: DocumentReference(path: d.$id),
    clientId: DocumentReference(path: (d.data[kSessionClientId] as String?)),
    therapistId: DocumentReference(
      path: (d.data[kSessionTherapistId] as String?),
    ),
    $createdAt: DateTime.parse(d.$createdAt),
    $updatedAt: DateTime.parse(d.$updatedAt),
    videoCreated: d.data[kSessionVideoCreated] as bool?,
    videoLoaded: d.data[kSessionVideoLoaded] as bool?,
    sessionModified: d.data[kSessionSessionModified] as bool?,
  );
  //>print('(N5005)${h}');
  return h;
}

Future<SessionStepsRecord> getSessionStep({DocumentReference? document}) async {
  models.Document d = await getDocument(
    collection: sessionsRef,
    document: document,
  );
  ////>print('(M1)${doc.data['chapterColorInts'].runtimeType}****${doc.data['chapterColorInts']}');
  SessionStepsRecord h = SessionStepsRecord(
    reference: DocumentReference(path: d.$id),
    sessionId: DocumentReference(
      path: (d.data[kSessionStepSessionId] as String?),
    ),
    photo: DocumentReference(path: (d.data[kSessionStepPhoto] as String?)),
    audio: DocumentReference(path: (d.data[kSessionStepAudio] as String?)),
    completed: d.data[kSessionStepCompleted] as bool,
    transcription: d.data[kSessionStepTranscription] as String,
    index: d.data[kSessionStepIndex] as int,
    question: d.data[kSessionStepQuestion] as String,
    $createdAt: DateTime.parse(d.$createdAt),
    $updatedAt: DateTime.parse(d.$updatedAt),
  );
  //>print('(N5005)${h}');
  return h;
}

Future<List<UsersRecord>> listUsersListWithEmail({String? email}) async {
  models.DocumentList docs;
  //>print('(N2106)${email}¤¤¤¤${usersRef}');
  if (email == null) {
    docs = await listDocuments(collection: usersRef);
  } else {
    docs = await listDocumentsWithOneQueryString(
      collection: usersRef,
      attribute: 'email',
      value: email,
    );
  }
  List<UsersRecord> uu = [];
  for (models.Document d in docs.documents) {
    List<dynamic> cCIList = d.data['chapterColorInts'] as List<dynamic>;
    List<int> cCListInt = [];
    for (var cCIItem in cCIList) {
      cCListInt.add(cCIItem as int);
    }
    //>print('(NY7)${cCListInt}');
    UsersRecord u = UsersRecord(
      reference: DocumentReference(path: d.$id),
      email: (d.data[kUserEmail] as String?),
      displayName: (d.data[kUserDisplayName] as String?),
      phoneNumber: (d.data[kUserPhoneNumber] as String?),
      role: (d.data[kUserRole] as String?),
      userMessage: (d.data[kUserUserMessage] as String?),
      therapistId: (d.data[kUserTherapistId] as String?),
      // productId: (d.data[kUserProductId] as String?),
      applicationUserName: (d.data[kUserApplicationUserName] as String?),
      // purchaseID: (d.data[kUserPurchaseID] as String?),
      // pendingCompletePurchase: (d.data[kUserPendingCompletePurchase] as bool?),
      // purchaseDetailsStatus: (d.data[kUserPurchaseDetailsStatus] as String?),
      // localVerificationData: (d.data[kUserLocalVerificationData] as String?),
      // serverVerificationData: (d.data[kUserServerVerificationData] as String?),
      //   transactionDateTime: (d.data[kUserTransactionDateTime] as DateTime?),
      cumulativeSessions: (d.data[kUserCumulativeSessions] as int?),
      // purchaseStatus: (d.data[kUserPurchaseStatus] as String?),
      archiveSessions: (d.data[kUserArchiveSessions] as bool?),
    );
    uu.add(u);
  }
  return uu;
}

Future<List<UsersRecord>> listUsersClientsOfUser(
    {DocumentReference? therapist}) async {
  models.DocumentList docs;
  print('(N22106)${therapist}¤¤¤¤${usersRef}');
  if (therapist == null) {
    docs = await listDocuments(collection: usersRef);
  } else {
    docs = await listDocumentsWithOneQueryString(
      collection: usersRef,
      attribute: kUserTherapistId,
      value: therapist.path,
    );
  }
  List<UsersRecord> uu = [];
  for (models.Document d in docs.documents) {
    print('(NY227)${docs.documents.length}');
    UsersRecord u = UsersRecord(
      reference: DocumentReference(path: d.$id),
      email: (d.data[kUserEmail] as String?),
      displayName: (d.data[kUserDisplayName] as String?),
      phoneNumber: (d.data[kUserPhoneNumber] as String?),
      role: (d.data[kUserRole] as String?),
      userMessage: (d.data[kUserUserMessage] as String?),
      therapistId: (d.data[kUserTherapistId] as String?),
      // productId: (d.data[kUserProductId] as String?),
      applicationUserName: (d.data[kUserApplicationUserName] as String?),
      // purchaseID: (d.data[kUserPurchaseID] as String?),
      // pendingCompletePurchase: (d.data[kUserPendingCompletePurchase] as bool?),
      // purchaseDetailsStatus: (d.data[kUserPurchaseDetailsStatus] as String?),
      // localVerificationData: (d.data[kUserLocalVerificationData] as String?),
      // serverVerificationData: (d.data[kUserServerVerificationData] as String?),
      // transactionDateTime: (d.data[kUserTransactionDateTime] as DateTime?),
      cumulativeSessions: (d.data[kUserCumulativeSessions] as int?),
      // purchaseStatus: (d.data[kUserPurchaseStatus] as String?),
      archiveSessions: (d.data[kUserArchiveSessions] as bool?),
    );

    uu.add(u);
  }
  print('(NY228)${uu.length}');
  return uu;
}

Future<List<ConstraintsRecord>> listConstraintsList() async {
  print('(CC10)${constraintsRef}');
  models.DocumentList docs;
  docs = await listDocuments(
    collection: constraintsRef,
    orderByAttribute: 'level',
  );
  List<ConstraintsRecord> cc = [];
  for (models.Document d in docs.documents) {
    print('(CC1)${d.$id}&&&&${d.data}');
    ConstraintsRecord c = ConstraintsRecord(
      noOfHyperbooks: (d.data['noOfHyperbooks'] as int?),
      noOfUsersPerHyperbook: (d.data['noOfUsersPerHyperbook'] as int?),
      level: (d.data['level'] as int?),
    );
    cc.add(c);
  }
  print('(CC2)${cc.length}++++${cc}');
  return cc;
}

Future<void> setUserPrefs({
  required Account account,
  List<Color>? colorArray,
}) async {
  //>print('(N55A)${account}****${colorArray}');
  int x = colorArray![0].value;
  //>print('(N55B)${x}');
  final user = await account.get();
  Map<String, int> prefMap = {};
  if (user != null) {
    for (int i = 0; i < colorArray.length; i++) {
      prefMap['color${i.toString()}'] = colorArray[i].value;
    }
    var response = await account.updatePrefs(prefs: prefMap);
    models.Preferences prefs = await account.getPrefs();
    //>print('(N56)${prefs.data['color0']}****${response.prefs}');
    ;
  }
}

Future<UsersRecord?> appwriteLogin(
  BuildContext context,
  String email,
  String password,
) async {
  models.User? user;
  models.Session? session;
  print('(N91A)${email}****${password}');
  try {
    session = await account!.createEmailPasswordSession(
      email: email,
      password: password,
    );
  } on AppwriteException catch (e) {
    print('(N91B)${e.type}****${e.message}');
    if (e.message!.startsWith('Creation of a session is prohibited')) {
      print('(N91C)${email}****${password}');

      try {
        await appwriteLogout();
      } on AppwriteException catch (e) {
        print('(N91D)${e.type}****${e.message}');
        toast(context, 'Error on logging in 1', ToastKind.error);
      }
      print('(N91E)${email}****${password}');
      loggedIn = false;
      try {
        session = await account!.createEmailPasswordSession(
          email: email,
          password: password,
        );
      } on AppwriteException catch (e) {
        print('(N91FA)${e.type}****${e.message}');
        toast(context, 'Error on logging in 2', ToastKind.error);
      }
    }
  }

  try {
    user = await account!.get();
  } on AppwriteException catch (e) {
    print('(N91FB)${e.type}****${e.message}');
    toast(context, 'Error on logging in 3', ToastKind.error);
  }

  if (user == null) {
    toast(context, 'No account or wrong password', ToastKind.error);
  }

  print('(N91G)${user}');
  print('(N91H)${user!.name}++++${user!.$id}');

  //setState(() {
  loggedInUser = user;

  currentUser = await getUser(document: DocumentReference(path: user!.$id));
  print('(N91I)${currentUser}');
  print('(N91J)${currentUser!.reference!.path}');
  print('(N91K)${currentUser!.displayName}');

  //> print(
  //>     '(N91O)${user.$id}****${currentUser!.reference!.path}!!!!${currentUser!.chapterColorInts}');
  currentUserDisplayName = currentUser!.displayName!;
  currentUserEmail = currentUser!.email!;
  return currentUser;
  // });
}

Future<void> getCurrentUserDetails() async {
  models.User user = await account!.get();
}

Future<void> appwriteLogout() async {
  await account!.deleteSessions();
}

Future<void> appwritePhoneLogin() async {
  account!.createPhoneVerification();
}

Future<UsersRecord> appwriteCreateAccount(String email, String password) async {
  String id = getRandomNumericString(20);
  models.User user = await account!.create(
    userId: id,
    email: email,
    password: password,
    name: 'Unknown',
  );
  print('(N5000)${user}&&&&${user.email}....${id}');
  await createUser(
    reference: DocumentReference(path: id),
    email: email,
    displayName: 'Unknown',
    phoneNumber: '',
    role: kRoleTherapist,
    // userReference: DocumentReference(path: id),
    id: id,
    userLevel: kUserLevelFree,
    userMessage: 'Welcome to the Hyperbook App',
    // therapistId: currentUser!.reference!.path,
  );

  loggedInUser = user;
  currentUser = await getUser(document: DocumentReference(path: user.$id));
  currentUserDisplayName = currentUser!.displayName!;
  currentUserEmail = currentUser!.email!;
  // });
  print('(N5002)${currentUser}');
  return currentUser!;
}

Future<void> deleteUser() async {
  print('(DD100)${currentUser!.reference!.path}');
  try {
    models.User user = await account!.get();
    //The following blocks the current logged on user -- Appwrite has no delete user function
    models.User result = await account!.updateStatus();
  } on Exception catch (e) {
    print('(DD101)${e}');
  }
  print('(DD102)${result}');
}

bool canUserSeeSession(DocumentReference? user, SessionsRecord? session) {
  //>print('(N404A)${Session!.title}####${user}&&&&${Session!.nonMemberRole}');
  if (currentUser!.reference == null) return false;
  if (session == null) return false;
  final String role = currentUser!.role!;
  if ((role == null) || (role == '') || (role == kRoleNotLoggedIn)) {
    //>print('(N404R)${role}');
    return false;
  } else {
    if ((role == kRoleSupervisor) || (role == kRoleAdministrator)) {
      //>print('(N404S)${role}');
      return true;
    } else {
      //>print('(N404T)${role}');
      if ((role == kRoleTherapist) &&
          (session.therapistId!.path == currentUser!.reference!.path)) {
        return true;
      }

      return false;
    }
  }
}

Storage storage = Storage(client!);

Future<String?> createStorageImageFile({
  required DocumentReference? chapter,
  required DocumentReference? user,
  required String? path,
  required String? name,
  required Uint8List bytes,
}) async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyyMMddkkmms');
  String randomFileNumber = getRandomNumericString(15);
  // List<String> splitFilename = name!.split('.');
  // final String preffix = splitFilename.first;
  // final String suffix = splitFilename.last;
  final String truncatedName =
      (name!.length > 15) ? name.substring(0, 15) : name;
  final String fileId =
      chapter!.path! + kStorageFilenameSpitString + randomFileNumber;
  final String storageFilename =
      chapter.path! + kStorageFilenameSpitString + truncatedName;
  //>print('(QE30)${fileId}++++${storageFilename}');

  models.File result = await storage.createFile(
    bucketId: artTheopyAIRphotosRef.path!,
    fileId: fileId,
    file: InputFile.fromBytes(bytes: bytes, filename: storageFilename),
  );
  var file = await storage.getFile(
    bucketId: artTheopyAIRphotosRef.path!,
    fileId: fileId,
  );
  //String url = file.
  //>print('(IS1)${file.toString()}++++${result.name}@@@@${file.name}~~~~');

  const String head = imageFilenameHead;
  final b_id = artTheopyAIRphotosRef.path!;
  final f_id = fileId;
  final p_id = kProjectID;
  final String url =
      '${head}/${b_id}/files/${f_id}/preview?project=${p_id}&mode=admin';
  //>print('(IS2)${head}££££${url}????');

  return url;
}

Future<String?> storeStorageFile({
  required String? bucketId,
  required String? storageFileId,
  required String? localFilePath,
  bool deleteIfNecessary = false,
}) async {
  print('(AU70A)${bucketId},,,,${storageFileId}...${localFilePath}');
  if (deleteIfNecessary) {
    if (await doesStorageFileExist(bucketId: bucketId, fileId: storageFileId)) {
      await deleteStorageFile(bucketId: bucketId, fileId: storageFileId);
      print('(AU71)');
    }
  }
  print('(AU70B)${bucketId},,,,${storageFileId}...${localFilePath}');
  models.File result = await storage.createFile(
    bucketId: bucketId!,
    fileId: storageFileId!,
    file: InputFile.fromPath(path: localFilePath!,
    ),
  );
  print('(AU70C)${result},,,,${result.name}...${result.$id}');
  var file = await storage.getFile(bucketId: bucketId, fileId: storageFileId);
  print('(AU72)${file.toString()}++++${result.name}@@@@${file.name}~~~~');
  const String head = imageFilenameHead;
  final b_id = artTheopyAIRphotosRef.path!;
  final f_id = storageFileId;
  final p_id = kProjectID;
  final String url =
      '${head}/${b_id}/files/${f_id}/preview?project=${p_id}&mode=admin';
  print('(AU73)${head}££££${url}????');
  return url;
}

/*
Future<String?> getStorageFileDownload({
  String? bucketId,
  models.File? file,
}) async {
  String? localBucketId = bucketId;
  if (bucketId == null) {
    localBucketId = backupStorageRef.path!;
  }
  Uint8List bytes = await storage.getFileDownload(
    bucketId: backupStorageRef.path!,
    fileId: file!.$id,
  );
  String s = utf8.decode(bytes);
  //>print('(XY30)${file!.$id}++++${bytes.length}****${s}');
  return s;
}
*/

Future<void> deleteFile(String path) async {
  dartio.File file = dartio.File(path);
  try {
    if (await file.exists()) {
      await file.delete();
    }
  } catch (e) {
    print('(DE50)${e}....${path}');
  }
}

String getFilePath(FileKind fileKind, String item) {
  String prefix = '';
  String suffix = '';
  switch (fileKind) {
    case FileKind.photo:
      prefix = 'photo';
      suffix = '.jpg';
      break;
    case FileKind.video:
      prefix = 'video';
      suffix = '.mp4';
      break;
    case FileKind.wav:
      prefix = 'wav';
      suffix = '.wav';
      break;
    case FileKind.mp3:
      prefix = 'mp3';
      suffix = '.mp3';
      break;
    case FileKind.aac:
      prefix = 'aac';
      suffix = '.aac';
      break;
    case null:
      break;
  }
  return appDirPath! + '/' + prefix + item + suffix;
}

Future<bool> copySessionStepStorageFiletoLocal({
  required String? bucketId,
  required String? fileId,
  required String? localPath,
  required FileKind? fileKind,
}) async {
  await deleteFile(localPath!);
  String? localBucketId = bucketId;
  if (bucketId == null) {
    localBucketId = backupStorageRef.path!;
  }
  print('(DE70A)${fileId}....${localPath}');
  // printTempDirListing();
  String token = '';
  switch (fileKind) {
/*    case FileKind.audio:
      token = 'audio';
      break;*/
    case FileKind.photo:
      token = 'photo';
      break;
    case FileKind.video:
      token = 'video';
      break;
    case FileKind.wav:
      token = 'wav';
      break;
    case FileKind.mp3:
      token = 'mp3';
      break;
    case FileKind.aac:
      token = 'aac';
      break;
    case null:
      break;
  }
  final utf8Encoder = utf8.encoder;
  List<String> dirPath = localPath.split('/${token}');
  print('(DE70B)${dirPath[0]}');
  var dir = Directory.fromRawPath(utf8Encoder.convert(dirPath[0]));
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    print('(DE71)${entity.path}');
    if (entity.path.contains(token)) {
      File file = File(entity.path);
      print('DE72)${entity.path}');
      await file.delete();
    }
  }
  print('(DE73)${localBucketId},,,,${fileId}----${dirPath[0]}...${dirPath[1]}');
  await storage
      .getFileDownload(bucketId: localBucketId!, fileId: fileId!)
      .then((bytes) {
    print('(DE74)${bytes.length}....${localPath}');
    final file = File(localPath);
    file.writeAsBytesSync(bytes);
  }).catchError((error) {
    print('(DE75)${error.response}');
  });

  return true;
}
/*

Future<bool> copyAnyStorageFiletoLocal({
  required String? bucketId,
  required String? fileId,
  required String? localPath,
}) async {
  await deleteFile(localPath!);
  String? localBucketId = bucketId;
  if (bucketId == null) {
    localBucketId = backupStorageRef.path!;
  }
  final utf8Encoder = utf8.encoder;
  final List<String> dirPathSplit = localPath.split('/');
  // final localFilename = dirPathSplit.last;
  //print('(DE70B)${dirPath[0]}');
  final String dirPath = localPath.replaceFirst(dirPathSplit.last, '');
  var dir = Directory.fromRawPath(utf8Encoder.convert(dirPath));
  print('(DE70AA)${fileId}....${localPath},,,,${dirPath}++++${dir.path}');
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    print('(DE71)${entity.path}....${fileId}');
    if (entity.path.contains(fileId!)) {
      File file = File(entity.path);
      print('(DE72)${entity.path}');
      await file.delete();
    }
  }
  print('(DE73)${localBucketId},,,,${fileId}----${dirPathSplit[0]}...${dirPathSplit[1]}');
  await storage.getFileDownload(bucketId: localBucketId!, fileId: fileId!).then((bytes) {
    print('(DE74)${bytes.length}....${localPath}');
    final file = File(localPath);
    file.writeAsBytesSync(bytes);
  }).catchError((error) {
    print('(DE75)${error.response}');
  });
  print('(DE76)');
  printAppDirListing();
  return true;
}
*/

Future<bool> copyAnyStorageFiletoLocal({
  required String? bucketId,
  required String? fileId,
  required String? localPath,
}) async {
  await deleteFile(localPath!);
  String? localBucketId = bucketId;
  if (bucketId == null) {
    localBucketId = backupStorageRef.path!;
  }
  print('(DE172)${localPath}');
  final File localFile = File(localPath);
  var deleteResponse;
  try {
    var deleteResponse = await localFile.delete();
  } on Exception catch (e) {
    print('(DE179)${e}....${deleteResponse}');
  }
  print('(DE173)${deleteResponse}>>>>${localBucketId},,,,${fileId}');
  Uint8List bytes =
      await storage.getFileDownload(bucketId: localBucketId!, fileId: fileId!);
  print('(DE174)${bytes.length}....${localPath}');
  localFile.writeAsBytesSync(bytes);
  print('(DE176)');
  printAppDirListing();
  return true;
}

Future<void> printTempDirListing() async {
  final utf8Encoder = utf8.encoder;
  var dir = Directory.fromRawPath(utf8Encoder.convert(tempDirPath!));
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    print('(TD2)${entity.path}');
  }
}

Future<void> printFontsDirListing() async {
  final utf8Encoder = utf8.encoder;
  var dir = Directory.fromRawPath(utf8Encoder.convert('/system/fonts/'));
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    print('(FD2)${entity.path}');
  }
}

Future<void> printAppDirListing() async {
 /* final utf8Encoder = utf8.encoder;
  var dir = Directory.fromRawPath(utf8Encoder.convert(appDirPath!));
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    print('(AD2)${entity.path}');
  }*/
}

Future<void> emptyAppDir() async {
  final utf8Encoder = utf8.encoder;
  print('(AD9A)${appDirPath}');
  var dir = Directory.fromRawPath(utf8Encoder.convert(appDirPath!));
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    print('(AD9B)${entity.path}');
    await entity.delete(recursive: false);
  }
}

Future<void> emptyTempDirOFPhotosVideosConcat() async {
  final utf8Encoder = utf8.encoder;
  var dir = Directory.fromRawPath(utf8Encoder.convert(tempDirPath!));
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    print('(TD9)${entity.path}');
    if ((entity.path.contains('photo')) ||
        (entity.path.contains('video')) ||
        (entity.path.contains('question'))||
        (entity.path.contains('concat'))) {
      await entity.delete(recursive: false);
    }
  }
}

Future<List<String>> getAppDirListing() async {
  final utf8Encoder = utf8.encoder;
  List<String> result = [];
  var dir = Directory.fromRawPath(utf8Encoder.convert(appDirPath!));
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    result.add(entity.path);
  }
  print('(AD3)${result}');
  return result;
}

Future<List<String>> getSessionStepAppDirListing(String sessionStepId) async {
  final utf8Encoder = utf8.encoder;
  List<String> result = [];
  var dir = Directory.fromRawPath(utf8Encoder.convert(appDirPath!));
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    if (entity.path.contains(sessionStepId)) {
      result.add(entity.path);
    }
  }
  print('(AD3)${result}');
  return result;
}

Future<bool> isFileInAppDir(String filename) async {
  List<String> listing = await getAppDirListing();
  for (int i = 0; i < listing.length; i++) {
    if (listing[i].contains(filename)) {
      return true;
    }
  }
  return false;
}

Future<bool> copyFiletoAppDir({
  required String? sourcePath,
  required String? targetPath,
}) async {
  List<String> targetFilenameSplit = targetPath!.split('/');
  String targetFilename = targetFilenameSplit.last;
  File sourceFile = File(sourcePath!);
  print('(AD20)${sourcePath}....${targetFilename}');
  if (await isFileInAppDir(targetFilename)) {
    print('(AD21)${sourcePath}....${targetFilename}');
    await deleteAppFile(targetFilename);
  }
  File outputFile = await sourceFile.copy(appDirPath! + '/' + targetFilename);
  print('(AD22)${outputFile}....${outputFile.existsSync()}');
  return (outputFile.existsSync());
}

Future<void> deleteAppFile(String filename) async {
  final utf8Encoder = utf8.encoder;
  var dir = Directory.fromRawPath(utf8Encoder.convert(appDirPath!));
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    if (entity.path.contains(filename)) {
      File file = File(entity.path);
      print('(AD6)${entity.path}');
      await file.delete();
      break;
    }
  }
}

Future<String?> readStorageFile({
  required DocumentReference? user,
  required String? hyperbookTitle,
  required int? versionNumber,
}) async {
  String expandedFilename = user!.path! +
      '_' +
      hyperbookTitle! +
      '-' +
      versionNumber.toString() +
      '.json';
  Uint8List bytes = await storage.getFileDownload(
    bucketId: backupStorageRef.path!,
    fileId: expandedFilename,
  );
  String s = utf8.decode(bytes);
  //>print('(XY10)${expandedFilename}++++${bytes.length}****${s}');
  return s;
}

Future<void> deleteStorageFile({
  required String? bucketId,
  required String? fileId,
}) async {
  try {
    await storage.deleteFile(bucketId: bucketId!, fileId: fileId!);
  } catch (e) {
    print('(AU110B)${fileId}....${e}');
  }
  print('(AU110A)${fileId}');
}

Future<models.FileList> listStorageFiles({String? bucketId}) async {
  print(
    '(XY6)${bucketId}....${kAttrStorageName}',
  );
  models.FileList fileList = models.FileList(total: 0, files: []);
  try {
    fileList = await storage.listFiles(
      bucketId: bucketId!,
      queries: [
        Query.limit(kLimitStorageListDocuments),
      ],
    );
    print('(XY7A)${fileList.files.length}');
  } catch (e) {
    //>print('(XY9)${e.toString()}');
  }
  return fileList;
}

/*
Future<models.FileList> listStorageFilesOfSessionStep({String? bucketId, String? sessionStepId}) async {
  print(
    '(XY6)${bucketId}....${kAttrStorageName}',
  );
  models.FileList fileList = models.FileList(total: 0, files: []);
  try {
    fileList = await storage.listFiles(
      bucketId: bucketId!,
      queries: [
        Query.limit(kLimitStorageListDocuments),
        Query.contains(fileId, sessionStepId)
      ],
    );
    print('(XY7A)${fileList.files.length}');
  } catch (e) {
    //>print('(XY9)${e.toString()}');
  }
  return fileList;
}
*/

Future<bool> doesStorageFileExist({String? bucketId, String? fileId}) async {
  print('(XY60)${bucketId}....${fileId}');
  models.FileList fileList = models.FileList(total: 0, files: []);
  try {
    fileList = await storage.listFiles(
      bucketId: bucketId!,
      queries: [
        Query.contains("name", fileId),
      ],
    );
    print('(XY61A)${fileList.files.length}++++${fileId}');
    for (var file in fileList.files){
      print('(XY61B)${file.name}....${file.bucketId},,,,${file.signature}');
    }
  } catch (e) {
    //>print('(XY9)${e.toString()}');
  }
  return (fileList.files.length > 0);
}

Future<models.FileList> listStorageFilesOfStorageStep(
    {required String? bucketId, required String? sessionStepId}) async {
  print(
    '(XY6)${bucketId}....${kAttrStorageName}----${sessionStepId}',
  );
  models.FileList fileList = models.FileList(total: 0, files: []);
  try {
    fileList = await storage.listFiles(
      bucketId: bucketId!,
      queries: [
        Query.contains(kAttrStorageId, sessionStepId),
        Query.limit(kLimitStorageListDocuments),
      ],
    );
    print('(XY7A)${fileList.files.length}');
  } catch (e) {
    //>print('(XY9)${e.toString()}');
  }
  return fileList;
}

Future<void> deleteImagesInChapter({required DocumentReference chapter}) async {
  //>print('(MI5)${chapter.path}');
  models.FileList fileList = await storage.listFiles(
    bucketId: artTheopyAIRphotosRef.path!, // bucketId
    queries: [
      Query.contains("name", [chapter.path]),
    ], // queries (optional)
  );
  for (models.File f in fileList.files) {
    //>  print(
    //>      '(MI6)${imageStorageRef.path!}~~~~${f.name}++++${f.signature}&&&&${f.$id}');
    storage.deleteFile(bucketId: artTheopyAIRphotosRef.path!, fileId: f.$id);
  }
}

setupTutorialUser(BuildContext context) async {
  // BaseAuthUser? user =
  //   await authManager.signInWithEmail(
  //       context,'info@hyperbook.co.uk', '244891'
  //   );
  UsersRecord? user;

  try {
    /*  user = await appwriteLogin(
      context,
      'info@hyperbook.co.uk',
      '244891244891',
    );
  */
    user = await appwriteLogin(context, 'info@hyperbook.co.uk', '244891244891');
  } catch (e) {
    //>print('(TU1)${e}');
    toast(context, 'Cannot setup guest user', ToastKind.error);
  }

  loggedIn = true;
  // localDB.hyperbooklocalDBValid = false;
  // await localDB.loadLocalDB(user: currentUser!.reference);
  print('(RW1)');
  // await localDB.dumpLocalDB();
  if (kIsWeb) {
    print('(RW2)${currentUser}');
    String? message = currentUser!.userMessage;
    print('(RW3)');
    bool showMessage = ((message != null) && (message != ''));
    print('(RW4)${message}....${showMessage}````${versionNumber}');
    if (showMessage) {
      List<String> splitMessage = message.split(kMessageSpitCharacter);
      if (message.contains(kMessageSpitCharacter)) {
        int? versiontoUpgradeTo = int.tryParse(splitMessage[1]);
        print('(RW5)${versiontoUpgradeTo}');
        if (versiontoUpgradeTo != null) {
          if (versionNumber < versiontoUpgradeTo) {
            await html.window.caches!.delete('flutter-app-manifest');
            await html.window.caches!.delete('flutter-app-cache');
            html.window.location.reload();
          }
        }
      }
    }
  }
}

Future<bool> executeFFmpeg(String command) async {
  print('(FF1)${command}');
  String logString = '(FF2)';
  Session ffmpegSession = await FFmpegKit.execute(command);
  final output = await ffmpegSession.getOutput();
  final returnCode = await ffmpegSession.getReturnCode();
  final duration = await ffmpegSession.getDuration();
  print(
      '(FF3)${returnCode!.toString()}....${returnCode.getValue()},,,,${output!.length}----${output.characters.length}>>>>${duration}');
  logString += '\n✅ Processing completed!\n';
  logString += 'Return code: $returnCode\n';
  logString += 'Duration: ${duration}ms\n';
  logString += 'Output: $output\n';
  debugPrint('session: $output');
  print(
      '>>>>>>>>(FF4)FFMPEG error: ${returnCode}, Duration: ${duration}, command: ${command}');
  if ((returnCode == 0) || (returnCode == '0')) {
    return true;
  } else {
    // toast(context, 'FFMPEG error: ${returnCode}, Duration: ${duration}, command: ${command}', ToastKind.error);
    return false;
  }
}

List<Widget> log = [];

Future<void> logString(String s) async {
  Map<String, dynamic> d = {
    kLogEmail: currentUser!.email,
    kLogdateTime: DateTime.now().toIso8601String(),
    kLogInfo: s,
  };
  print('(IAP30)${s}');
 models.Document doc = await createDocument(
     collection: logRef,
     data: d,
     id: '',
   );
  //print('(I1)${doc.$id}');
  // setState(() {
  /* log.add(Container(
      height: 60,
      decoration:
      BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      child: Text(s),
    ));*/
  // });
}
