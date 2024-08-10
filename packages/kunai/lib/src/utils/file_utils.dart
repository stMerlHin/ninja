import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileUtils {
  // static Future<Directory?> selectDirectory(
  //     {String? confirmButtonText, String? initialDirectory}) async {
  //   String? directoryPath = await getDirectoryPath(
  //       confirmButtonText: confirmButtonText,
  //       initialDirectory: initialDirectory);
  //
  //   if (directoryPath != null) {
  //     return Directory(directoryPath);
  //   }
  //   return null;
  // }

  static Future<File?> selectFile({
    required String label,
    required List<String> extensions,
    FileType type = FileType.custom,
    String? initialDirectory,
    String? confirmButtonText,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: label,
      type: type,
      allowedExtensions: extensions,
    );

    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  static Future<List<File>> selectFiles({
    required String label,
    required List<String> extensions,
    FileType type = FileType.custom,
    String? initialDirectory,
    String? confirmButtonText,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: label,
      type: type,
      allowMultiple: true,
      allowedExtensions: extensions,
    );

    if (result != null) {
      return result.files.map((e) => File(e.path!)).toList();
    }
    return [];
  }

  static Future<File?> selectImageFile({
    required String label,
  }) async {
    return selectFile(
      label: label,
      // type: FileType.image,
      extensions: imageExtensions,
    );
  }

  static Future<List<File>> selectImageFiles({
    required String label,
    // FileType fileType = FileType.custom,
  }) async {
    return selectFiles(
      label: label,
      // type: FileType.image,
      extensions: imageExtensions,
    );
  }

  static Future<File?> selectPdfFile({
    required String label,
  }) async {
    return selectFile(label: label, extensions: ['pdf']);
  }

  // Future<File> _extractPdfImage(File pdfFile, {String? id}) async {
  //   File f =
  //   File('${FileService.getImagesDir()}${id ?? const Uuid().v1()}.png');
  //   await for (var page
  //   in Printing.raster(await pdfFile.readAsBytes(), pages: [0], dpi: 72)) {
  //     //_coversFiles[pdfFile.path]?.deleteSync();
  //     await f.writeAsBytes(await page.toPng());
  //   }
  //   return f;
  // }

  // static Future<bool> viewFile(File file) {
  //   return launchUrl(Uri.parse(file.urlPath));
  // }

  static const List<String> imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'animated gif',
    'webp',
    'animated webp',
    'bmp',
    'wbmp'
  ];
}

extension UrlFile on File {
  String get urlPath {
    return absolute.path.fileUrlPath;
  }

  File get absoluteUrlPath => File(urlPath);
}

extension FileBehaviourExt on String {
  String get fileUrlPath => "file://$this";
}
