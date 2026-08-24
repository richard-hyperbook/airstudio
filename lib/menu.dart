import 'dart:math';
import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

///import 'flutter_flow_widgets.dart';
import '../../appwrite_interface.dart';
// import '../../chapter_read/chapter_read_widget.dart';
// import 'package:infinity_view/infinity_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

///import 'flutter_flow_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import '../../custom_code/widgets/appwrite_realtime_subscribe.dart';
// import 'package:dotted_border/dotted_border.dart';
import '../../custom_code/widgets/toast.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'localDB.dart';

///import 'package:gap/gap.dart';

class MenuDetails {
  List<String> menuLabelList = [];
  List<Icon> menuIconList = [];
  List<Function(BuildContext context)> menuTargets = [];
  List<Color> menuColorList = [];
  MenuDetails(
      {required this.menuLabelList,
      required this.menuIconList,
      this.menuColorList = kDefautltColorList,
      required this.menuTargets});
}

const kDefaultColor = Colors.white38;
const List<Color> kDefautltColorList = [
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
];




Widget insertMenu(
{required BuildContext context, required MenuDetails? menuDetails, required Function? externalSetState, String? caption, double? width, double? height}) {
  return MenuAnchor(
    builder: (BuildContext context, MenuController controller, Widget? child) {
      return FlutterFlowIconButton(
        enabled: (currentUser != null),
        fillColor: Colors.white,
        tooltipMessage: 'Menu',
        borderColor: (caption == null) ? FlutterFlowTheme.of(context).primary : Colors.transparent,
        buttonWidth: width ?? kIconButtonWidth - 50,
        borderRadius: (caption == null) ? 30 : 30,
        borderWidth: 1,
        buttonSize: height?? 40,
        caption: caption,
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        icon: kIconMenu,
        // tooltip: 'Show menu',
      );
    },
    menuChildren: List<MenuItemButton>.generate(
      menuDetails!.menuLabelList.length,
      (int index) => MenuItemButton(
        leadingIcon: menuDetails.menuIconList[index],
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(FlutterFlowTheme.of(context).tertiaryBackground)),
               // WidgetStateProperty.all(menuDetails.menuColorList[index])),
        onPressed: () {
          externalSetState!(() {
            //>print('(ME1)${index}++++${menuDetails.menuLabelList[index]}');
            menuDetails.menuTargets[index](context);
          });
          //>print('(ME2)');
        },
        child: PointerInterceptor(
            child: Container(child: Text(menuDetails.menuLabelList[index]))),
      ),
    ),
  );
}
