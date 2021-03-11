import 'package:tinode/src/models/access-mode.dart';
import 'package:tinode/src/models/def-acs.dart';

class TopicDescription {
  /// Topic creation date
  final DateTime created;

  /// Topic update date
  final DateTime updated;

  /// account status; included for `me` topic only, and only if
  /// the request is sent by a root-authenticated session.
  final String status;

  /// topic's default access permissions; present only if the current user has 'S' permission
  DefAcs defacs;

  /// Actual access permissions
  final AccessMode acs;

  /// Server-issued id of the last {data} message
  final int seq;

  /// Id of the message user claims through {note} message to have read, optional
  final int read;

  /// Like 'read', but received, optional
  final int recv;

  /// in case some messages were deleted, the greatest ID
  /// of a deleted message, optional
  final int clear;

  /// Application-defined data that's available to all topic subscribers
  final dynamic public;

  /// Application-defined data that's available to the current user only
  final dynamic private;

  final bool noForwarding;

  TopicDescription({
    this.created,
    this.updated,
    this.status,
    this.defacs,
    this.acs,
    this.seq,
    this.read,
    this.recv,
    this.clear,
    this.public,
    this.private,
    this.noForwarding,
  });

  /// Create a new instance from received message
  static TopicDescription fromMessage(Map<String, dynamic> msg) {
    return TopicDescription(
      created: msg['created'] != null ? DateTime.parse(msg['created']) : DateTime.now(),
      updated: msg['updated'] != null ? DateTime.parse(msg['updated']) : DateTime.now(),
      status: msg['status'],
      defacs: msg['defacs'] != null ? DefAcs.fromMessage(msg['defacs']) : null,
      acs: msg['acs'] != null ? AccessMode(msg['acs']) : null,
      seq: msg['seq'],
      read: msg['read'],
      recv: msg['recv'],
      clear: msg['clear'],
      public: msg['public'],
      private: msg['private'],
      noForwarding: msg['noForwarding'],
    );
  }
}
