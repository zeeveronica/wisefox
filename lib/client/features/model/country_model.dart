import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final int value;
  final String label;

  CountryModel({
    required this.value,
    required this.label,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      value: json['value'],
      label: json['label'] ?? '',
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
