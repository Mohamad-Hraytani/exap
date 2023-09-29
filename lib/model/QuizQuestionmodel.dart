class QuizQuestion {
  final String question;
  final List<String> choices;
  int selectedChoice = -1; // Initially, no choice is selected

  QuizQuestion(this.question, this.choices);
}
