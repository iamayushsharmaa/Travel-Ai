import 'package:freezed_annotation/freezed_annotation.dart';

part 'gemini_response.freezed.dart';
part 'gemini_response.g.dart';

@freezed
class GeminiResponse with _$GeminiResponse {
  const factory GeminiResponse({
    required String candidate
  }) = _GeminiResponse;

  factory GeminiResponse.fromJson(Map<String, dynamic> json) =>
      _$GeminiResponseFromJson(json);
}
