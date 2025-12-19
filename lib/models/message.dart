enum MessageType {
  user,
  assistant,
  system,
}

enum MessageStatus {
  sending,
  sent,
  error,
  streaming,
}

class Message {
  final String id;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final MessageStatus status;
  final List<ChecklistItem>? checklist;

  Message({
    required this.id,
    required this.content,
    required this.type,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.checklist,
  });

  Message copyWith({
    String? id,
    String? content,
    MessageType? type,
    DateTime? timestamp,
    MessageStatus? status,
    List<ChecklistItem>? checklist,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      checklist: checklist ?? this.checklist,
    );
  }
}

class ChecklistItem {
  final String title;
  final String? description;
  bool isCompleted;

  ChecklistItem({
    required this.title,
    this.description,
    this.isCompleted = false,
  });
}
