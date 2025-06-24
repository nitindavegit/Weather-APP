import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature
    });

  @override
  Widget build(BuildContext context) {
    return Card(
                      elevation: 6,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)   
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            // time
                            Text(time,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            // Icon 
                            Icon(icon,
                              size: 40,
                            ),
                            const SizedBox(height: 10),
                            // Temperature
                            Text(temperature,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
  }
}