class CardData {
  String asset;
  String title;
  int index;

  CardData(this.asset, this.title, this.index);

  static List<CardData> getAllCardData(){
    return [
      CardData('assets/images/airplane.png', 'Flight', 0),
      CardData('assets/images/combustion.png', 'Fuel Combustion', 1),
      CardData('assets/images/electric.png', 'Electricity', 2),
      CardData('assets/images/shipping.png', 'Shipping', 3),
      CardData('assets/images/vehicle.png', 'Vehicle', 4),
    ];
  }

  static CardData getCardData(int index){
    return getAllCardData()[index];
  }
}