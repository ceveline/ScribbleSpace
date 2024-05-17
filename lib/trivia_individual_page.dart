import 'package:flutter/material.dart';
import 'package:scribblespace/mainmenu_screen.dart';
import 'package:scribblespace/trivia_api.dart';
import 'package:scribblespace/trivia_page.dart';
import 'color_constants.dart';

class TriviaIndividualPage extends StatefulWidget {
  final String? category;
  final int? limit;
  final String? difficulty;

  const TriviaIndividualPage({this.category, this.limit, this.difficulty});

  @override
  State<TriviaIndividualPage> createState() => _TriviaIndividualPageState();
}

class _TriviaIndividualPageState extends State<TriviaIndividualPage> {
  late Future<List<dynamic>> _triviaQuestions;
  final TriviaApi _api = TriviaApi(baseUrl: 'https://the-trivia-api.com/v2/questions');
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isCorrectAnswer = false;
  bool _answered = false;
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _triviaQuestions = _api.fetchTriviaQuestions(
      category: widget.category!,
      limit: widget.limit!,
      difficulty: widget.difficulty!,
    );
  }

  void _checkAnswer(String selectedAnswer, String correctAnswer) {
    setState(() {
      _answered = true;
      _selectedAnswer = selectedAnswer;
      _isCorrectAnswer = selectedAnswer == correctAnswer;
      if (_isCorrectAnswer) {
        _score++;
      }
      if(_currentQuestionIndex + 1 == widget.limit!) {
        _showPlayAgainDialog();
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex + 1 < widget.limit!) {
      setState(() {
        _currentQuestionIndex++;
        _answered = false;
        _isCorrectAnswer = false;
      });
    }
  }

  void _showPlayAgainDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorConstants.darkblue,
          title: Text('Quiz Finished', style: TextStyle(color: Colors.white),),
          content: Text('Your score is $_score out of ${widget.limit}. Play again?', style: TextStyle(color: Colors.white),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetQuiz();
              },
              child: Text('Yes', style: TextStyle(color: Colors.white),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TriviaPage()),
                );
              },
              child: Text('No', style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _answered = false;
      _isCorrectAnswer = false;
      _triviaQuestions = _api.fetchTriviaQuestions(
        category: widget.category!,
        limit: widget.limit!,
        difficulty: widget.difficulty!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${widget.category} Trivia', style: TextStyle(color: Colors.white),),
            Text('Score: $_score/${widget.limit!}', style: TextStyle(color: Colors.white),),
          ],
        ),
        backgroundColor: ColorConstants.darkblue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      backgroundColor: ColorConstants.purple,
      body: FutureBuilder<List<dynamic>>(
        future: _triviaQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No trivia questions found'));
          } else {
            var question = snapshot.data![_currentQuestionIndex];
            List<String> answers = List<String>.from(question['incorrectAnswers']);
            answers.add(question['correctAnswer']);
            answers.shuffle();

            return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(height: 25,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorConstants.darkblue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      question['question']['text'],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  SizedBox(height: 25,),
                  ...answers.map((answer) => GestureDetector(
                    onTap: () {
                      if (!_answered) {
                        _checkAnswer(answer, question['correctAnswer']);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: _answered
                            ? (answer == question['correctAnswer']
                            ? Colors.green // Correct answer turns green
                            : (answer == _selectedAnswer && !_isCorrectAnswer ? Colors.red : ColorConstants.darkblue)) // Incorrect answer turns red when selected
                            : ColorConstants.darkblue, // Default color for unanswered questions
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          answer,
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )).toList(),
                  // SizedBox(height: 80),
                  if (_answered)
                    GestureDetector(
                      onTap: _nextQuestion,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: ColorConstants.darkblue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Next Question',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
