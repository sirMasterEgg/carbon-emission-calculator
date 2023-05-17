import 'package:dicoding/models/card_data.dart';
import 'package:dicoding/selected_menu.dart';
import 'package:flutter/material.dart';



class Home extends StatelessWidget {
  static const String routeName = '/';

  const Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    List<CardData> card = CardData.getAllCardData();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
            child: Column(
          children: <Widget>[
            Row(
              children: const [
                Expanded(
                  child: Text(
                    'Carbon Calculator',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  for (var i = 0; i < card.length; i++)
                    filterCard(createCard(card[i].asset, card[i].title, card[i].index, context), card[i].index),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  void _onCardTap(int index, BuildContext context) {
    if (index != 0){
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectedMenu(index)),
    );
  }

  Widget filterCard(Widget card, int index){
    if (index == 0){
      return card;
    }

    return Container(
      foregroundDecoration: const BoxDecoration(
        color: Colors.grey,
        backgroundBlendMode: BlendMode.saturation,
      ),
      child: card,
    );
  }

  Widget createCard (String image, String title, int index, BuildContext context){
    const borderRadius = 25.0;
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          splashColor: index != 0 ? Colors.transparent : null,
          highlightColor: index != 0 ? Colors.transparent : null,
          onTap: () => _onCardTap(index, context),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(image, height: 50, width: 100,),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
