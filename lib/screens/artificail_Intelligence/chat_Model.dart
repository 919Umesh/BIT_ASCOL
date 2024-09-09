import 'dart:io';

import 'package:bit_ascol/screens/artificail_Intelligence/roles.dart';


class ChatModel {
  String text;
  File? image;
  Roles role;

  ChatModel({
    required this.text,
    required this.role,
    this.image,
  });
}
