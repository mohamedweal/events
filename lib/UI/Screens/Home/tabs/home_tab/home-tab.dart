
import 'package:events/UI/Screens/Home/tabs/home_tab/widgets/event-card.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => SizedBox(height: 16),
              itemBuilder: (context, index) => EventCard(),
            ),
          ),
        ],
      ),
    );
  }
}