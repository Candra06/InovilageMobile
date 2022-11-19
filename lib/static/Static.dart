import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/static/themes.dart';

List<Map<String, dynamic>> features = [
  {
    "id": 1,
    "label": "Kirim Sampah",
    "icon": Icon(
      Icons.restore_from_trash,
      color: secondaryColor,
      size: 50,
    ),
    "url": Navigation.deliveryFormScreen,
  },
  {
    "id": 2,
    "label": "Riwayat Transaksi",
    "icon": Icon(
      Icons.history,
      color: secondaryColor,
      size: 50,
    ),
    "url": Navigation.deliveryFormScreen,
  },
  {
    "id": 3,
    "label": "Donasi Sampah",
    "icon": Icon(
      Icons.price_change,
      color: secondaryColor,
      size: 50,
    ),
    "url": Navigation.deliveryFormScreen,
  },
  {
    "id": 4,
    "label": "List Sampah",
    "icon": Icon(
      Icons.list,
      color: secondaryColor,
      size: 50,
    ),
    "url": Navigation.listSampahScreen,
  }
];

List<Map<String, dynamic>> jenisSampah = [
  {
    "id": 1,
    "label": "Organik",
  },
  {
    "id": 1,
    "label": "Plastik",
  },
  {
    "id": 1,
    "label": "Ori",
  },
  {
    "id": 1,
    "label": "Iyeh",
  },
];

List<Map<String, dynamic>> featuresAdmin = [
  {
    "id": 1,
    "label": "Edit User",
    "icon": Icon(
      Icons.people,
      color: secondaryColor,
      size: 50,
    ),
    "url": Navigation.listUsersScreen,
    "arguments": "Pengguna",
  },
  {
    "id": 2,
    "label": "Edit Kurir",
    "icon": Icon(
      Icons.motorcycle,
      color: secondaryColor,
      size: 50,
    ),
    "url": Navigation.listUsersScreen,
    "arguments": "Kurir",
  },
  {
    "id": 3,
    "label": "Bank Sampah",
    "icon": Icon(
      Icons.restore_from_trash,
      color: secondaryColor,
      size: 50,
    ),
    "url": Navigation.deliveryFormScreen,
    "arguments": "Pengiriman",
  },
  {
    "id": 4,
    "label": "Edit Artikel",
    "icon": Icon(
      Icons.list_alt,
      color: secondaryColor,
      size: 50,
    ),
    "url": Navigation.listArtikelScreen,
    "arguments": "Artikel",
  }
];

List pengiriman = [
  {
    "created_at": "2022-11-09T15:10:27.000000Z",
    "jenis_sampah": "Organik dan Anorganik",
    "status": "Proses",
    "id": 1,
    "kode_transaksi": "TP00109112022",
    "kurir": "Alex",
    "alamat": "Jl. Kenanga RT/RW 42/8 Kesilir",
    "tanggal": "2022-11-09 15:10:27",
  },
  {
    "created_at": "2022-11-09T15:10:27.000000Z",
    "jenis_sampah": "Organik dan Anorganik",
    "status": "Proses",
    "id": 1,
    "kode_transaksi": "TP00209112022",
    "kurir": "Jono",
    "alamat": "Jl. Kenanga RT/RW 42/8 Kesilir",
    "tanggal": "2022-11-09 15:10:27",
  },
];
