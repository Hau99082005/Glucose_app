import 'package:flutter/material.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';

TextStyle baseTextStyle = TextStyle(color: textColor, fontSize: 16, decoration: TextDecoration.none);

// bold   
TextStyle poppinsBold = baseTextStyle.copyWith(fontFamily: 'PoppinsBold');
// bold italic
TextStyle poppinsBoldItalic = baseTextStyle.copyWith(fontFamily: 'PoppinsBoldItalic');
// extra bold
TextStyle poppinsExtraBold = baseTextStyle.copyWith(fontFamily: 'PoppinsExtraBold');
// extra bold italic
TextStyle poppinsExtraBoldItalic = baseTextStyle.copyWith(fontFamily:  'PoppinsExtraBoldItalic');
// medium
TextStyle poppinsMedium = baseTextStyle.copyWith(fontFamily: 'PoppinsMedium');
// medium italic
TextStyle poppinsMediumItalic = baseTextStyle.copyWith(fontFamily: 'PoppinsMediumItalic');
// regular
TextStyle poppinsRegular = baseTextStyle.copyWith(fontFamily: 'PoppinsRegular');
// semi bold
TextStyle poppinsSemiBold = baseTextStyle.copyWith(fontFamily: 'PoppinsSemiBold');
// semi bold italic
TextStyle poppinsSemiBoldItalic = baseTextStyle.copyWith(fontFamily: 'PoppinsSemiBoldItalic');

TextStyle smallPoppinsBold = poppinsBold.copyWith(fontSize: 14);
TextStyle smallPoppinsBoldItalic = poppinsBoldItalic.copyWith(fontSize: 14);
TextStyle smallPoppinsExtraBold = poppinsExtraBold.copyWith(fontSize: 14);
TextStyle smallPoppinsExtraBoldItalic = poppinsExtraBoldItalic.copyWith(fontSize: 14);
TextStyle smallPoppinsMedium = poppinsMedium.copyWith(fontSize: 14);
TextStyle smallPoppinsMediumItalic = poppinsMediumItalic.copyWith(fontSize: 14);
TextStyle smallPoppinsRegular = poppinsRegular.copyWith(fontSize: 14);
TextStyle smallPoppinsSemiBold = poppinsSemiBold.copyWith(fontSize: 14);
TextStyle smallPoppinsSemiBoldItalic = poppinsSemiBoldItalic.copyWith(fontSize: 14);
