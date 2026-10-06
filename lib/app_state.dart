import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/push_notifications/push_notifications_util.dart';

// import '/backend/backend.dart';
import 'flutter_flow/flutter_flow_util.dart';
import '../../custom_code/widgets/permissions.dart';
import '../../flutter_flow/random_data_util.dart' as random_data;
import '../../custom_code/widgets/toast.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'dart:math';
import 'appwrite_interface.dart';

final int versionNumber = 9;


// late SharedPreferences globalSharedPrefs;
DocumentReference? _introductionHyperbook;


class FFAppState extends ChangeNotifier {
  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();
  static final FFAppState _instance = FFAppState._internal();

  void update(VoidCallback callback) {
    callback();
    // notifyListenersFilter();
  }

  // late SharedPreferences globalSharedPrefs;

  DocumentReference? _currentHyperbook;
  DocumentReference? get currentHyperbook => _currentHyperbook;
  set currentHyperbook(DocumentReference? value) {
    _currentHyperbook = value;
  }

  String _currentHyperbookTitle = 'DummyTitle';
  String get currentHyperbookTitle => _currentHyperbookTitle;
  set currentHyperbookTitle(String value) {
    _currentHyperbookTitle = value;
  }

  List<Color> _chosenColors = <Color>[];
  List<Color> get chosenColors => _chosenColors;
  set chosenColors(List<Color> value) {
    _chosenColors = value;
  }

  void addToChosenColors(Color value) {
    _chosenColors.add(value);
  }

  void removeFromChosenColors(Color value) {
    _chosenColors.remove(value);
  }

  void removeAtIndexFromChosenColors(int index) {
    _chosenColors.removeAt(index);
  }

  void updateChosenColorsAtIndex(int index, Color Function(Color) updateFn) {
    _chosenColors[index] = updateFn(_chosenColors[index]);
  }

  int _currentChapterStateIndex = 0;
  int get currentChapterStateIndex => _currentChapterStateIndex;
  set currentChapterStateIndex(int value) {
    _currentChapterStateIndex = value;
  }

  String _currentChapterTitle = 'Unknown';
  String get currentChapterTitle => _currentChapterTitle;
  set currentChapterTitle(String value) {
    _currentChapterTitle = value;
    //notifyListenersFilter();
  }

  String _currentBody = '';
  String get currentBody => _currentBody;
  set currentBody(String value) {
    _currentBody = value;
  }

  List<int> _chaptersReadState = <int>[];
  List<int> get chaptersReadState => _chaptersReadState;
  set chaptersReadState(List<int> value) {
    _chaptersReadState = value;
  }

  void addToChaptersReadState(int value) {
    _chaptersReadState.add(value);
  }

  void removeFromChaptersReadState(int value) {
    _chaptersReadState.remove(value);
  }

  void removeAtIndexFromChaptersReadState(int index) {
    _chaptersReadState.removeAt(index);
  }

  void updateChaptersReadStateAtIndex(int index, int Function(int) updateFn) {
    _chaptersReadState[index] = updateFn(_chaptersReadState[index]);
  }

  List<DocumentReference> _chaptersRead = <DocumentReference>[];
  List<DocumentReference> get chaptersRead => _chaptersRead;
  set chaptersRead(List<DocumentReference> value) {
    _chaptersRead = value;
  }

  void addToChaptersRead(DocumentReference value) {
    _chaptersRead.add(value);
  }

  void removeFromChaptersRead(DocumentReference value) {
    _chaptersRead.remove(value);
  }

  void removeAtIndexFromChaptersRead(int index) {
    _chaptersRead.removeAt(index);
  }

