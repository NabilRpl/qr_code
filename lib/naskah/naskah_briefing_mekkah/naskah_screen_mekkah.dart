import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'arafah.dart';
import 'clock_tower.dart';
import 'gua_hira.dart';
import 'jabal_nur.dart';
import 'jabal_rahmah.dart';
import 'jabal_tsur.dart';
import 'masjid_al_khoif.dart';
import 'masjid_jin.dart';
import 'masjid_tanim.dart';
import 'masjidil_haram.dart';
import 'mina.dart';
import 'muzdalifah.dart';


class NaskahScreenMekkah extends StatelessWidget {
  final List<String> carouselImages = [
    'assets/images/banner_naskah.jpg',
    'assets/images/banner_naskah.jpg',
    'assets/images/banner_naskah.jpg',
    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1.0, // Full width for each image
            ),
            items: carouselImages.map((imagePath) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFE6E0F8),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20), // Added spacing here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bandara Jeddah ke Mekkah',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.purple, thickness: 2),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildDoaCard(context, 'Briefing Jabal Rahmah',
                    '', JabalRahmah()),
                _buildDoaCard(context, 'Briefing Arafah',
                    '', Arafah()),
                _buildDoaCard(context, 'Briefing Mina',
                    '', Mina()),
                _buildDoaCard(context, 'Briefing Muzdalifah',
                    'Dibacakan saat mabit (bermalam) di Muzdalifah', Muzdalifah()),
                _buildDoaCard(context, 'Briefing Jabal Tsur',
                    'Dibacakan saat ziarah ke Jabal Tsur', JabalTsur()),
                _buildDoaCard(context, 'Briefing Jabal Nur',
                    'Dibacakan saat ziarah ke Jabal Nur', JabalNur()),
                _buildDoaCard(context, 'Briefing Masjidil Haram',
                    'Dibacakan saat berada di dalam atau sekitar Masjidil Haram', MasjidilHaram()),
                _buildDoaCard(context, 'Briefing Clock Tower (Makkah Royal Clock Tower)',
                    'Dibacakan saat mengenalkan landmark di sekitar Masjidil Haram', ClockTower()),
                _buildDoaCard(context, 'Briefing Masjid Jin',
                    'Dibacakan saat ziarah ke Masjid Jin', MasjidJin()),
                _buildDoaCard(context, 'Briefing Masjid Al-Khoif di Mina',
                    'Dibacakan saat ziarah ke Masjid Al-Khoif', MasjidAlKhoif()),
                _buildDoaCard(context, 'Briefing Masjid Tan’im (Miqat Aisyah)',
                    'Dibacakan saat berada di Masjid Tan’im', MasjidTanim()),
                _buildDoaCard(context, 'Briefing Gua Hira di Jabal Nur',
                    'Dibacakan saat ziarah ke Jabal Nur', GuaHira()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoaCard(BuildContext context, String title, String description,
      Widget targetScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => targetScreen,
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/Vector.png',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(description, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
