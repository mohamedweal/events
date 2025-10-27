import 'package:events/UI/Common/events-tabs.dart';
import 'package:events/UI/Provider/AppAuthProvider.dart';
import 'package:events/UI/Screens/Home/tabs/home_tab/widgets/event-card.dart';
import 'package:events/database/EventsDao.dart';
import 'package:events/database/model/Category.dart';
import 'package:events/extensions/context-extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavTab extends StatefulWidget {
  FavTab({super.key});

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  int selectedCategoryIndex = 0;
  List<Category> allCategories = Category.getCategories(includeAll: true);
  //
  // @override
  // void didUpdateWidget(covariant FavTab oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if(widget.selectedCategory != oldWidget.selectedCategory){
  //     setState(() {
  //       print("old category -> ${oldWidget.selectedCategory.title}");
  //       print("new category -> ${widget.selectedCategory.title}");
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context,listen: false);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color:context.appColors.primary ,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              )
          ),
          child: EventsTabs(
            allCategories,
            selectedCategoryIndex,
                (index,category) {
              setState(() {
                selectedCategoryIndex = index;
              });
            },),
        ),
        Expanded(
          child: FutureBuilder(future:
          EventsDao.getFavoriteEvents(allCategories[selectedCategoryIndex].id// filter by category
              , provider.getUser()?.favorites ?? []
          ),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                // loading
                return Center(child: CircularProgressIndicator());
              }else if(snapshot.hasError){
                return Center(child: Text("Something went Wrong"),);
              }
              var events = snapshot.data?.toList();
              if(events==null ||events.isEmpty == true){
                return Center(child: Text("No Events Found",
                  style: TextStyle(
                      color: Colors.black
                  ),),);
              }
              return  Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView.separated(
                    itemCount: events?.length ?? 0,
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      var event  = events![index];
                      var isFavorite = provider.isFavorite(event);
                      event.isFavorite = isFavorite;
                      return EventCard(
                        events[index],
                      );
                    }
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
    );
  }
}