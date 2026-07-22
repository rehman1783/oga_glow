import 'package:get/get.dart';
import 'package:oga_glow/core/constants/faq_constants.dart';

/// Controller for the FAQ screen.
///
/// Manages search filtering over the static FAQ data.
class FaqController extends GetxController {
  /// The raw search query entered by the user.
  final searchQuery = RxString('');

  /// The filtered list of categories that match the search query.
  /// If [searchQuery] is empty, this equals [allCategories].
  final filteredCategories = RxList<FaqCategory>([]);

  /// All categories loaded from [FaqConstants].
  late final List<FaqCategory> allCategories;

  @override
  void onInit() {
    super.onInit();
    allCategories = FaqConstants.categories;
    filteredCategories.assignAll(allCategories);
  }

  /// Filters categories and their questions based on [query].
  ///
  /// Matching is case-insensitive and searches both question text and answer
  /// text. Categories with no matching questions are excluded from results.
  void filterFAQs(String query) {
    searchQuery.value = query;

    if (query.trim().isEmpty) {
      filteredCategories.assignAll(allCategories);
      return;
    }

    final lowerQuery = query.toLowerCase().trim();

    final results = <FaqCategory>[];
    for (final category in allCategories) {
      final matchingQuestions = <FaqQuestion>[];
      for (final question in category.questions) {
        if (question.question.toLowerCase().contains(lowerQuery) ||
            question.answer.toLowerCase().contains(lowerQuery)) {
          matchingQuestions.add(question);
        }
      }
      if (matchingQuestions.isNotEmpty) {
        results.add(
          FaqCategory(
            title: category.title,
            icon: category.icon,
            questions: matchingQuestions,
          ),
        );
      }
    }

    filteredCategories.assignAll(results);
  }
}

