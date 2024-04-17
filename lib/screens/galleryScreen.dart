import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'myInfo.dart';


class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<Map<String, dynamic>> _images = [];
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchImages('');
  }

  Future<void> _fetchImages(String query) async {
    setState(() {
      _isLoading = true;
    });

    const apiKey = '43422982-3f356e61baddf59669d56d4ce';
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=$apiKey&q=$query&image_type=photo&pretty=true'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _images = List<Map<String, dynamic>>.from(data['hits']);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount;
    if (MediaQuery.of(context).size.width < 600) {
      // Mobile devices
      crossAxisCount = 2;
    } else if (MediaQuery.of(context).size.width < 1200) {
      // Tablets
      crossAxisCount = 3;
    } else {
      // Laptops and larger screens
      crossAxisCount = 5;
    }
    return Scaffold(
      appBar: AppBar(
        flexibleSpace:  Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple,Colors.pinkAccent, Colors.purple],
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
              )
          ),
        ),
        title: Text(
          'Gallery',
          style: TextStyle(
            fontSize: 40, // Adjust the size as needed
            fontWeight: FontWeight.bold,
            color: Colors.white// Adjust the weight as needed
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: Colors.white,),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyInfo(),
                  ));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _fetchImages(_searchController.text);
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink), // Change the color of the border when the TextField is focused
                  borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple), // Change the color of the border when the TextField is not focused
                  borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                ),
              ),
              onSubmitted: (value) {
                _fetchImages(value);
              },
            ),

          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.purple,))
                : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1.0, // Ensures items are square
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                final image = _images[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreenImage(image: image),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag${image['id']}',
                              child: Image.network(
                                image['webformatURL'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.red.shade800,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '${image['likes']}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.chat_rounded,
                                    color: Colors.brown.shade800,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '${image['comments']}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

class FullScreenImage extends StatelessWidget {
  final Map<String, dynamic> image;

  const FullScreenImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    double imageWidth;
    double imageHeight;
    double screenHeight = MediaQuery.of(context).size.height;
    imageHeight = screenHeight * (2/3);

    if (MediaQuery.of(context).size.width < 600) {
      // Mobile devices
      imageWidth = double.infinity;
    } else if (MediaQuery.of(context).size.width < 1200) {
      // Tablets
      imageWidth = 300;
    } else {
      // Laptops and larger screens
      imageWidth = 500;
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.yellow.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'imageTag${image['id']}',
              child: Image.network(
                  image['largeImageURL'],
                  fit: BoxFit.cover, // Ensure image covers the entire space
                  width: imageWidth,
                height: imageHeight,
                ),
            ),
            Text(
              'Views : ${image['views']}',
              style: const TextStyle(color: Colors.green,fontSize: 40),
            ),
            Text(
              'Likes : ${image['likes']}',
              style: const TextStyle(color: Colors.red,fontSize: 40),
            ),
            Text(
              'Comments : ${image['comments']}',
              style: const TextStyle(color: Colors.brown,fontSize: 40),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set button color to blue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Set border radius to 15
                ),
              ),
              child: Text(
                'Go back',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
