import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:media_info/media_info.dart';
import '../models/metadata_model.dart';

class FileUtils {
  static MetadataModel extractMetadata(PlatformFile file) {
    // Handle different file types here
    switch (file.extension) {
      case 'jpg':
      case 'png':
      case 'ico':
      case 'svg':
        // Extract image metadata
        return _extractImageMetadata(file);
      case 'pdf':
        // Extract PDF metadata
        return _extractPdfMetadata(file);
      case 'mp4':
      case 'mp3':
      case 'mov':
      case 'avi':
      case 'wav':
        // Extract media metadata
        return _extractMediaMetadata(file);
      default:
        throw UnsupportedError('File type not supported');
    }
  }

  static MetadataModel _extractImageMetadata(PlatformFile file) {
    // Extract and return image metadata using the `image` package
    img.Image? image = img.decodeImage(file.bytes!);
    return MetadataModel(
      title: 'Default Title',
      description: 'Default Description',
      keywords: ['default', 'keywords'],
      author: 'Unknown',
      altText: 'Default Alt Text',
    );
  }

  static MetadataModel _extractPdfMetadata(PlatformFile file) {
    // Extract and return PDF metadata using the `pdf` package
    return MetadataModel(
      title: 'PDF Title',
      description: 'PDF Description',
      keywords: ['pdf', 'document'],
      author: 'PDF Author',
    );
  }

  static MetadataModel _extractMediaMetadata(PlatformFile file) {
    // Extract and return media metadata using the `media_info` package
    return MetadataModel(
      title: 'Media Title',
      description: 'Media Description',
      keywords: ['media', 'file'],
      author: 'Media Author',
    );
  }

  static void saveMetadata(PlatformFile file, MetadataModel metadata) {
    // Save the metadata back to the file or create a new file with the metadata
  }
}
