class Fruits {
  final String name;
  final String descriptions;
  final String image;

  const Fruits({this.name, this.descriptions, this.image});
}

String path = 'assets/images/';

var fruits = [
  new Fruits(
      name: 'Apples',
      descriptions: 'Green or red, they are generally round and tasty',
      image: path + 'apple.jpg'),
  new Fruits(
      name: 'Avocado',
      descriptions: 'One of the oiliest, richest fruits money can buy',
      image: path + 'avocado.jpg'),
  new Fruits(
      name: 'Blackberries',
      descriptions: 'Find them on back-roads and fences in the Northwest',
      image: path + 'blackberries.jpg'),
  new Fruits(
      name: 'Asparagus',
      descriptions: 'It is been used a food and medicine for millennium',
      image: path + 'asparagus.jpg'),
  new Fruits(
      name: 'Artichokes',
      descriptions: 'The armadillo of vegetables',
      image: path + 'artichokes.jpg'),
  new Fruits(
      name: 'Cantaloupe',
      descriptions: 'A fruit so tasty there is a utensil just for it',
      image: path + 'cantaloupe.jpg'),
  new Fruits(
      name: 'Cauliflower',
      descriptions: 'Looks like white broccoli and explodes when cut',
      image: path + 'cauliflower.jpg'),
];
