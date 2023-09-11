import 'dart:convert';
import 'package:app/widgets/advert_card_widget.dart';
import 'package:app/widgets/advert_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:app/api/api_connection.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: NavigationBarSel,
        backgroundColor: background,
        elevation: 0.0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.xmark,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Image(
              image: AssetImage('images/logo.png'),
              height: 65,
            ),
          ],
        ),
      ),
      body: SearchPageBody(),
    );
  }
}

class SearchPageBody extends StatefulWidget {
  SearchPageBody({Key? key}) : super(key: key);

  @override
  _SearchPageBodyState createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  String searchText = '';
  List<dynamic> searchResults = [];

  Future<List<dynamic>> getSearchData(String searchQuery) async {
    final response = await http.post(
      Uri.parse(API.search),
      body: {
        'search': searchQuery,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData.containsKey('advert')) {
        return jsonData['advert'];
      } else {
        throw Exception("No 'advert' key found in JSON response.");
      }
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(
                Icons.search,
                color: NavigationBarSel,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: NavigationBarSel,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
              _performSearch();
            },
          ),
        ),
        Expanded(
          child: _buildSearchResults(),
        ),
      ],
    );
  }

  void _performSearch() async {
    if (searchText.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    try {
      final results = await getSearchData(searchText);
      setState(() {
        searchResults = results;
      });
    } catch (error) {
      print("Error performing search: $error");
    }
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return Center(child: Text("No results found."));
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> advert = searchResults[index];
        return _buildAdvertCard(context, advert);
      },
    );
  }

  Widget _buildAdvertCard(BuildContext context, Map<String, dynamic> advert) {
    String animalPrice = advert['price'].toString();
    String imageUrl = advert['image'][0]['image'].toString();

    return AdvertCard(
      advert: advert,
      onTap: () {
        // Replace this navigation logic with the appropriate page/widget
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => YourAdvertPage(advert: advert), // Replace with your actual page/widget
          ),
        );
      },
    );
  }
}