  void updateChaptersReadAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    _chaptersRead[index] = updateFn(_chaptersRead[index]);
  }

  List<Color> _chaptersReadStateColors = <Color>[];
  List<Color> get chaptersReadStateColors => _chaptersReadStateColors;
  set chaptersReadStateColors(List<Color> value) {
    _chaptersReadStateColors = value;
  }

  void addToChaptersReadStateColors(Color value) {
    _chaptersReadStateColors.add(value);
  }

  void removeFromChaptersReadStateColors(Color value) {
    _chaptersReadStateColors.remove(value);
  }

  void removeAtIndexFromChaptersReadStateColors(int index) {
    _chaptersReadStateColors.removeAt(index);
  }

  void updateChaptersReadStateColorsAtIndex(
    int index,
    Color Function(Color) updateFn,
  ) {
    _chaptersReadStateColors[index] = updateFn(_chaptersReadStateColors[index]);
  }

  List<DocumentReference> _chaptersReadReferences = <DocumentReference>[];
  List<DocumentReference> get chaptersReadReferences => _chaptersReadReferences;
  set chaptersReadReferences(List<DocumentReference> value) {
    _chaptersReadReferences = value;
  }

  void addToChaptersReadReferences(DocumentReference value) {
    _chaptersReadReferences.add(value);
  }

  void removeFromChaptersReadReferences(DocumentReference value) {
    _chaptersReadReferences.remove(value);
  }

  void removeAtIndexFromChaptersReadReferences(int index) {
    _chaptersReadReferences.removeAt(index);
  }

  void updateChaptersReadReferencesAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    _chaptersReadReferences[index] = updateFn(_chaptersReadReferences[index]);
  }

  DocumentReference? _chosenModerator;
  DocumentReference? get chosenModerator => _chosenModerator;
  set chosenModerator(DocumentReference? value) {
    _chosenModerator = value;
  }
  /*

  HyperbookType? _chosenHyperbookType;
  HyperbookType? get chosenHyperbookType => _chosenHyperbookType;
  set chosenHyperbookType(HyperbookType? value) {
    _chosenHyperbookType = value;
  }
*/

  DocumentReference? _currentChapter;
  DocumentReference? get currentChapter => _currentChapter;
  set currentChapter(DocumentReference? value) {
    _currentChapter = value;
  }

 /* bool _filterByModerator = false;
  bool get filterByModerator => _filterByModerator;
  set filterByModerator(bool value) {
    _filterByModerator = value;
  }

  DocumentReference? get introductionHyperbook => _introductionHyperbook;
  set introductionHyperbook(DocumentReference? value) {
    _introductionHyperbook = value;
    value != null
        ? globalSharedPrefs.setString('ff_introductionHyperbook', value.path!)
        : globalSharedPrefs.remove('ff_introductionHyperbook');
  }
*/
  bool _canReadCurrentHyperbook = false;
  bool get canReadCurrentHyperbook => _canReadCurrentHyperbook;
  set canReadCurrentHyperbook(bool value) {
    _canReadCurrentHyperbook = value;
  }

  bool _canEditCurrentHyperbook = false;
  bool get canEditCurrentHyperbook => _canEditCurrentHyperbook;
  set canEditCurrentHyperbook(bool value) {
    _canEditCurrentHyperbook = value;
  }

  List<bool> _canRead = <bool>[];
  List<bool> get canRead => _canRead;
  set canRead(List<bool> value) {
    _canRead = value;
  }

  void addToCanRead(bool value) {
    _canRead.add(value);
  }

  void removeFromCanRead(bool value) {
    _canRead.remove(value);
  }

  void removeAtIndexFromCanRead(int index) {
    _canRead.removeAt(index);
  }

  void updateCanReadAtIndex(int index, bool Function(bool) updateFn) {
    _canRead[index] = updateFn(_canRead[index]);
  }

  List<bool> _canEdit = <bool>[];
  List<bool> get canEdit => _canEdit;
  set canEdit(List<bool> value) {
    _canEdit = value;
  }

  void addToCanEdit(bool value) {
    _canEdit.add(value);
  }

  void removeFromCanEdit(bool value) {
    _canEdit.remove(value);
  }

  void removeAtIndexFromCanEdit(int index) {
    _canEdit.removeAt(index);
  }

  void updateCanEditAtIndex(int index, bool Function(bool) updateFn) {
    _canEdit[index] = updateFn(_canEdit[index]);
  }

  bool _canReadThisHyperbook = false;
  bool get canReadThisHyperbook => _canReadThisHyperbook;
  set canReadThisHyperbook(bool value) {
    _canReadThisHyperbook = value;
  }

  bool _canCollaborateThisHyperbook = false;
  bool get canCollaborateThisHyperbook => _canCollaborateThisHyperbook;
  set canCollaborateThisHyperbook(bool value) {
    _canCollaborateThisHyperbook = value;
  }
}


void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );

bool isUserTheTherapist(DocumentReference user, SessionsRecord session) {
  //>print('(N403)${hyperbook.moderator!.path}****${currentUser!.reference!.path}');
  return (session.therapistId!.path == currentUser!.reference!.path);
}

