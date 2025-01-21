import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppIcons {
  static final IconData delete = Platform.isIOS ? CupertinoIcons.delete : Icons.delete;
  static final IconData refresh = Platform.isIOS ? CupertinoIcons.refresh : Icons.refresh;
  static final IconData back = Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back;
  static final IconData forward = Platform.isIOS ? CupertinoIcons.forward : Icons.arrow_forward;
  static final IconData mail = Platform.isIOS ? CupertinoIcons.mail : Icons.mail;
  static final IconData settings = Platform.isIOS ? CupertinoIcons.settings : Icons.settings;
  static final IconData person = Platform.isIOS ? CupertinoIcons.person : Icons.person;
  static final IconData add = Platform.isIOS ? CupertinoIcons.add : Icons.add;
  static final IconData search = Platform.isIOS ? CupertinoIcons.search : Icons.search;
  static final IconData close = Platform.isIOS ? CupertinoIcons.clear_circled_solid : Icons.close;
  static final IconData down = Platform.isIOS ? CupertinoIcons.chevron_down : Icons.keyboard_arrow_down;
  static final IconData right = Platform.isIOS ? CupertinoIcons.chevron_right : Icons.keyboard_arrow_right;
}
