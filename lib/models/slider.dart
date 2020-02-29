import 'package:flutter/material.dart';

class Slider {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;

  Slider({
    @required this.sliderImageUrl,
    @required this.sliderHeading,
    @required this.sliderSubHeading
  });
}

final sliderArrayList = [
  Slider(
    sliderImageUrl: 'assets/images/intro/illustration1.png',
    sliderHeading: 'Lihat jadwal pelajaran\ndi genggamanmu',
    sliderSubHeading: 'Lihat jadwal harian dimana saja dan kapan saja, Bantu harimu semakin produktif'
  ),
  Slider(
    sliderImageUrl: 'assets/images/intro/illustration4.png',
    sliderHeading: 'Sharing Bersama teman,\nhanya semudah klik',
    sliderSubHeading: 'Berbagi bersama teman itu mudah,\nmenyenangkan, dan tanpa batas'
  ),
  Slider(
    sliderImageUrl: 'assets/images/intro/illustration3.png',
    sliderHeading: 'Notifikasi pengingat\nuntuk tugas deadlinemu',
    sliderSubHeading: 'Katakan tidak pada telat! Pengingat ini ada untuk setiap deadline tugasmu'
  ),
];
