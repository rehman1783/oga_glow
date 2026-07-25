// Data models for FAQ categories and questions.

/// Represents a single FAQ category with a list of questions.
class FaqCategory {
  final String title;
  final String icon;
  final List<FaqQuestion> questions;

  const FaqCategory({
    required this.title,
    required this.icon,
    required this.questions,
  });
}

/// Represents a single FAQ question with its answer.
class FaqQuestion {
  final String question;
  final String answer;

  const FaqQuestion({
    required this.question,
    required this.answer,
  });
}

