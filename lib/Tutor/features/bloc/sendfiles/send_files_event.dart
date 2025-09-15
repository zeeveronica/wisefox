part of 'send_files_bloc.dart';

abstract class SendFilesEvent extends Equatable {
  const SendFilesEvent();

  @override
  List<Object> get props => [];
}

final class ShareFileEvent extends SendFilesEvent {
  final int? id;
  final List<int> receiver;
  final List<String> filePath; // List for multiple files
  final String title;
  final String notes;
  final bool isDraft;

  ShareFileEvent({
    this.id,
    required this.receiver,
    required this.filePath,
    required this.title,
    required this.notes,
    required this.isDraft,
  });

  @override
  List<Object> get props => [receiver, filePath, title, notes, isDraft];
}
