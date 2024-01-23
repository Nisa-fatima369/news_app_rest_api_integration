import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app_rest_api_integration/screens/detail_screen.dart';
import 'package:news_app_rest_api_integration/view_model/news_view_model.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Sports',
    'Technology',
  ];

  NewsViewModdel newsViewModdel = NewsViewModdel();
  final format = DateFormat('MMMM dd, yyyy');
  String categoryName = 'general';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    categoryName = categories[index];
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: categoryName == categories[index]
                            ? Colors.blueGrey
                            : Colors.grey[400],
                      ),
                      child: Center(
                        child: Text(
                          categories[index].toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: newsViewModdel.fetchCategoriesNewsApi(categoryName),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.articles?.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailScreen(
                                    image: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    title: snapshot.data!.articles![index].title
                                        .toString(),
                                    description: snapshot
                                        .data!.articles![index].description
                                        .toString(),
                                    date: snapshot
                                        .data!.articles![index].publishedAt
                                        .toString(),
                                    source: snapshot
                                        .data!.articles![index].source!.name
                                        .toString());
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: size.height * 0.2,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.grey[300],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: size.height * 0.2,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                                  .data!
                                                  .articles![index]
                                                  .urlToImage ??
                                              '',
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: SpinKitCircle(
                                                color: Colors.blueAccent,
                                                size: 50.0),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index]
                                                    .title ??
                                                'No Title',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            snapshot.data!.articles![index]
                                                    .description ??
                                                'No Description',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                        .source!.name ??
                                                    'No Source',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