const kIconDepreciated = Icon(Icons.thumb_down);
const kIconInfoStart = Icon(Icons.help_center_rounded);
// const kIconInfoStartWhite = Icon(Icons.help_center_rounded, color: Colors.white);
const kIconNotVisited = Icon(Icons.visibility_off);
const kIconVisited = Icon(Icons.battery_0_bar);
const kIconPariallyRead = Icon(Icons.battery_3_bar);
const kIconFullyRead = Icon(Icons.battery_full);
const kIconHighlighted = Icon(Icons.highlight);
const kIconChooseChapterState = Icon(Icons.palette);
const kIconChooseChapterStateWhite = Icon(Icons.palette, color: Colors.white);
const kIconHyperbookMap = Icon(Icons.share);
const kIconHyperbookMapWhite = Icon(Icons.share, color: Colors.white);
const kIconEditChapter = Icon(Icons.edit_note);
const kIconEditChapterWhite = Icon(Icons.edit_note, color: Colors.white);
const kIconPostComment = Icon(Icons.comment);
const kIconPostCommentWhite = Icon(Icons.comment, color: Colors.white);
const kIconReadChapter = Icon(Icons.visibility);
const kIconArrowForward = Icon(Icons.arrow_forward_ios);
const kIconSettings = Icon(Icons.settings);
final kIconSettingsWhite = Icon(Icons.settings, color: Colors.white);
const kIconBackArrow = Icon(Icons.arrow_back);
const kIconDelete = Icon(Icons.delete);
const kIconTelephone = Icon(Icons.call_rounded);
const kIconVisible = Icon(Icons.visibility_outlined);
const kIconNotVisible = Icon(Icons.visibility_off_outlined);
const kIconList = Icon(Icons.list_alt);
const kIconListWhite = Icon(Icons.list_alt, color: Colors.white);
const kIconRequestsOutstanding = Icon(Icons.star);
const kIconRequestsOutstandingRed = Icon(Icons.star, color: Colors.red);
const kIconRequest = Icon(Icons.local_library);
const kIconTutorial = Icon(Icons.school);
const kIconTutorialWhite = Icon(Icons.school, color: Colors.white);
final Widget kIconTutorialReverse = Container(
  child: Icon(Icons.school),
  color: Colors.white,
);
const kIconLogin = Icon(Icons.login);
const kIconLoginWhite = Icon(Icons.login, color: Colors.white);
final Widget kIconLoginReverse = Container(
  child: Icon(Icons.login),
  color: Colors.white,
);
const kIconProfile = Icon(Icons.person);
const kIconProfileWhite = Icon(Icons.person, color: Colors.white);
final Widget kIconProfileReverse = Container(
  child: Icon(Icons.person),
  color: Colors.white,
);
const kIconHyperbooks = Icon(Icons.folder_copy);
const kIconHyperbooksWhite = Icon(Icons.folder_copy, color: Colors.white);
final Widget kIconHyperbooksReverse = Container(
  child: Icon(Icons.folder_copy),
  color: Colors.white,
);
const kIconSave = Icon(Icons.save);
const kIconOpenBook = Icon(Icons.import_contacts);
const kIconFitScreen = Icon(Icons.fit_screen);
const kIconMinimize = Icon(Icons.minimize);
const kIconImage = Icon(Icons.image);
final Widget kIconImageWhite = Icon(Icons.image, color: Colors.white);
const kIconLeft = Icon(Icons.keyboard_arrow_left);
const kIconRight = Icon(Icons.keyboard_arrow_right);
const kIconNone = Icon(Icons.keyboard_arrow_down);
const kIconMinimizeAll = Icon(Icons.snowing);
final kIconMinimizeAllWhite = Container(
  child: Icon(Icons.snowing),
  color: Colors.white,
);
const kIconMenu = Icon(Icons.menu);
const kIconCancel = Icon(Icons.cancel);
const kIconUpgrade = Icon(Icons.upgrade);
const kIconAdd = Icon(Icons.add);

