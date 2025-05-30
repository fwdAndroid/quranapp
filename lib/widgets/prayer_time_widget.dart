// lib/widgets/prayer_times.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranapp/model/prayer_location.dart';
import 'package:quranapp/model/prayer_model.dart';
import 'package:quranapp/provider/prayer_time_provider.dart';

import 'package:quranapp/screens/locations/location_selector.dart';

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrayerTimeProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Prayer Times',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D3B2A),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.location_on),
                onPressed: () async {
                  final newLocation = await Navigator.push<PrayerLocation>(
                    context,
                    MaterialPageRoute(builder: (context) => LocationSelector()),
                  );
                  if (newLocation != null) {
                    provider.updateLocation(newLocation);
                  }
                },
              ),
            ],
          ),

          if (provider.currentLocation != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.location_pin, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      provider.currentLocation!.name,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: provider.resetToCurrentLocation,
                    child: const Text('Reset to Current'),
                  ),
                ],
              ),
            ),

          if (provider.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (provider.error != null)
            Text(
              'Error: ${provider.error}',
              style: const TextStyle(color: Colors.red),
            )
          else
            ...provider.prayerTimes.map(
              (prayer) => _buildPrayerTimeRow(prayer),
            ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimeRow(PrayerTime prayer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: prayer.isCurrent
            ? const Color(0xFF1D3B2A).withOpacity(0.1)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (prayer.isCurrent)
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1D3B2A),
                    shape: BoxShape.circle,
                  ),
                ),
              Text(
                prayer.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: prayer.isCurrent
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: prayer.isCurrent
                      ? const Color(0xFF1D3B2A)
                      : Colors.black,
                ),
              ),
            ],
          ),
          Text(
            prayer.time,
            style: TextStyle(
              fontSize: 16,
              fontWeight: prayer.isCurrent
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: prayer.isCurrent ? const Color(0xFF1D3B2A) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
