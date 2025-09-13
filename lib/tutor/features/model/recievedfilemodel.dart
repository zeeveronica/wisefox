class StudentReceivedFile {
  final int id;
  final int sender;
  final String senderName;
  final String receiverName;
  final int receiver;
  final String file;
  final String title;

  final String notes;
  final bool isDraft;
  final String createdDate;
  final String? fileFormat; // Optional field

  StudentReceivedFile({
    required this.id,
    required this.sender,
    required this.senderName,
    required this.receiverName,
    required this.receiver,
    required this.file,
    required this.title,
    required this.notes,
    required this.isDraft,
    required this.createdDate,
    this.fileFormat,
  });

  // Factory constructor to create an instance from a map (e.g., from JSON)
  factory StudentReceivedFile.fromMap(Map<String, dynamic> map) {
    return StudentReceivedFile(
      id: map['id'] as int,
      sender: map['sender'] as int,
      senderName: map['sender_name'] as String,
      receiverName: map['reciever_name'] as String,
      receiver: map['reciever'] as int,
      file: map['file'] as String,
      title: map['title'] as String,
      notes: map['notes'] as String,
      isDraft: map['is_draft'] as bool,
      createdDate: map['created_date'] as String,
      fileFormat: map['file_format'] as String?,
    );
  }

  // Method to convert the object to a map (e.g., for sending data as JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'sender_name': senderName,
      'reciever_name': receiverName,
      'reciever': receiver,
      'file': file,
      'title': title,
      'notes': notes,
      'is_draft': isDraft,
      'created_date': createdDate,
      'file_format': fileFormat,
    };
  }
}
