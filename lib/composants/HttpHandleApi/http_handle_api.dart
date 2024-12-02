import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:http/http.dart' as http;

BorderRadius kBorderRadius = BorderRadius.circular(5.5);
double kSpacing = 20.00;
double kfontSize = 18.00;
double kLargefontSize = 25.00;

EdgeInsets kPadding = EdgeInsets.all(kSpacing);
EdgeInsets kHPadding = EdgeInsets.symmetric(horizontal: kSpacing);
EdgeInsets kVPadding = EdgeInsets.symmetric(vertical: kSpacing);

void httpApiHandling(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) async {
  switch (response.statusCode) {
    case 201:
      onSuccess();
      break;
    case 200:
      onSuccess();
      break;
    case 400:
      debugPrint(
          "response bodyBytes ${jsonDecode(const Utf8Decoder().convert(response.bodyBytes))['non_field_errors']}");
      debugPrint(
          "response body ${jsonDecode(response.body)["non_field_errors"][0]}");
      customToast(
          context,
          jsonDecode(response.body)["non_field_errors"][0],
          const Icon(
            CupertinoIcons.checkmark_seal_fill,
            color: GFColors.DANGER,
          ),
          GFToastPosition.BOTTOM);
      // showSnackBar(
      //     context, jsonDecode(response.body)["non_field_errors"], Colors.red);
      break;
    case 401:
      //test
      debugPrint("Not Authorized 401");
      jsonDecode(response.body)['detail'];
      break;

    case 403:
      //test
      debugPrint("Forbidden Authorized 401");
      showSnackBar(
          context,
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes))['error'],
          Colors.red);
      break;

    case 404:
      //test
      debugPrint("Bad Request 404");
      showSnackBar(
          context,
          jsonDecode(
              const Utf8Decoder().convert(response.bodyBytes))['message'],
          Colors.red);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error'], Colors.red);
      break;
    default:
      showSnackBar(context, response.body, Colors.red);
  }
}

void showSnackBar(BuildContext context, String text, Color bgColor) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: bgColor,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

void customToast(BuildContext context, String msg, Widget icon,
        GFToastPosition? toastPosition) =>
    GFToast.showToast(
      msg,
      textStyle: const TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
      context,
      toastPosition: toastPosition,
      toastDuration: 5,
      trailing: icon,
    );
