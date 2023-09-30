import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/functions/advert_card_widget.dart';
import 'package:app/functions/advert_page_widget.dart';
import 'package:app/fragments/search_page.dart';
import 'package:app/api/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/current_user.dart';
import 'package:get/get.dart';

class Adverts extends StatelessWidget {
  final String category;
  const Adverts({
    Key? key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: mainColor,
        backgroundColor: Background,
        elevation: 0.0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            size: 18,
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(
                FontAwesomeIcons.search,
                size: 18,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(category: category),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: AdvertsBody(category: category),
    );
  }
}

class AdvertsBody extends StatefulWidget {
  final String category;
  const AdvertsBody({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _AdvertsBodyState createState() => _AdvertsBodyState();
}

class _AdvertsBodyState extends State<AdvertsBody> {
  // Add a GlobalKey for the RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Function to refresh data
  Future<void> _refreshData() async {
    // Your data refresh logic here
    // For example, you can call your API again to fetch updated data
    // Update the data in the state and rebuild the UI
    setState(() {
      // Update your data here
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => _refreshData(),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: AdvertView(
              category: widget.category,
              refreshCallback: _refreshData, // Pass the refresh callback
            ),
          ),
        ],
      ),
    );
  }
}

class AdvertView extends StatelessWidget {
  final String category;
  final Function refreshCallback; // Callback function for refresh
  final CurrentUser _currentUser = Get.put(CurrentUser());

  AdvertView({
    Key? key,
    required this.category,
    required this.refreshCallback,
  }) : super(key: key);

  Future<List<dynamic>> getAdvertData(String category) async {
    final response = await http.post(
      Uri.parse(API.viewAdvert),
      body: {
        'category': category,
        'user_id': '${_currentUser.user.id}',
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
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
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: getAdvertData(category),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text("Error loading data."));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final adverts = snapshot.data;

          if (adverts == null || adverts.isEmpty) {
            return Center(child: Text("No data available."));
          }

          return AdvertItemView(
            adverts: adverts,
            refreshCallback: refreshCallback, // Pass the refresh callback
          );
        },
      ),
    );
  }
}

class AdvertItemView extends StatelessWidget {
  final List<dynamic> adverts;
  final Function refreshCallback; // Callback function for refresh

  const AdvertItemView({
    required this.adverts,
    required this.refreshCallback,
    Key? key,
  }) : super(key: key);

  Widget _buildAdvertCard(BuildContext context, Map<String, dynamic> advert) {
    String animalPrice = advert['price'].toString();
    String imageUrl = advert['image'][0]['image'].toString(); // Get the first image URL

    return AdvertCard(
      advert: advert, // Use the extracted image URL
      onTap: () async {
        refreshCallback();
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdvertPage(advert: advert),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: adverts.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> advert = adverts[index];
        return _buildAdvertCard(context, advert);
      },
    );
  }
}