import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constantes/codeColors/codeColors.dart';
import '../../constantes/textStyles/textStyle.dart';

class ConcertDetailCard extends StatelessWidget {
  const ConcertDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: CupertinoColors.lightBackgroundGray,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 5,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                "Concert Youssou Ndour",
                style: TextStyle(
                  color: GlobalColors.nextonbording,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Organisateur",
                      style: TypoStyle.textLabelStyleS16W500CBlack1),
                  SizedBox(height: 4.0),
                  Text(
                    "Amicale des jeunes des parcelles assainies",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text("Description de l'événement",
                      style: TypoStyle.textLabelStyleS16W500CBlack1),
                  SizedBox(height: 4.0),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                    " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 8.0),
                  Divider(
                    color: Colors.black54,
                    thickness: 1,
                  ),
                  SizedBox(height: 8.0),
                  Text("Lieu :", style: TypoStyle.textLabelStyleS16W500CBlack1),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: GlobalColors.nextonbording,
                        size: 20,
                      ),
                      Text(
                        "Stade municipal des Parcelles Assainies",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: EdgeInsets.only(right: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date :",
                            style: TypoStyle.textLabelStyleS16W500CBlack1),
                        SizedBox(width: 8.0),
                        Text("Heure :",
                            style: TypoStyle.textLabelStyleS16W500CBlack1),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: EdgeInsets.only(right: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: GlobalColors.nextonbording,
                              size: 20,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              "09/04/2024",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: GlobalColors.nextonbording,
                              size: 20,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              "22:00",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    "Plus d'infos :",
                    style: TypoStyle.textLabelStyleS16W500CBlack1,
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.call_outlined,
                        color: GlobalColors.nextonbording,
                        size: 20,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        "+221 33 800 00 00 / +221 77 800 00 00",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.mail_outline,
                        color: GlobalColors.nextonbording,
                        size: 20,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        "loremipsum@gmail.com",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