const Map<String, Icon> kIconMapStandard = {
  'thumb_down': Icon(Icons.thumb_down),
  'help_center_rounded': Icon(Icons.help_center_rounded),
  'white': Icon(Icons.help_center_rounded, color: Colors.white),
  'visibility_off': Icon(Icons.visibility_off),
  'battery_0_bar': Icon(Icons.battery_0_bar),
  'battery_3_bar': Icon(Icons.battery_3_bar),
  'battery_full': Icon(Icons.battery_full),
  'highlight': Icon(Icons.highlight),
  'palette': Icon(Icons.palette),
  'share': Icon(Icons.share),
  'edit_note': Icon(Icons.edit_note),
  'comment': Icon(Icons.comment),
  'visibility': Icon(Icons.visibility),
  'arrow_forward_ios': Icon(Icons.arrow_forward_ios),
  'settings': Icon(Icons.settings),
  'arrow_back': Icon(Icons.arrow_back),
  'delete': Icon(Icons.delete),
  'call_rounded': Icon(Icons.call_rounded),
  'visibility_outlined': Icon(Icons.visibility_outlined),
  'visibility_off_outlined': Icon(Icons.visibility_off_outlined),
  'list_alt': Icon(Icons.list_alt),
  'star': Icon(Icons.star),
  'local_library': Icon(Icons.local_library),
  'school': Icon(Icons.school),
  'login': Icon(Icons.login),
  'person': Icon(Icons.person),
  'folder_copy': Icon(Icons.folder_copy),
  'save': Icon(Icons.save),
  'open_book': Icon(Icons.import_contacts),
  'fit_screen': Icon(Icons.fit_screen),
  'minimize': Icon(Icons.minimize),
  'image': Icon(Icons.image),
  'snowing': Icon(Icons.snowing),
  'menu': Icon(Icons.menu),
  'cancel': Icon(Icons.cancel),
  'upgrade': Icon(Icons.upgrade),
  'add': Icon(Icons.add),
};

const Map<String, Widget> kIconMap = {
  "kIconDepreciated": kIconDepreciated,
  "kIconInfoStart": kIconInfoStart,
  // "kIconInfoStartWhite": kIconInfoStartWhite,
  "kIconNotVisited": kIconNotVisited,
  "kIconVisited": kIconVisited,
  "kIconPariallyRead": kIconPariallyRead,
  "kIconFullyRead": kIconFullyRead,
  "kIconHighlighted": kIconHighlighted,
  "kIconChooseChapterState": kIconChooseChapterState,
  "kIconChooseChapterStateWhite": kIconChooseChapterStateWhite,
  "kIconHyperbookMap": kIconHyperbookMap,
  "kIconHyperbookMapWhite": kIconHyperbookMapWhite,
  "kIconEditChapter": kIconEditChapter,
  "kIconEditChapterWhite": kIconEditChapterWhite,
  "kIconPostComment": kIconPostComment,
  "kIconPostCommentWhite": kIconPostCommentWhite,
  "kIconReadChapter": kIconReadChapter,
  "kIconArrowForward": kIconArrowForward,
  "kIconSettings": kIconSettings,
  //  "kIconSettingsWhite": kIconSettingsWhite,
  "kIconBackArrow": kIconBackArrow,
  "kIconDelete": kIconDelete,
  "kIconTelephone": kIconTelephone,
  "kIconVisible": kIconVisible,
  "kIconNotVisible": kIconNotVisible,
  "kIconList": kIconList,
  "kIconListWhite": kIconListWhite,
  "kIconRequestsOutstanding": kIconRequestsOutstanding,
  "kIconRequestsOutstandingRed": kIconRequestsOutstandingRed,
  "kIconRequest": kIconRequest,
  "kIconTutorial": kIconTutorial,
  "kIconTutorialWhite": kIconTutorialWhite,
  // "kIconTutorialReverse": kIconTutorialReverse,
  "kIconLogin": kIconLogin,
  "kIconLoginWhite": kIconLoginWhite,
  //  "kIconLoginReverse": kIconLoginReverse,
  "kIconProfile": kIconProfile,
  "kIconProfileWhite": kIconProfileWhite,
  //  "kIconProfileReverse": kIconProfileReverse,
  "kIconHyperbooks": kIconHyperbooks,
  "kIconHyperbooksWhite": kIconHyperbooksWhite,
  //  "kIconHyperbooksReverse": kIconHyperbooksReverse,
  "kIconSave": kIconSave,
  "kIconOpenBook": kIconOpenBook,
  "kIconFitScreen": kIconFitScreen,
  "kIconMinimize": kIconMinimize,
  "kIconMinimizeAll": kIconMinimizeAll,
  "kIconMenu": kIconMenu,
  "kIconCancel": kIconCancel,
  "kIconUpgrade": kIconUpgrade,
  "kIconAdd": kIconAdd,
  // "kIconImageReverse": kIconImageReverse,
};

// ScrollController? hyperbookDisplayscrollController;

enum HyperbookVisibiliy {
  visibleToAll,
  visibleToReadersAndWriters,
  VisibleOnlyToModerator,
  TitleAndBlurbVisible,
}

