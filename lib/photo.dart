library photo;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo/src/delegate/checkbox_builder_delegate.dart';
import 'package:photo/src/delegate/loading_delegate.dart';
import 'package:photo/src/delegate/sort_delegate.dart';
import 'package:photo/src/entity/options.dart';
import 'package:photo/src/provider/i18n_provider.dart';
import 'package:photo/src/ui/dialog/not_permission_dialog.dart';
import 'package:photo/src/ui/photo_app.dart';
import 'package:photo_manager/photo_manager.dart';

export 'package:photo/src/delegate/checkbox_builder_delegate.dart';
export 'package:photo/src/delegate/loading_delegate.dart';
export 'package:photo/src/delegate/sort_delegate.dart';
export 'package:photo/src/provider/i18n_provider.dart'
    show I18NCustomProvider, I18nProvider, CNProvider, ENProvider;

class PhotoPicker {
  static PhotoPicker _instance;

  PhotoPicker._();

  factory PhotoPicker() {
    _instance ??= PhotoPicker._();
    return _instance;
  }

  static const String rootRouteName = "photo_picker_image";

  /// 没有授予权限的时候,会开启一个dialog去帮助用户去应用设置页面开启权限
  /// 确定开启设置页面,取消关闭弹窗
  ///
  ///
  /// 当用户给予权限后
  ///
  ///   当用户确定时,返回一个图片[AssetEntity]列表
  ///
  ///   当用户取消时
  ///
  /// if user not grand permission, then return null and show a dialog to help user open setting.
  /// sure is open setting cancel ,cancel to dismiss dialog
  ///
  /// when user give permission.
  ///
  ///   when user sure , return a [AssetEntity] of [List]
  ///
  ///   when user cancel selected,result is empty list
  static Future<List<AssetEntity>> pickImage({
    @required BuildContext context,
    int rowCount = 4,
    int maxSelected = 9,
    double padding = 0.5,
    double itemRadio = 1.0,
    Color themeColor,
    Color dividerColor,
    Color textColor,
    TextStyle selectedTextStyle,
    Color disableColor,
    int thumbSize = 64,
    I18nProvider provider = I18nProvider.chinese,
    SortDelegate sortDelegate,
    CheckBoxBuilderDelegate checkBoxBuilderDelegate,
    LoadingDelegate loadingDelegate,
  }) {
    assert(provider != null, "provider must be not null");
    assert(context != null, "context must be not null");

    themeColor ??= Theme.of(context)?.primaryColor ?? Colors.black;
    dividerColor ??= Theme.of(context)?.dividerColor ?? Colors.grey;
    disableColor ??= Theme.of(context)?.disabledColor ?? Colors.grey;
    textColor ??= Colors.white;

    sortDelegate ??= SortDelegate.common;
    checkBoxBuilderDelegate ??= DefaultCheckBoxBuilderDelegate();

    loadingDelegate ??= DefaultLoadingDelegate();

    var options = Options(
      rowCount: rowCount,
      dividerColor: dividerColor,
      maxSelected: maxSelected,
      itemRadio: itemRadio,
      padding: padding,
      disableColor: disableColor,
      textColor: textColor,
      selectedTextStyle: selectedTextStyle,
      themeColor: themeColor,
      thumbSize: thumbSize,
      sortDelegate: sortDelegate,
      checkBoxBuilderDelegate: checkBoxBuilderDelegate,
      loadingDelegate: loadingDelegate,
    );

    return PhotoPicker()._pickImage(
      context,
      options,
      provider,
    );
  }

  Future<List<AssetEntity>> _pickImage(
    BuildContext context,
    Options options,
    I18nProvider provider,
  ) async {
    var requestPermission = await PhotoManager.requestPermission();
    if (requestPermission != true) {
      var result = await showDialog(
        context: context,
        builder: (ctx) => NotPermissionDialog(
              provider.getNotPermissionText(options),
            ),
      );
      if (result == true) {
        PhotoManager.openSetting();
      }
      return null;
    }

    return _openGalleryContentPage(context, options, provider);
  }

  Future<List<AssetEntity>> _openGalleryContentPage(
      BuildContext context, Options options, I18nProvider provider) async {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PhotoApp(
              options: options,
              provider: provider,
            ),
      ),
    );
  }
}
