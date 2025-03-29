import 'package:flutter/material.dart';
import 'package:ralm/core/shared/widget/animated_tarot_cad_widget.dart';

class TarotCardScreen extends StatefulWidget {
  const TarotCardScreen({super.key});

  @override
  State<TarotCardScreen> createState() => _TarotCardScreenState();
}

class _TarotCardScreenState extends State<TarotCardScreen> {
  final List<bool> _isVisible = List.generate(22, (_) => false);

  @override
  void initState() {
    super.initState();
    _animateCards();
  }

  void _animateCards() {
    for (int i = 0; i < _isVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 200 * i), () {
        if (mounted) {
          setState(() {
            _isVisible[i] = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedTarotCardWidget(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(indent: 20, endIndent: 20),
              ),
              Text(
                'Choose 3 Cards',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Center(
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  alignment: WrapAlignment.center,
                  children: List.generate(22, (index) {
                    return AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: _isVisible[index] ? 1.0 : 0.0,
                      child: _backCard(),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 200,
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: Colors.black87),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _backCard() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Container(
        height: 180,
        width: 110,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(width: 1, color: Colors.black87),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