const kRoleNotLoggedIn = 'Not Logged In';
const kRoleClient = 'Client';
const kRoleTherapist = 'Therapist';
const kRoleSupervisor = 'Supervisor';
const kRoleAdministrator = 'Administrator';

const List<String> kRoleListWithoutAdministrator = [
  kRoleNotLoggedIn,
  kRoleClient,
  kRoleTherapist,
  kRoleSupervisor,
];

const List<String> kRoleList = [
  ...kRoleListWithoutAdministrator,
  kRoleAdministrator,
];

/*
class HyperbookType {
  HyperbookType(
      this.typeNumber,
      this.name,
      this.hyperbookVisibleToAll,
      this.hyperbookVisibleToReaders,
      this.hyperbookVisibleToWriters,
      this.requestButtonsVisibleToAll,
      this.writersCanEditOwnChapters,
      this.writerCanEditAllChapters, //????
      this.moderatorMustInviteReaders,
      this.moderatorMustInviteWriters,
      this.readersCanRequest,
      this.writersCanRequest,
      this.hyperbookVisibleToAllPlusLoggedOut,
      );
  int typeNumber = 0; //1
  String name = ''; //2
  bool hyperbookVisibleToAll = false; //3
  bool hyperbookVisibleToReaders = false; //4
  bool hyperbookVisibleToWriters = false; //5
  bool requestButtonsVisibleToAll = false; //6
  bool writersCanEditOwnChapters = false; //7
  bool writerCanEditAllChapters = false; //8
  bool moderatorMustInviteReaders = false; //9
  bool moderatorMustInviteWriters = false; //10
  bool readersCanRequest = false; //11
  bool writersCanRequest = false; //12
  bool hyperbookVisibleToAllPlusLoggedOut = false;
}

const kHItypeNumber = 0;
const kHIname = 1;
const kHIhyperbookVisibleToAll = 2;
const kHIhyperbookVisibleToReaders = 3;
const kHIhyperbookVisibleToWriters = 4;
const kHIrequestButtonsVisibleToAll = 5;
const kHIwritersCanEditOwnChapters = 6;
const kHIwriterCanEditAllChapters = 7;
const kHImoderatorMustInviteReaders = 8;
const kHImoderatorMustInviteWriters = 9;
const kHIreadersCanRequest = 10;
const kHIwritersCanRequest = 11;
const kHIhyperbookVisibleToAllPlusLoggedOut = 12;

const bool _t = true;
const bool _f = false;

const kHyperbookTutorialTypeNumber = 101;
const kHiddenTypeNumber = 102;

final List<HyperbookType> kHyperbookTypes = [
  //.............................1.......2...3...4...5...6...7...8...9..10..11..12
  HyperbookType(0, '', _f, _t, _t, _f, _t, _f, _t, _t, _f, _f, _f),
  HyperbookType(
      1, 'Discussion Group', _f, _t, _t, _f, _t, _f, _t, _t, _f, _f, _f),
  HyperbookType(
      2, 'Collaborative Document', _f, _t, _t, _f, _t, _t, _t, _t, _f, _f, _f),
  HyperbookType(3, 'Open forum', _t, _t, _t, _t, _t, _f, _f, _t, _f, _t, _f),
  HyperbookType(
      4, 'Open for Comments', _t, _t, _t, _t, _t, _f, _f, _f, _t, _t, _f),
  HyperbookType(
      5, 'Frozen Document', _t, _t, _t, _f, _f, _f, _f, _f, _f, _f, _f),
  HyperbookType(
      6, 'Closed Document', _f, _t, _t, _f, _f, _f, _t, _f, _f, _f, _f),
  HyperbookType(kHyperbookTutorialTypeNumber, 'Hyperbook Tutorial', _t, _t, _t,
      _f, _f, _f, _t, _f, _f, _f, _t),
  HyperbookType(
      kHiddenTypeNumber, 'Hidden', _f, _f, _f, _f, _f, _f, _f, _f, _f, _f, _f),
];
const kMaxUserHyperbookType = 7;

Map<String, Map<int, bool>> hyperbookIsVisible = {
  '' /*     */ : /*     */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _t,
    102: _f
  },
  kRoleReader: /*     */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleReviewer: /*   */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleContributor: /**/ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleEditor: /*     */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleAuthor: /*     */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
};

Map<String, Map<int, bool>> readAllowed = {
  '' /*     */ : /*     */ {
    0: _f,
    1: _f,
    2: _f,
    3: _t,
    4: _t,
    5: _t,
    6: _t,
    101: _t,
    102: _f
  },
  kRoleReader: /*     */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleReviewer: /*   */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleContributor: /**/ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleEditor: /*     */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleAuthor: /*     */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
};

