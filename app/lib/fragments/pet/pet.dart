import 'dart:convert';

import 'package:app/fragments/pet/edit_pet_page.dart';
import 'package:app/fragments/pet/add_pet.dart';
import 'package:app/functions/refresh.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/api/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:app/model/user_pet.dart';
import 'package:app/model/current_user.dart';

class PetPage extends StatefulWidget {
  const PetPage({Key? key}) : super(key: key);

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  List<User_Pet> userPets = [];
  User_Pet? userPet;

  @override
  void initState() {
    super.initState();
    // Fetch data from the API when the widget is created
    getData();
  }

  Future<void> getData() async {
    final CurrentUser _currentUser = Get.put(CurrentUser());

    final response = await http.post(
      Uri.parse(API.userPet),
      body: {
        'user_id': '4000',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Check if the 'yourPet' key exists in the response data
      if (responseData.containsKey('yourPet')) {
        final List<dynamic> jsonData = responseData['yourPet'];

        final List<User_Pet> pets =
            jsonData.map((data) => User_Pet.fromJson(data)).toList();

        setState(() {
          userPets = pets;
          if (pets.isNotEmpty) {
            userPet = pets.first; // Select the first pet by default
          }
        });
      } else {
        // Handle the case where 'yourPet' key is not found in the response data
        print("No 'yourPet' data found in the response.");
      }
    }
  }
  
  void updateStateWithData(List<dynamic> newData) {
    setState(() {
      // Update the data with the newly fetched data
      // Example:
      // data = newData;
    });
  }

  Future<void> _refreshData() async {
    await refreshData(getData, updateStateWithData);
  }

  @override
  Widget build(BuildContext context) {
    final CurrentUser _currentUser = Get.put(CurrentUser());
    return Scaffold(
      backgroundColor: Background,
      body: RefreshIndicator(
        onRefresh: _refreshData,// Trigger fetchData when refreshing
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.0, // Adjust the height as needed
                  child: ListView.builder(
                    itemCount: userPets.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final selectedPet = userPets[index];
                      final isSelected = selectedPet == userPet;

                      return Padding(
                        padding: const EdgeInsets.only(left: 20, top: 15),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              userPet = selectedPet; // Update the selected userPet
                            });
                            print(userPet?.id);
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? mainColor : Colors.transparent, // Border color based on selection
                                    width: 2.5, // Border width
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.network(
                                    selectedPet.image ??
                                        "https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png", // Add a null check here
                                    height: 60.0,
                                    width: 60.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(selectedPet.name ?? 'Error'), // Add a null check here
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: userPet != null
                          ? PetSheet(
                              id: userPet?.id.toString() ?? '',
                              image: userPet?.image ?? '',
                              name: userPet?.name ?? '',
                              species: userPet?.species ?? '',
                              sex: userPet?.sex ?? '',
                              breed: userPet?.breed ?? '',
                              birthdate: userPet?.birthdate ?? '',
                              weight: userPet?.weight ?? '',
                              food: userPet?.food ?? '',
                              onSave: getData, // Pass the fetchData callback here
                            )
                          : Center(
                              // Handle the case when userPet is null, for example, show a loading indicator or a message.
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPetPage(),
                    ),
                  );
                },
                backgroundColor: mainColor, // Set the background color to mainColor
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PetSheet extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final String species;
  final String sex;
  final String breed;
  final String birthdate;
  final String weight;
  final String food;
  final VoidCallback onSave;
  final User_Pet? pet; // Use User_Pet? to indicate it can be null

  const PetSheet({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.species,
    required this.sex,
    required this.breed,
    required this.birthdate,
    required this.weight,
    required this.food,
    required this.onSave,
    this.pet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderRadius = 15.0;

    Container PetEachInfo(IconData icon, Color iconColor, String text, String subtext) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Background,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: TextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      subtext,
                      style: TextStyle(
                        color: TextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Container BasicInfo() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Basic Info',
                    style: TextStyle(
                      color: TextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPetPage(
                            id: id,
                            image: image,
                            name: name,
                            species: species,
                            sex: sex,
                            breed: breed,
                            birthdate: birthdate,
                            weight: weight,
                            food: food,
                            type: 'Basic',
                            onSave: onSave,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PetEachInfo(FontAwesomeIcons.paw, mainColor, 'Name', name),
                      PetEachInfo(FontAwesomeIcons.codeBranch, mainColor, 'Species', species),
                      PetEachInfo(FontAwesomeIcons.venusMars, mainColor, 'Sex', sex),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 45, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PetEachInfo(FontAwesomeIcons.dna, mainColor, 'Breed', breed),
                      PetEachInfo(FontAwesomeIcons.cake, mainColor, 'Birthdate', birthdate),
                      PetEachInfo(FontAwesomeIcons.weight, mainColor, 'Weight', weight),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Container Diet() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Diet',
                    style: TextStyle(
                      color: TextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPetPage(
                            id: id,
                            image: image,
                            name: name,
                            species: species,
                            sex: sex,
                            breed: breed,
                            birthdate: birthdate,
                            weight: weight,
                            food: food,
                            type: 'Diet',
                            onSave: onSave,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PetEachInfo(FontAwesomeIcons.bone, GREEN, 'Food', food),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 45, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
              child: Image.network(
                image,
                height: 160.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius),
              ),
              child: Container(
                color: CardBG,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicInfo(),
                    Diet(),
                  ],
                ),
              ),
            ),
          ],
        ),
        
      ],
    );
  }
}