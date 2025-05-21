class GeminiResponse {
  final List<Candidate> candidates;

  GeminiResponse({required this.candidates});

  factory GeminiResponse.fromJsom(Map<String, dynamic> json) {
    return GeminiResponse(
      candidates:
          (json['candidates'] as List)
              .map((e) => Candidate.fromJson(e))
              .toList(),
    );
  }
}

class Candidate {
  final Content content;

  Candidate({required this.content});

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(content: Content.fromJson(json['content']));
  }
}

class Content {
  final List<Part> parts;

  Content({required this.parts});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      parts: (json['parts'] as List).map((e) => Part.fromJson(e)).toList(),
    );
  }
}

class Part {
  final String text;

  Part({required this.text});

  factory Part.fromJson(Map<String, dynamic> map) {
    return Part(text: map['text'] as String);
  }
}
