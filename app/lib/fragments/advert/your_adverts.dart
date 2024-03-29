import 'dart:convert';
import 'package:app/fragments/advert/add_advert.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/functions/refresh.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/functions/advert_card_widget.dart';
import 'package:app/functions/advert_page_widget.dart';

import 'package:app/api/api_connection.dart';
import 'package:http/http.dart' as http;

import 'package:app/model/current_user.dart';
import 'package:get/get.dart';

class YourAdvert extends StatefulWidget {
  const YourAdvert({Key? key}) : super(key: key);

  @override
  State<YourAdvert> createState() => _YourAdvertState();
}

class _YourAdvertState extends State<YourAdvert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            size: 18,
            color: TextColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            'Your adverts',
            style: TextStyle(
              color: TextColor,
              fontWeight: FontWeight.w500,
              fontSize: 24
            ),
          ),
        ),
        backgroundColor: Background,
        
      ),
      body: YourAdvertBody(),
    );
  }
}

class YourAdvertBody extends StatefulWidget {
  const YourAdvertBody({Key? key}) : super(key: key);

  @override
  State<YourAdvertBody> createState() => _YourAdvertBodyState();
}

class _YourAdvertBodyState extends State<YourAdvertBody> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void updateStateWithData(List<dynamic> newData) {
    setState(() {
      
    });
  }

Future<void> _refreshData() async {
  await refreshData(getAdvertData, updateStateWithData);
}

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refreshData,
            child: AdvertView(dataFetcher: getAdvertData),
          ),
        ),
        Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAdvert(),
                    ),
                  );
                },
                backgroundColor: mainColor, // Set the background color to mainColor
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: 20,
                ),
              ),
            )
      ],
    );
  }
}

class AdvertView extends StatelessWidget {
  final Future<List<dynamic>> Function() dataFetcher;

  AdvertView({Key? key, required this.dataFetcher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: dataFetcher(),
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

          return AdvertItemView(adverts);
        },
      ),
    );
  }
}

class AdvertItemView extends StatelessWidget {
  final List<dynamic> data;

  const AdvertItemView(this.data, {Key? key}) : super(key: key);

  Widget _buildAdvertCard(BuildContext context, Map<String, dynamic> advert) {
    String animalPrice = advert['price'].toString();
    String imageUrl = advert['image'][0]['image'].toString(); // Get the first image URL

    return YourAdvertCard(
      advert: advert,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => YourAdvertPage(
              advert: advert,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> advert = data[index];
        return _buildAdvertCard(context, advert);
      },
    );
  }
}

Future<List<dynamic>> getAdvertData() async {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  final response = await http.post(
    Uri.parse(API.yourAdvert),
    body: {
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