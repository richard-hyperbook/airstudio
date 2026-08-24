import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'flutter_flow_theme.dart';

class FlutterFlowIconButton extends StatefulWidget {
  const FlutterFlowIconButton({
    super.key,
    required this.icon,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.buttonSize,
    this.fillColor,
    this.disabledColor,
    this.disabledIconColor,
    this.hoverColor,
    this.hoverIconColor,
    this.onPressed,
    this.showLoadingIndicator = false,
    this.tooltipMessage,
    this.enabled = true,
    this.caption,
    this.captionFontSize,
    this.colorIfEnabled,
    this.buttonWidth = 95,
  });

  final Widget icon;
  final double? borderRadius;
  final double? buttonSize;
  final Color? fillColor;
  final Color? disabledColor;
  final Color? disabledIconColor;
  final Color? hoverColor;
  final Color? hoverIconColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool showLoadingIndicator;
  final Function()? onPressed;
  final String? tooltipMessage;
  final bool enabled;
  final String? caption;
  final Color? colorIfEnabled;
  final double? buttonWidth;
  final double? captionFontSize;

  @override
  State<FlutterFlowIconButton> createState() => _FlutterFlowIconButtonState();
}

class _FlutterFlowIconButtonState extends State<FlutterFlowIconButton> {
  bool loading = false;
  late double? iconSize;
  late Color? iconColor;
  late Widget effectiveIcon;

  @override
  void initState() {
    super.initState();
    print('(CD1)${widget.icon}');
    _updateIcon();
  }

  @override
  void didUpdateWidget(FlutterFlowIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateIcon();
  }

  void _updateIcon() {
    final bool isFontAwesome = widget.icon is FaIcon;
    if (isFontAwesome) {
      final FaIcon icon = widget.icon as FaIcon;
      /*effectiveIcon = FaIcon(
        icon.icon,
        size: icon.size,
      );*/
      effectiveIcon = widget.icon;
      iconSize = icon.size;
      iconColor = icon.color;
    } else {
      final Icon icon = widget.icon as Icon;
      effectiveIcon = Icon(
        icon.icon,
        size: icon.size,
      );
      iconSize = icon.size;
      iconColor = icon.color;
    }
  }


  Widget smartIconButton(ButtonStyle style) {
    return IconButton(
//disabledColor: Colors.red,
      icon: (widget.showLoadingIndicator && loading)
          ? SizedBox(
              width: iconSize,
              height: iconSize,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  iconColor ?? Colors.blue,
                ),
              ),
            )
          : effectiveIcon,
      onPressed: widget.enabled
          ? widget.onPressed == null
              ? null
              : () async {
        print('(NN11I)${loading}++++${widget.tooltipMessage}');
                  if (loading) {
                    return;
                  }
                  setState(() => loading = true);
                  try {
                    await widget.onPressed!();
                  } finally {
                    if (mounted) {
                      setState(() => loading = false);
                    }
                  }
                }
          : null,
      splashRadius: widget.buttonSize,
      style: style,
    );
  }

  @override
  Widget build(BuildContext context) {
    // //>print('(NN1)${widget.tooltipMessage}');
    final ButtonStyle style = ButtonStyle(
      shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
        (Set<WidgetState> states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
            side: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
              width: widget.borderWidth ?? 0,
            ),
          );
        },
      ),
      iconColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled) &&
              widget.disabledIconColor != null) {
            return widget.disabledIconColor;
          }
          if (states.contains(WidgetState.hovered) &&
              widget.hoverIconColor != null) {
            return widget.hoverIconColor;
          }
          return iconColor;
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled) &&
              widget.disabledColor != null) {
            return widget.disabledColor;
          }
          if (states.contains(WidgetState.hovered) &&
              widget.hoverColor != null) {
            return widget.hoverColor;
          }

          return widget.fillColor;
        },
      ),
    );

    return Tooltip(
      message: widget.tooltipMessage ?? '???',
      child: SizedBox(
        width: (widget.caption == null) ? widget.buttonSize : widget.buttonWidth,
        height: widget.buttonSize,
        child: Theme(
          data: Theme.of(context).copyWith(),
          child: IgnorePointer(
            ignoring: widget.showLoadingIndicator && loading,
            child: (widget.caption == null)
                ? smartIconButton(style)
                :
            GestureDetector(
                onTap: widget.enabled
                    ? widget.onPressed == null
                    ? null
                    : () async {
                  print('(NN11C)${loading}++++${widget.tooltipMessage}');
                  if (loading) {
                    return;
                  }
                  setState(() => loading = true);
                  try {
                    await widget.onPressed!();
                  } finally {
                    if (mounted) {
                      setState(() => loading = false);
                    }
                  }
                }
                    : null,
                child:

                Container(
                    width: 99,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(/*widget.borderRadius ??*/ 20),
                        border: Border.all(
                            width: 1,
                            color: widget.enabled ? Colors.black : Colors.grey),
                        color: ((widget.colorIfEnabled != null) &&
                                (widget.enabled))
                            ? widget.colorIfEnabled
                            : FlutterFlowTheme.of(context).tertiaryBackground),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          smartIconButton(style),
                          Text(widget.caption!,
                                style: TextStyle(
                                    fontSize: widget.captionFontSize?? 15,
                                    fontWeight: FontWeight.bold,
                                    color: widget.enabled
                                        ? Colors.black
                                        : Colors.grey)),
                          ])
                        )),
          ),
        ),
      ),
    );
  }
}
