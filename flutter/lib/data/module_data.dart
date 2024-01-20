import 'package:flutter/material.dart';

class Heading {
  const Heading({
    // required this.text,
    this.topPadding = 20,
    this.bottomPadding = 0,
  });
  // final String text;
  final double topPadding;
  final double bottomPadding;
}

class SubHeading {
  const SubHeading({
    required this.text,
    this.topPadding = 20,
    this.bottomPadding = 5,
  });
  final String text;
  final double topPadding;
  final double bottomPadding;
}

class Body {
  const Body({
    required this.text,
    this.topPadding = 10,
    this.bottomPadding = 10,
  });
  final String text;
  final double topPadding;
  final double bottomPadding;
}

class BulletPoint {
  const BulletPoint({
    required this.text,
    this.topPadding = 10,
    this.bottomPadding = 10,
  });
  final String text;
  final double topPadding;
  final double bottomPadding;
}

class ImageContent {
  const ImageContent({
    required this.image,
    this.topPadding = 0,
    this.bottomPadding = 0,
  });
  final Image image;
  final double topPadding;
  final double bottomPadding;

  Widget build(BuildContext context) {
    // Get the screen width using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: SizedBox(
        width: screenWidth - 100, // Adjust as needed
        child: image,
      ),
    );
  }
}

class TabularColumn {
  final List<List<String>> data;
  final TextStyle headerTextStyle;
  final TextStyle cellTextStyle;

  const TabularColumn({
    required this.data,
    this.headerTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    this.cellTextStyle = const TextStyle(
      fontSize: 16,
    ),
  });

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Table(
        border: TableBorder.all(),
        children: data.asMap().entries.map((entry) {
          final rowIndex = entry.key;
          final row = entry.value;
          return TableRow(
            children: row.map((cell) {
              return TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cell,
                    style: rowIndex == 0 ? headerTextStyle : cellTextStyle,
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

final List<dynamic> module = [
  {
    'title': 'Shelf Analytics',
    // ImageContent(
    //   image: Image.asset(
    //     "assets/images/sample/sample_2.png",
    //     width: double.infinity,
    //     fit: BoxFit.fitWidth,
    //   ),
    // ),
    'content': [
      [
        const Heading(),
        const SubHeading(text: "FMCG and FMCD"),
        const Body(
          text:
              "FMCG -> Fast Moving Consumer Goods	\nFMCD -> Fast Moving Consumer Durables",
        ),
        const TabularColumn(
          data: [
            [
              'FMCG',
              'FMCD',
            ],
            [
              'Personal Care products , Shampoo, Face Wash, Soap etc',
              'Automobile , Cars, Bikes, Trucks etc'
            ],
            [
              'Packaged Food & Beverages , Chips, Juices, Carbonated drinks etc',
              'Household appliances , Washing Machine, Iron, Oven, Vacuum Cleaner etc'
            ],
            [
              'Laundry , Detergent etc \nOver the counter Medicines',
              'Electronic gadgets , Smart Phones, Laptops etc'
            ],
          ],
        ),
        const SubHeading(
          text: "Examples of FMCG",
        ),
        ImageContent(
          image: Image.asset(
            "assets/images/module1/fmcg_eg.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        const SubHeading(
          text: "Examples of FMCD",
        ),
        ImageContent(
          image: Image.asset(
            "assets/images/module1/fmcd_eg.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        const Body(
          text:
              "As per ICRA the term FMCG has been defined to include products that are consumed at least once a month, sold under the national brands in consumer packages, sold through a wide spared distribution network and consumed directly by the consumers.",
        ),
        const Body(
          text:
              "The main difference between the two is that FMCG products are consumable while FMCD products are non-durable and have a longer usage period. They also differ basis the buying decision. ",
        ),
        const SizedBox()
      ],
      [
        const Heading(),
        const SubHeading(text: "FMCG and FMCD"),
        const Body(
          text:
              "FMCG -> Fast Moving Consumer Goods	\nFMCD -> Fast Moving Consumer Durables",
        ),
        const TabularColumn(
          data: [
            [
              'FMCG',
              'FMCD',
            ],
            [
              'Personal Care products , Shampoo, Face Wash, Soap etc',
              'Automobile , Cars, Bikes, Trucks etc'
            ],
            [
              'Packaged Food & Beverages , Chips, Juices, Carbonated drinks etc',
              'Household appliances , Washing Machine, Iron, Oven, Vacuum Cleaner etc'
            ],
            [
              'Laundry , Detergent etc \nOver the counter Medicines',
              'Electronic gadgets , Smart Phones, Laptops etc'
            ],
          ],
        ),
        const SubHeading(
          text: "Examples of FMCG",
        ),
        ImageContent(
          image: Image.asset(
            "assets/images/module1/fmcg_eg.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        const SubHeading(
          text: "Examples of FMCD",
        ),
        ImageContent(
          image: Image.asset(
            "assets/images/module1/fmcd_eg.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        const Body(
          text:
              "As per ICRA the term FMCG has been defined to include products that are consumed at least once a month, sold under the national brands in consumer packages, sold through a wide spared distribution network and consumed directly by the consumers.",
        ),
        const Body(
          text:
              "The main difference between the two is that FMCG products are consumable while FMCD products are non-durable and have a longer usage period. They also differ basis the buying decision. ",
        ),
        const SizedBox()
      ],
    ],
  },
  {
    'title': 'iahdiasd',
    'content': [
      [
        const Heading(),
        const SubHeading(text: "FMCG and FMCD"),
        const Body(
          text:
              "FMCG -> Fast Moving Consumer Goods	\nFMCD -> Fast Moving Consumer Durables",
        ),
        const TabularColumn(
          data: [
            [
              'FMCG',
              'FMCD',
            ],
            [
              'Personal Care products , Shampoo, Face Wash, Soap etc',
              'Automobile , Cars, Bikes, Trucks etc'
            ],
            [
              'Packaged Food & Beverages , Chips, Juices, Carbonated drinks etc',
              'Household appliances , Washing Machine, Iron, Oven, Vacuum Cleaner etc'
            ],
            [
              'Laundry , Detergent etc \nOver the counter Medicines',
              'Electronic gadgets , Smart Phones, Laptops etc'
            ],
          ],
        ),
        const SubHeading(
          text: "Examples of FMCG",
        ),
        ImageContent(
          image: Image.asset(
            "assets/images/module1/fmcg_eg.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        const SubHeading(
          text: "Examples of FMCD",
        ),
        ImageContent(
          image: Image.asset(
            "assets/images/module1/fmcd_eg.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        const Body(
          text:
              "As per ICRA the term FMCG has been defined to include products that are consumed at least once a month, sold under the national brands in consumer packages, sold through a wide spared distribution network and consumed directly by the consumers.",
        ),
        const Body(
          text:
              "The main difference between the two is that FMCG products are consumable while FMCD products are non-durable and have a longer usage period. They also differ basis the buying decision. ",
        ),
        const SizedBox()
      ]
    ]
  },
  {
    'title': '',
    'content': [[]]
  },
  {
    'title': '',
    'content': [[]]
  },
  {
    'title': '',
    'content': [[]]
  },
  {
    'title': '',
    'content': [[]]
  },
  {
    'title': '',
    'content': [[]]
  },
  {
    'title': '',
    'content': [[]]
  },
  {
    'title': '',
    'content': [[]]
  },
  {
    'title': '',
    'content': [[]]
  },
];
