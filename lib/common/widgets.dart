import 'package:autotomi/common/asset.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constant.dart';

CommanWidget commonWidget = CommanWidget();

class CommanWidget {
  intlPhoneField({
    initialCountryCode,
    controller,
    onCountryChanged,
    showDropdownIcon,
    readOnly = false,
    hintText,
    initialValue,
  }) {
    return IntlPhoneField(
      // disableLengthCheck: false,
      dropdownIconPosition: IconPosition.trailing,
      dropdownIcon: Icon(Icons.keyboard_arrow_down, color: color.black.withOpacity(0.5)),
      cursorColor: color.black,
      showDropdownIcon: showDropdownIcon ?? false,
      showCountryFlag: false,
      readOnly: readOnly,
      initialCountryCode: initialCountryCode,
      controller: controller,
      initialValue: initialValue,
      onSaved: (newValue) {},

      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(15),
      ],
      autovalidateMode: AutovalidateMode.disabled,
      style: TextStyle(fontSize: 14.0, color: color.black, fontFamily: "Medium", fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        fillColor: color.fillColor,
        hintText: hintText,
        filled: true,
        hintStyle: TextStyle(fontSize: 14.0, color: color.black, fontFamily: "Medium", fontWeight: FontWeight.w500),
        counterText: '',
        contentPadding: EdgeInsets.all(15),
      ),
      onCountryChanged: onCountryChanged,
    );
  }

  AppBar customAppbar({titleText, leading, actions, centerTitle, leadingWidth, backgroundColor = Colors.white, arroOnTap, fontsize}) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      actions: [actions!],
      title: commonWidget.semiBoldText(titleText, fontsize: fontsize ?? 22.0),
      leadingWidth: leadingWidth,
      centerTitle: centerTitle ?? true,
      leading: leading ??
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: arroOnTap,
              splashColor: color.transparent,
              highlightColor: color.transparent,
              child: Image.asset(
                assetsUrl.ArrowbackIcon,
                scale: 3.5,
              ),
            ),
          ),
    );
  }

  Widget customTextfield({obscureText, suffixIcon, maxLines, controller, hintText, letterSpacing, keyboardType, maxLength, inputFormatters, onChanged, prefixIcon, contentPadding, hintStyle, label, hintTextColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        regularText(
          label,
          tcolor: color.black,
          fontsize: 14.0,
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          obscuringCharacter: '＊',
          onChanged: onChanged,
          maxLines: maxLines ?? 1,
          obscureText: obscureText ?? false,
          style: TextStyle(
            color: color.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            letterSpacing: letterSpacing,
            fontFamily: 'Medium',
          ),
          decoration: InputDecoration(
            counter: SizedBox(),
            contentPadding: contentPadding ?? EdgeInsets.only(top: 17, bottom: 17, left: 10, right: 10),
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintTextColor ?? color.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Medium',
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: color.fillColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: color.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: color.appColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  InkWell customButton({text, onTap, Ccolor, Tcolor, height, width, child, cornerRadius, textfontsize}) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: height ?? 48,
        width: width ?? hw.width,
        decoration: ShapeDecoration(
          color: Ccolor ?? color.appColor,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: cornerRadius ?? 8,
              cornerSmoothing: 1,
            ),
          ),
        ),
        child: child ??
            Center(
              child: commonWidget.semiBoldText(text, fontsize: textfontsize ?? 18.0, tcolor: Tcolor ?? color.white),
            ),
      ),
    );
  }

  Text regularText(String text, {fontWeight, fontsize = 24.0, textAlign, decoration, tcolor, height, overflow, letterSpacing, maxLines}) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        letterSpacing: letterSpacing,
        height: height,
        decoration: decoration,
        fontSize: fontsize,
        fontFamily: "Regular",
        color: tcolor ?? color.black,
        overflow: overflow,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }

  Text mediumText(String text, {fontWeight, fontsize = 24.0, textAlign, decoration, tcolor, height, overflow, letterSpacing, maxLines}) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        letterSpacing: letterSpacing,
        height: height,
        decoration: decoration,
        fontSize: fontsize,
        fontFamily: "Medium",
        color: tcolor ?? color.black,
        overflow: overflow,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }

  Text semiBoldText(String text, {fontWeight, fontsize = 14.0, textAlign, decoration, tcolor, letterSpacing, maxLines, overflow, height}) {
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        decoration: decoration,
        fontSize: fontsize,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: "SemiBold",
        color: tcolor ?? color.black,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }

  Text boldText(String text, {fontWeight, overflow, maxLines, fontsize = 24.0, textAlign, decoration, tcolor, letterSpacing, height}) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        decoration: decoration,
        fontSize: fontsize,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: "Bold",
        color: tcolor ?? color.black,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }
}
