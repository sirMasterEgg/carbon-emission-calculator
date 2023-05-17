import 'dart:convert';

import 'package:dicoding/environment_variables.dart';
import 'package:dicoding/models/card_data.dart';
import 'package:dicoding/models/flight_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SelectedMenu extends StatefulWidget {
  static const String routeName = '/menu';

  final int index;
  const SelectedMenu(this.index, {Key? key}) : super(key: key);

  @override
  State<SelectedMenu> createState() => _SelectedMenuState();
}

class _SelectedMenuState extends State<SelectedMenu> {

  String? departure = '';
  String? arrival = '';
  int? passenger = 0;
  String distanceUnit = 'km';
  String cabinClass = 'economy';

  bool _distanceUnitToggle = false;
  bool _cabinClassToggle = false;

  Future<FlightResponse> fetchFlight() async {
    Map body = {
      'type': 'flight',
      'passenger': passenger,
      'legs': [
        {'departure_airport': departure, 'destination_airport': arrival, 'cabin_class': cabinClass}
      ],
      'distance_unit': distanceUnit
    };

    final response = await http.post(Uri.parse('https://www.carboninterface.com/api/v1/estimates'),
        headers: {
          'Authorization': 'Bearer ${Env.API_KEY}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(body)
    );

    if (response.statusCode == 201) {
      return FlightResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load flight');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CardData card = CardData.getCardData(widget.index);
    final List<String> suggestions = [];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text(
                      card.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                /** Isi **/
                child: Wrap(
                  spacing: 8, //vertical spacing
                  runSpacing: 8, //horizontal spacing
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 175,
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return suggestions.where((String option) {
                            return option.contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          print('You just selected $selection');
                        },
                        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                          return TextField(
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                                hintText: 'ex. CGK',
                                labelText: 'Departure (IATA Code)'
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
                              LengthLimitingTextInputFormatter(3)
                            ],
                            textCapitalization: TextCapitalization.characters,
                            onSubmitted: (_) => onFieldSubmitted(),
                            onChanged: (String value){
                              setState(() {
                                departure = value;
                              });
                            },
                          );
                        },
                        optionsViewBuilder: (context, onSelected, options) {
                          return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4.0,
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width - 235,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(0.0),
                                      itemCount: options.length,
                                      separatorBuilder: (context, i) {
                                        return const Divider();
                                      },
                                      itemBuilder: (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(suggestions[index]),
                                          onTap: () {
                                            onSelected(suggestions[index]);
                                          },
                                        );
                                      },
                                    )
                                ),
                              )
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 175,
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return suggestions.where((String option) {
                            return option.contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          print('You just selected $selection');
                        },
                        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                          return TextField(
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                                hintText: 'ex. CGK',
                                labelText: 'Arrival (IATA Code)'
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
                              LengthLimitingTextInputFormatter(3)
                            ],
                            textCapitalization: TextCapitalization.characters,
                            onSubmitted: (_) => onFieldSubmitted(),
                            onChanged: (String value){
                              setState(() {
                                arrival = value;
                              });
                            },
                          );
                        },
                        optionsViewBuilder: (context, onSelected, options) {
                          return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4.0,
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width - 235,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(0.0),
                                      itemCount: options.length,
                                      separatorBuilder: (context, i) {
                                        return const Divider();
                                      },
                                      itemBuilder: (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(suggestions[index]),
                                          onTap: () {
                                            onSelected(suggestions[index]);
                                          },
                                        );
                                      },
                                    )
                                ),
                              )
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 175,
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Number of passenger...',
                          labelText: 'Passenger',
                        ),
                        onChanged: (String value){
                          setState(() {
                            passenger = int.tryParse(value);
                          });
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 175,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(child: Text('Economy')),
                              Switch(
                                value: _cabinClassToggle,
                                onChanged: (bool value){
                                  setState(() {
                                    _cabinClassToggle = value;
                                    if (_cabinClassToggle) {
                                      cabinClass = 'premium';
                                    }
                                    else {
                                      cabinClass = 'economy';
                                    }
                                  });
                                },
                              ),
                              const Expanded(child: Text('Premium')),
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(child: Text('km')),
                              Switch(
                                value: _distanceUnitToggle,
                                onChanged: (bool value){
                                  setState(() {
                                    _distanceUnitToggle = value;
                                    if (_distanceUnitToggle) {
                                      distanceUnit = 'mi';
                                    }
                                    else {
                                      distanceUnit = 'km';
                                    }
                                  });
                                },
                              ),
                              const Expanded(child: Text('mi')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 175 * 2,
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return FutureBuilder<FlightResponse>(
                                    future: fetchFlight(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData){
                                        var data = snapshot.data?.data as Data;
                                        return AlertDialog(
                                          title: const Center(child: Text('Result', style: TextStyle(fontWeight: FontWeight.bold),)),
                                          content: SizedBox(
                                              height: 100,
                                              width: 300,
                                              child: Column(
                                                children: [
                                                  Text('Passenger(s): ${data.attributes?.passengers}'),
                                                  Text('Departure: ${data.attributes?.legs?.first.departureAirport}'),
                                                  Text('Arrival: ${data.attributes?.legs?.first.destinationAirport}'),
                                                  Text('Distance: ${data.attributes?.distanceValue} ${data.attributes?.distanceUnit}'),
                                                  Text('Total Carbon Emission: ${data.attributes?.carbonKg!} kg'),
                                                ],
                                              )
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14.0)
                                          ),
                                        );
                                      }
                                      else if (snapshot.hasError) {
                                        return const AlertDialog(content: Text('Failed to load flight!'));
                                      }

                                      return Center(
                                        child: LoadingAnimationWidget.waveDots(
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                      );
                                    },
                                  );
                                }
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              )
                            ),
                          ),
                          child: const Text('Submit')
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