Map<String, Map<int, bool>> writeAllowed = {
  '' /*     */ : /*     */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _t,
    102: _f
  },
  kRoleReader: /*     */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleReviewer: /*   */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleContributor: /**/ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleEditor: /*     */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleAuthor: /*     */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
};

Map<String, Map<int, bool>> commentAllowed = {
  '' /*     */ : /*     */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _t,
    102: _f
  },
  kRoleReader: /*     */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleReviewer: /*   */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleContributor: /**/ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleEditor: /*     */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleAuthor: /*     */ {
    0: _f,
    1: _t,
    2: _t,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
};

Map<String, Map<int, bool>> insertLinkAllowed = {
  '' /*     */ : /*     */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _t,
    102: _f
  },
  kRoleReader: /*     */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleReviewer: /*   */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleContributor: /**/ {
    0: _f,
    1: _t,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleEditor: /*     */ {
    0: _f,
    1: _t,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleAuthor: /*     */ {
    0: _f,
    1: _t,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
};

Map<String, Map<int, bool>> canRequest = {
  '' /*     */ : /*     */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _t,
    102: _f
  },
  kRoleReader: /*     */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleReviewer: /*   */ {
    0: _f,
    1: _f,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleContributor: /**/ {
    0: _f,
    1: _t,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleEditor: /*     */ {
    0: _f,
    1: _t,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
  kRoleAuthor: /*     */ {
    0: _f,
    1: _t,
    2: _f,
    3: _f,
    4: _f,
    5: _f,
    6: _f,
    101: _f,
    102: _f
  },
};

HyperbookType getHyperbookType(int type) {
  for (HyperbookType ht in kHyperbookTypes) {
    if (ht.typeNumber == type) {
      return ht;
    }
  }
  return kHyperbookTypes[0];
}

void invalidateHyperbookCache() async {
  hyperbookCacheValid = false;
  await loadCachedHyperbookLists(currentUserReference!/*, fromCache: false*/);
}



bool hyperbookCacheValid = false;
bool coonectedUsersCacheValid = false;
List<CachedHyperbook> cachedHyperbookList = [];
List<ReadReferencesRecord> cachedReadReferenceList = [];
CachedHyperbook? currentCachedHyperbook;
List<ChaptersRecord> currentCachedChapterList = [];
ChaptersRecord? currentCachedChapter;
ReadReferencesRecord? currentCachedReadRecord;
List<ConnectedUsersRecord> currentCachedConnectedUsers = [];




<span class='material-icons'>thumb_down</span>
<span class='material-icons'>help_center_rounded</span>
<span class='material-icons'>visibility_off</span>
<span class='material-icons'>battery_0_bar</span>
<span class='material-icons'>battery_3_bar</span>
<span class='material-icons'>battery_full</span>
<span class='material-icons'>highlight</span>
<span class='material-icons'>palette</span>
<span class='material-icons'>share</span>
<span class='material-icons'>edit_note</span>
<span class='material-icons'>comment</span>
<span class='material-icons'>visibility</span>
<span class='material-icons'>arrow_forward_ios</span>
<span class='material-icons'>settings</span>
<span class='material-icons'>arrow_back</span>
<span class='material-icons'>delete</span>
<span class='material-icons'>call_rounded</span>
<span class='material-icons'>visibility_outlined</span>
<span class='material-icons'>visibility_off_outlined</span>
<span class='material-icons'>list_alt</span>
<span class='material-icons'>star</span>
<span class='material-icons'>local_library</span>
<span class='material-icons'>school</span>
<span class='material-icons'>login</span>
<span class='material-icons'>person</span>
<span class='material-icons'>folder_copy</span>
<span class='material-icons'>save</span>


<span style="font-family:'material-icons';font-size:30px;">arrow_back</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">battery_0_bar</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">battery_3_bar</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">battery_full</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">call_rounded</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">cancel</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">comment</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">delete</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">edit_note</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">fit_screen</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">folder_copy</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">help_center_rounded</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">highlight</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">image</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">list_alt</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">local_library</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">login</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">menu</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">minimize</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">minimizeAll</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">open_book</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">palette</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">person</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">save</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">school</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">settings</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">share</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">star</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">thumb_down</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">visibility</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">visibility_off</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">visibility_off_outlined</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">visibility_outlined</span>:   <br>
<span style="font-family:'material-icons';font-size:30px;">white</span>:   <br>


 */
