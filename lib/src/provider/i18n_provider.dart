import 'package:photo/src/entity/options.dart';
import 'package:photo/src/provider/selected_provider.dart';
import 'dart:ui';

abstract class I18nProvider {
  const I18nProvider._();

  String getTitleText(Options options);

  String getSureText(Options options, int currentCount);

  String getPreviewText(Options options, SelectedProvider selectedProvider);

  String getSelectedOptionsText(Options options);

  String getMaxTipText(Options options);

  String getAllGalleryText(Options options);

  String loadingText() {
    return "loading...";
  }

  I18NPermissionProvider getNotPermissionText(Options options);

  static const I18nProvider chinese = CNProvider();

  static const I18nProvider english = ENProvider();

  static const I18nProvider japanese = JAProvider();
}

class CNProvider extends I18nProvider {
  const CNProvider() : super._();

  @override
  String getTitleText(Options options) {
    return "图片选择";
  }

  @override
  String getPreviewText(Options options, SelectedProvider selectedProvider) {
    return "预览(${selectedProvider.selectedCount})";
  }

  @override
  String getSureText(Options options, int currentCount) {
    return "确定($currentCount/${options.maxSelected})";
  }

  @override
  String getSelectedOptionsText(Options options) {
    return "选择";
  }

  @override
  String getMaxTipText(Options options) {
    return "您已经选择了${options.maxSelected}张图片";
  }

  @override
  String getAllGalleryText(Options options) {
    return "全部图片";
  }

  @override
  String loadingText() {
    return "加载中...";
  }

  @override
  I18NPermissionProvider getNotPermissionText(Options options) {
    return I18NPermissionProvider(
        cancelText: "取消", sureText: "去开启", titleText: "没有访问相册的权限");
  }
}

class ENProvider extends I18nProvider {
  const ENProvider() : super._();

  @override
  String getTitleText(Options options) {
    return "image picker";
  }

  @override
  String getPreviewText(Options options, SelectedProvider selectedProvider) {
    return "preview(${selectedProvider.selectedCount})";
  }

  @override
  String getSureText(Options options, int currentCount) {
    return "sure($currentCount/${options.maxSelected})";
  }

  @override
  String getSelectedOptionsText(Options options) {
    return "selected";
  }

  @override
  String getMaxTipText(Options options) {
    return "select ${options.maxSelected} pictures at most";
  }

  @override
  String getAllGalleryText(Options options) {
    return "all images";
  }

  @override
  String loadingText() {
    return 'loading...';
  }

  @override
  I18NPermissionProvider getNotPermissionText(Options options) {
    return I18NPermissionProvider(
        cancelText: "cancel",
        sureText: "allow",
        titleText: "No permission to access gallery");
  }
}

class JAProvider extends I18nProvider {
  const JAProvider() : super._();

  @override
  String getTitleText(Options options) {
    return "選択";
  }

  @override
  String getPreviewText(Options options, SelectedProvider selectedProvider) {
    return "プレビュー(${selectedProvider.selectedCount})";
  }

  @override
  String getSureText(Options options, int currentCount) {
    return "確認($currentCount/${options.maxSelected})";
  }

  @override
  String getSelectedOptionsText(Options options) {
    return "選択した";
  }

  @override
  String getMaxTipText(Options options) {
    return "写真は ${options.maxSelected} 枚まで選んでください";
  }

  @override
  String getAllGalleryText(Options options) {
    return "全部";
  }

  @override
  String loadingText() {
    return 'loading...';
  }

  @override
  I18NPermissionProvider getNotPermissionText(Options options) {
    return I18NPermissionProvider(
        cancelText: "キャンセル",
        sureText: "セットへ",
        titleText: "アルバムにアクセスする権限はありません");
  }
}

abstract class I18NCustomProvider implements I18nProvider {
  final String maxTipText;
  final String previewText;
  final String selectedOptionsText;
  final String sureText;
  final String titleText;
  final I18NPermissionProvider notPermissionText;

  I18NCustomProvider(
      this.maxTipText,
      this.previewText,
      this.selectedOptionsText,
      this.sureText,
      this.titleText,
      this.notPermissionText);

  @override
  String getMaxTipText(Options options) {
    return maxTipText;
  }

  @override
  String getSelectedOptionsText(Options options) {
    return selectedOptionsText;
  }

  @override
  String getTitleText(Options options) {
    return titleText;
  }

  @override
  I18NPermissionProvider getNotPermissionText(Options options) {
    return notPermissionText;
  }
}

class I18NPermissionProvider {
  final String titleText;
  final String sureText;
  final String cancelText;
  final Color titleColor;
  final double titleFontSize;
  final Color sureColor;
  final double sureFontSize;
  final Color cancelColor;
  final double cancelFontSize;

  const I18NPermissionProvider(
      {this.titleText,this.titleColor,this.titleFontSize,this.sureText,this.sureColor,this.sureFontSize,this.cancelText,this.cancelColor,this.cancelFontSize});
}
