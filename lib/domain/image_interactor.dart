// image_interactor.dartmport ImageDetailsModel

import 'package:photo_gallery/data/repository.dart';
import 'package:photo_gallery/domain/model/image_model.dart';

class ImageInteractor {
  final ApiRepository apiRepository = ApiRepository();

  Future<List<ImageModel>> getImages({int page = 1, int limit = 10}) async {
    final List<Map<String, dynamic>> imagesData = await apiRepository.fetchImages(page: page, limit: limit);
    return imagesData.map((imageData) => ImageModel.fromJson(imageData)).toList();
  }

}
