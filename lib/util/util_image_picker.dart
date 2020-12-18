import 'dart:io';
import 'dart:typed_data';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

typedef OptionsSuccessBlock = Function(dynamic result);

final List<String> optionslist = ["拍照", "相册"];

class AppImagePicker {
  /// 选项列表 Function<T> : imageFile or saveBool or errorString
  void showSheet(
    BuildContext context,
    OptionsSuccessBlock optionsBlock, {
    bool isCrop = true,
    String saveImageFilePath,
    Uint8List saveImageBytes,
  }) async {
    List items = optionslist.toList();
    bool isSave = (saveImageFilePath != null || saveImageBytes != null);
    String saveTitle = "保存图片";
    if (isSave) {
      items.add(saveTitle);
    }
    _show(context, items, (title) {
      Navigator.pop(context);
      if (isSave && title == saveTitle) {
        if (saveImageBytes != null) {
          saveImageToGallery(saveImageBytes, optionsBlock);
        }
        if (saveImageFilePath != null) {
          saveFileToGallery(saveImageFilePath, optionsBlock);
        }
      } else {
        _optionsHandlder(title, isCrop, optionsBlock);
      }
    });
  }

  /// 选择图片
  Future<dynamic> pickImage({OptionsSuccessBlock optionsBlock}) async {
    var isGranted = await Permission.photos.request().isGranted;
    if (isGranted == true) {
      File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (optionsBlock != null) optionsBlock(imageFile);
      return imageFile;
    } else {
      String info = "没有使用相册的权限";
      if (optionsBlock != null) optionsBlock(info);
      return;
    }
  }

  /// 拍照
  Future<dynamic> takePhoto({OptionsSuccessBlock optionsBlock}) async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      if (iosInfo.isPhysicalDevice == false) {
        String info = "模拟器不可以使用摄像头";
        if (optionsBlock != null) optionsBlock(info);
        return info;
      }
    }
    var isGranted = await Permission.camera.request().isGranted;
    if (isGranted == true) {
      var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
      if (optionsBlock != null) optionsBlock(imageFile);
      return imageFile;
    } else {
      String info = "没有使用摄像头的权限";
      if (optionsBlock != null) optionsBlock(info);
      return info;
    }
  }

  /// 剪裁
  Future<File> cropImage(File croppedFile,
      {OptionsSuccessBlock optionsBlock}) async {
    File imageFile = await ImageCropper.cropImage(
      sourcePath: croppedFile.path,
      toolbarTitle: 'Cropper',
      toolbarColor: Colors.blue,
      toolbarWidgetColor: Colors.white,
    );
    if (optionsBlock != null) optionsBlock(imageFile);
    return imageFile;
  }

  //保存图片字节图库
  Future<dynamic> saveImageToGallery(
      Uint8List imageBytes, OptionsSuccessBlock saveBlock) async {
    var isGranted = await Permission.photos.request().isGranted;
    print(isGranted);
    if (isGranted == true) {
      final result = await ImageGallerySaver.saveImage(imageBytes,
          quality: 60, name: "scriptkill");
      if (saveBlock != null) saveBlock(result);
      return result;
    } else {
      String info = "没有使用相册的权限";
      if (saveBlock != null) saveBlock(info);
      return info;
    }
  }

//保存路径图片到文件夹
  Future<dynamic> saveFileToGallery(
      String filePath, OptionsSuccessBlock saveBlock) async {
    var isGranted = await Permission.photos.request().isGranted;
    if (isGranted == true) {
      final result = await ImageGallerySaver.saveFile(filePath);
      if (saveBlock != null) saveBlock(result);
      return result;
    } else {
      String info = "没有使用相册的权限";
      if (saveBlock != null) saveBlock(info);
      return info;
    }
  }
}

extension on AppImagePicker {
  void _optionsHandlder(
      String title, bool isCrop, OptionsSuccessBlock optionsBlock) async {
    var f;
    if (title == "拍照") {
      f = await takePhoto();
    }
    if (title == "相册") {
      f = await pickImage();
    }
    if (isCrop == true && f != null && f is File) {
      f = await cropImage(f);
    }
    if (f != null && optionsBlock != null) {
      optionsBlock(f);
    }
  }

  void _show(BuildContext context, List<String> items,
      Function(String title) selected) async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                        children: items
                            .map((i) => GestureDetector(
                                  onTap: () => selected(i),
                                  child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          vertical: AppLayout.height(16.0)),
                                      child: Text(
                                        i,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: AppLayout.px(16)),
                                      ),
                                      color: Colors.white),
                                ))
                            .toList()),
                    ListTile(
                      title: Text(
                        '取消',
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: AppLayout.height(20.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
