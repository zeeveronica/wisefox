class SentedModel {
  final int id;
  final int? sender; // Nullable sender
  final String receiverName; // The name of the receiver as String
  final int receiver; // The receiver as int
  final String file;
  final String title;
  final String notes;
  final bool isDraft;
  final String createdDate;

  SentedModel({
    required this.id,
    this.sender,
    required this.receiverName,
    required this.receiver, // Changed receiver to int
    required this.file,
    required this.title,
    required this.notes,
    required this.isDraft,
    required this.createdDate,
  });

  factory SentedModel.fromJson(Map<String, dynamic> json) {
    return SentedModel(
      id: json['id'] ?? 0,
      sender: json['sender'] != null ? json['sender'] as int : null,
      receiverName: json['reciever_name'] ?? '', // Corrected to receiver_name
      receiver: json['reciever'] ?? 0, // Changed from String to int
      file: json['file'] ?? '',
      title: json['title'] ?? '',
      notes: json['notes'] ?? '',
      isDraft: json['is_draft'] ?? false,
      createdDate: json['created_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'receiver_name': receiverName, // Fixed to match the API field
      'reciever': receiver, // Corrected typo
      'file': file,
      'title': title,
      'notes': notes,
      'is_draft': isDraft,
      'created_date': createdDate,
    };
  }
}
