import 'package:events/UI/Provider/AppAuthProvider.dart';
import 'package:events/database/UsersDao.dart';
import 'package:events/database/model/events.dart';
import 'package:events/extensions/context-extension.dart';
import 'package:events/extensions/date-time-extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:events/database/EventsDao.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard(this.event,{super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.all(8),
      height: size.height * .25,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appColors.primary, width: 1),
        image: DecorationImage(
          image: AssetImage(event.getCategoryImage()),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  '${event.date?.day}',
                  style: context.fonts.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: context.appColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  event.date?.formatMonth()??"",
                  style: context.fonts.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: context.appColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.title??"",
                  style: context.fonts.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 14,
                  ),
                ),
                InkWell(onTap: () {}, child: Icon(Icons.favorite)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}