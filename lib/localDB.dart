import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import '/flutter_flow/random_data_util.dart' as random_data;
import '../../appwrite_interface.dart';

const kAttHyperbookReference = 'reference';
const kAttHyperbookModerator = 'moderator';
const kAttHyperbookTitle = 'title';
const kAttHyperbookBlurb = 'blurb';
const kAttHyperbookStartChapter = 'startChapter';
const kAttHyperbookNonMemberRole = 'nonMemberRole';
const kAttHyperbookModeratorDisplayName = 'moderatorDisplayName';

const kDBid = '\$id';
const kDBcreatedAt = '\$createdAt';
const kDBupdatedAt = '\$updatedAt';
const kSessionClientId = 'clientId';
const kSessionTherapistId = 'therapistId';
const kSessionVideoCreated = 'videoCreated';
const kSessionVideoLoaded = 'videoLoaded';
const kSessionSessionModified = 'sessionModified';
const kSessionStepSessionId = 'sessionId';
const kSessionStepPhoto = 'photo';
const kSessionStepAudio = 'audio';
const kSessionStepCompleted = 'completed';
const kSessionStepTranscription = 'transcription';
const kSessionStepIndex = 'index';
const kSessionStepQuestion = 'question';
const kUserEmail = 'email';
const kUserDisplayName = 'displayName';
const kUserPhoneNumber = 'phoneNumber';
const kUserUserMessage = 'userMessage';
const kUserRole = 'role';
const kUserTherapistId = 'therapistId';
const kUserOriginalAppUserId = 'originalAppUserId';
const kTemplateName = 'name';
const kTemplateQuestions = 'questions';
const kTemplateIsMater = 'isMaster';
const kTemplateCreatorId = 'creatorId';
const kInfoKey = 'key';
const kInfoValue = 'value';
const kLogEmail = 'email';
const kLogdateTime = 'dateTime';
const kLogInfo = 'info';
const kPurchasesEmail = 'email';
const kPurchasesDetails = 'details';
const kPurchasesPurchaseToken = 'purchaseToken';
const kPurchasesProductId = 'productId';
const kPurchasesTransactionDate = 'transactionDate';
const kPurchasesTransactionId = 'transactionId';
const kPurchasesSignatureAndroid = 'signatureAndroid';
const kPurchasesActualDate = 'actualDate';
const kPurchasesOriginalTransactionDateIOS = 'originalTransactionDateIOS';
const kPurchasesOriginalTransactionIdentifierIOS  = 'originalTransactionIdentifierIOS';
const kPurchasesTransactionReceipt  = 'transactionReceipt';
const kPurchasesTransactionStateIOS  = 'transactionStateIOS';
const kInfoNoOfSessionsFree = 'noOfSessionsFree';
const kInfoNoOfSessionsSubscribed = 'noOfSessionsSubscribed';


// const kPurchases = '';
// const kPurchases = '';



const kUserProductId = 'productId';
const kUserApplicationUserName = 'applicationUserName';
const kUserPurchaseID = 'purchaseID';
const kUserPendingCompletePurchase = 'pendingCompletePurchase';
const kUserPurchaseDetailsStatus = 'purchaseDetailsStatus';
const kUserLocalVerificationData = 'localVerificationData';
const kUserServerVerificationData = 'serverVerificationData';
const kUserTransactionDateTime = 'transactionDateTime';
const kUserCumulativeSessions = 'cumulativeSessions';
const kUserArchiveSessions = 'archiveSessions';
const kUserPurchaseStatus = 'status';




/*
const Map<String, HyperbookParameters> kHyperbookParametersMap = {
  kAttHyperbookReference: HyperbookParameters.reference,
  kAttHyperbookModerator: HyperbookParameters.moderator,
  kAttHyperbookTitle: HyperbookParameters.title,
  kAttHyperbookBlurb: HyperbookParameters.blurb,
  kAttHyperbookStartChapter: HyperbookParameters.startChapter,
  kAttHyperbookNonMemberRole: HyperbookParameters.nonMemberRole,
  kAttHyperbookModeratorDisplayName: HyperbookParameters.moderatorDisplayName,
};

const Map<HyperbookParameters, String> kHyperbookParametersMapReverse = {
  HyperbookParameters.reference: kAttHyperbookReference,
  HyperbookParameters.moderator: kAttHyperbookModerator,
  HyperbookParameters.title: kAttHyperbookTitle,
  HyperbookParameters.blurb: kAttHyperbookBlurb,
  HyperbookParameters.startChapter: kAttHyperbookStartChapter,
  HyperbookParameters.nonMemberRole: kAttHyperbookNonMemberRole,
  HyperbookParameters.moderatorDisplayName: kAttHyperbookModeratorDisplayName,
};*/

const kAttChapterReference = 'reference';
const kAttChapterTitle = 'title';
const kAttChapterBody = 'body';
const kAttChapterAuthor = 'author';
const kAttChapterXCoord = 'xCoord';
const kAttChapterYCoord = 'yCoord';
const kAttChapterParent = 'parent';
const kAttChapterAuthorDisplayName = 'authorDisplayName';

/*
const Map<ChapterParameters, String> kHyperbookParametersMapReverse = {
  HyperbookParameters.reference: kAttHyperbookReference,
  HyperbookParameters.moderator: kAttHyperbookModerator,
  HyperbookParameters.title: kAttHyperbookTitle,
  HyperbookParameters.blurb: kAttHyperbookBlurb,
  HyperbookParameters.startChapter: kAttHyperbookStartChapter,
  HyperbookParameters.nonMemberRole: kAttHyperbookNonMemberRole,
  HyperbookParameters.moderatorDisplayName: kAttHyperbookModeratorDisplayName,
};
*/

const kAttrReadReferenceReference = 'reference';
const kAttrReadReferenceChapter = 'chapter';
const kAttrReadReferenceHyperbook = 'hyperbook';
const kAttrReadReferenceReadStateIndex = 'readStateIndex';
const kAttrReadReferenceXCoord = 'xCoord';
const kAttrReadReferenceYCoord = 'yCoord';
const kAttrReadReferenceParent = 'parent';

const kAttConnectedUserReference = 'reference';
const kAttConnectedUserUser = 'user';
const kAttConnectedUserStatus = 'status';
const kAttConnectedUserDisplayName = 'displayName';
const kAttConnectedUserRequesting = 'requesting';
const kAttConnectedUserParent = 'parent';
const kAttConnectedUserNodeSize = 'nodeSize';

const kAttrUserReference = 'reference';
const kAttrUserEmail = 'email';
const kAttrUserDisplayName = 'displayName';
const kAttrUserCreatedTime = 'createdTime';
const kAttrUserPhoneNumber = 'phoneNumber';
const kAttrUserChapterColorInts = 'chapterColorInts';
const kAttrUserUserReference = 'userReference';
const kAttrUserUserLevel = 'userLevel';
const kAttrUserUserMessage = 'userMessage';

const kAttrBackupHyperbookLocalDB = 'hyperbookLocalDB';
const kAttrBackupUsers = 'hyperbookUsers';
const kAttrBackupHyperbook = 'hyperbook';
const kAttrBackupConnectedUserList = 'connectedUserList';
const kAttrBackupChapterList = 'chapterList';

const double kSessionStepCardHeight = 430;
const double kIconButtonWidth = 180;
const double kSessionIconButtonWidth = 220;
const double kIconButtonHeight = 40;
const double kIconButtonGap = 10;

const kAttrStorageName = 'name';
const kAttrStorageId = '\$id';
