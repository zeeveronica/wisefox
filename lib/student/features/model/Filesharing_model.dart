class FilesharingModel {
  final int id;
  final int sender;
  final int receiver;
  final String file;
  final String title;
  final String notes;
  final bool isDraft;
  final String createdDate;

  FilesharingModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.file,
    required this.title,
    required this.notes,
    required this.isDraft,
    required this.createdDate,
  });

  factory FilesharingModel.fromJson(Map<String, dynamic> json) {
    return FilesharingModel(
      id: json['id'] ?? 0,
      sender: json['sender'] ?? 0,
      receiver: json['receiver'] ?? 0,
      file: json['file'] ?? '',
      title: json['title'] ?? '',
      notes: json['notes'] ?? '',
      isDraft: json['is_draft'] ?? false,
      createdDate: json['created_date'] ?? '',
    );
  }

  // Method to convert object back to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'receiver': receiver,
      'file': file,
      'title': title,
      'notes': notes,
      'is_draft': isDraft,
      'created_date': createdDate,
    };
  }
}
