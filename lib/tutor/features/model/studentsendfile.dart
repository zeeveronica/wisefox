import 'package:intl/intl.dart';

class StudentSendfile {
  final int id;
  final String sender;
  final String receiver;
  final String file;
  final String title;
  final fileformat;
  final String notes;
  final bool isDraft;
  final String date;

  StudentSendfile({
    required this.id,
    required this.sender,
    required this.fileformat,
    required this.date,
    required this.receiver,
    required this.file,
    required this.title,
    required this.notes,
    required this.isDraft,
  });

  // Factory method to create a Sendfile object from a Map (JSON)
  factory StudentSendfile.fromMap(Map<String, dynamic> map) {
    return StudentSendfile(
      id: map['id'],
      fileformat: map['file_format'],
      date: map['created_date'],
      sender: map['sender_name'],
      receiver:
          map['reciever_name'], // Ensure the key matches your JSON structure
      file: map['file'],
      title: map['title'],
      notes: map['notes'],
      isDraft: map['is_draft'],
    );
  }

  // Method to convert a Sendfile object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'reciever': receiver, // Ensure the key matches your JSON structure
      'file': file,
      'title': title,
      'file_format': fileformat,
      'notes': notes,
      'created_date': date,
      'is_draft': isDraft,
    };
  }
}
