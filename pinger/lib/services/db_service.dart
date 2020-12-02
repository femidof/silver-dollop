import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinger/models/contact.dart';
import 'package:pinger/models/conversation.dart';
import 'package:pinger/models/message.dart';

class DBService {
  static DBService instance = DBService();

  FirebaseFirestore _db;

  DBService() {
    _db = FirebaseFirestore.instance;
  }

  String _userCollection = "Users";
  String _conversationCollections = "Conversations";

  Future<void> createUserInDB(
      String _uid, String _name, String _email, String _imageURL) async {
    try {
      return await _db.collection(_userCollection).doc(_uid).set(
        {
          "name": _name,
          "email": _email,
          "image": _imageURL,
          "lastSeen": DateTime.now().toUtc(),
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Stream<Contact> getUserData(String _userID) {
    var _ref = _db.collection(_userCollection).document(_userID);
    return _ref.get().asStream().map(
      (_snapshot) {
        return Contact.fromFirestore(_snapshot);
      },
    );
  }

  Future<void> updateUserLastSeenTime(String _userID) {
    var _ref = _db.collection(_userCollection).document(_userID);
    return _ref.update({"lastSeen": Timestamp.now()});
  }

  Future<void> sendMessage(String _chatID, Message _message) {
    var _ref = _db.collection(_conversationCollections).doc(_chatID);

    var _messageType = "";
    switch (_message.type) {
      case MessageType.Text:
        _messageType = "text";
        break;

      case MessageType.Image:
        _messageType = "image";
        break;

      default:
    }
    return _ref.updateData(
      {
        "messages": FieldValue.arrayUnion(
          [
            {
              "message": _message.content,
              "senderID": _message.senderID,
              "timestamp": _message.timestamp,
              "type": _messageType,
            },
          ],
        ),
      },
    );
  }

  Future<void> createOrGetConversation(String _currentID, String _recepientID,
      Future<void> _onSuccess(String _chatID)) async {
    var _ref = _db.collection(_conversationCollections);
    var _userConversationRef = _db
        .collection(_userCollection)
        .doc(_currentID)
        .collection(_conversationCollections);

    try {
      var conversation =
          await _userConversationRef.document(_recepientID).get();

      //TODO: continue from 4:45 error bellow
      if (conversation.data != null) {
        // return _onSuccess(conversation.data["chatID"]);
      }
    } catch (e) {}
  }

  Stream<List<ConversationSnippet>> getUserConversations(String _userID) {
    var _ref = _db
        .collection(_userCollection)
        .doc(_userID)
        .collection(_conversationCollections);

    return _ref.snapshots().map((_snapshot) {
      return _snapshot.docs.map((_doc) {
        return ConversationSnippet.fromFirestore(_doc);
      }).toList();
    });
  }

  Stream<List<Contact>> getUsersInDB(String _searchName) {
    var _ref = _db
        .collection(_userCollection)
        .where("name", isGreaterThanOrEqualTo: _searchName)
        .where("name", isLessThan: _searchName + 'z');
    return _ref.getDocuments().asStream().map((_snapshot) {
      return _snapshot.documents.map((_doc) {
        return Contact.fromFirestore(_doc);
      }).toList();
    });
  }

  Stream<Conversation> getConversation(String _chatID) {
    var _ref = _db.collection(_conversationCollections).document(_chatID);

    return _ref.snapshots().map(
      (_snapshot) {
        return Conversation.fromFirestore(_snapshot);
      },
    );
  }
}
