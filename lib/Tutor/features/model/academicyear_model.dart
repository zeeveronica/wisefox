import 'package:equatable/equatable.dart';

class AcademicYearModel extends Equatable {
  final int value;
  final String label;

  AcademicYearModel({
    required this.value,
    required this.label,
  });

  factory AcademicYearModel.fromJson(Map<String, dynamic> json) {
    return AcademicYearModel(
      value: json['value'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
    };
  }

  @override
  List<Object?> get props => [value, label];
}
