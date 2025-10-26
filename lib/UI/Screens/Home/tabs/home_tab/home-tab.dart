import 'package:events/UI/Screens/Home/tabs/home_tab/widgets/event-card.dart';
import 'package:events/database/EventsDao.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: EventsDao.getEvents(), builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                // loading
                return Center(child: CircularProgressIndicator());
              }else if(snapshot.hasError){
                return Center(child: Text("Something went Wrong"),);
              }
              var events = snapshot.data;
              return  ListView.separated(
                itemCount: events?.length ?? 0,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) => EventCard(
                    events![index]
                ),
              );

            },),
            // child: ListView.separated(
            //   itemCount: 10,
            //   separatorBuilder: (context, index) => SizedBox(height: 16),
            //   itemBuilder: (context, index) => EventCard(),
            // ),
          ),
        ],
      ),
    );
  }
}