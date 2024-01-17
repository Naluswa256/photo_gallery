import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/domain/image_interactor.dart';
import 'package:photo_gallery/domain/model/image_model.dart';
import 'package:photo_gallery/presentation/widgets/image_detail_dialog.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final ImageInteractor imageInteractor = ImageInteractor();
  List<ImageModel> photos = [];
  final _scrollController = ScrollController();
  int _currentPage = 1;
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
    _loadImages(_currentPage);
  }
// function for loading images
  Future<void> _loadImages(int pageNumber) async {
    try {
      final List<ImageModel> fetchedPhotos =
          await imageInteractor.getImages(page: pageNumber, limit: 16);
      setState(() {
        photos = fetchedPhotos;
      });
    } catch (e) {
        rethrow;
    }
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      _loadImages(_currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    int columns = _calculateColumns(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Gallery")),
      body: AnimationLimiter(
        child:GridView.builder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(1),
          itemCount: photos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: _calculateAspectRatio(context),
          ),
          itemBuilder: ((context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: columns,
              child: SlideAnimation(
                delay: const Duration(milliseconds: 500),
                child: Container(
                  padding: const EdgeInsets.all(0.5),
                  child: InkWell(
                    onTap: () => {
                      _showImageDetailsDialog(context,
                          author: photos[index].author,
                          id: photos[index].id,
                          width: photos[index].width,
                          height: photos[index].height,
                          url: photos[index].url,
                          imageUrl: photos[index].downloadUrl)
                    },
                    child: CachedNetworkImage(
                      imageUrl: photos[index].downloadUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
  //function responsible for making the grid responsive 
  int _calculateColumns(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int columns =
        (screenWidth / 160).floor(); // Adjust the width of each container
    return columns > 4 ? 4 : columns; // Maximum of 4 columns
  }

  double _calculateAspectRatio(BuildContext context) {
    double screenWidth = 200;
    double aspectRatio =
        screenWidth / 160; // Adjust the aspect ratio based on your requirements
    return aspectRatio;
  }

  void _showImageDetailsDialog(BuildContext context,
      {required String imageUrl,
      required String id,
      required String author,
      required int width,
      required int height,
      required String url}) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: Dialog(
              child: ImageDetailsDialog(
                  imageUrl: imageUrl,
                  id: id,
                  author: author,
                  width: width,
                  height: height,
                  url: url)),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
