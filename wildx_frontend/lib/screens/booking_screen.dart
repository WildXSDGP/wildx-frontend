import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/accommodation.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _checkIn;
  DateTime? _checkOut;
  int _guests = 1;

  int get _nights {
    if (_checkIn == null || _checkOut == null) return 0;
    return _checkOut!.difference(_checkIn!).inDays;
  }

  double _totalPrice(double pricePerNight) => pricePerNight * _nights;

  Future<void> _pickDate({
    required bool isCheckIn,
    required DateTime? other,
  }) async {
    final now = DateTime.now();
    final firstDate = isCheckIn
        ? DateTime(now.year, now.month, now.day)
        : (other ?? now).add(const Duration(days: 1));

    final picked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: kGreen,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black87,
          ),
        ),
        child: child!,
      ),
    );

    if (picked == null) return;
    setState(() {
      if (isCheckIn) {
        _checkIn = picked;
        if (_checkOut != null && !_checkOut!.isAfter(picked)) {
          _checkOut = null;
        }
      } else {
        _checkOut = picked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final accommodation =
        ModalRoute.of(context)!.settings.arguments as Accommodation;

    return Scaffold(
      backgroundColor: kGreenSoft,
      appBar: AppBar(
        backgroundColor: kGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'Book Accommodation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AccommodationHeader(accommodation: accommodation),
                  const SizedBox(height: 20),
                  _SectionCard(
                    title: 'Select Dates',
                    icon: Icons.date_range_outlined,
                    child: Column(
                      children: [
                        _DateField(
                          label: 'Check-in',
                          icon: Icons.login_rounded,
                          date: _checkIn,
                          onTap: () =>
                              _pickDate(isCheckIn: true, other: _checkOut),
                        ),
                        const SizedBox(height: 12),
                        _DateField(
                          label: 'Check-out',
                          icon: Icons.logout_rounded,
                          date: _checkOut,
                          onTap: () =>
                              _pickDate(isCheckIn: false, other: _checkIn),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'Guests',
                    icon: Icons.people_outline_rounded,
                    child: _GuestCounter(
                      value: _guests,
                      onDecrement:
                          _guests > 1 ? () => setState(() => _guests--) : null,
                      onIncrement: _guests < 20
                          ? () => setState(() => _guests++)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _PriceSummary(
                    pricePerNight: accommodation.pricePerNight,
                    nights: _nights,
                    guests: _guests,
                    total: _totalPrice(accommodation.pricePerNight),
                  ),
                ],
              ),
            ),
          ),
          _BookingFooter(
            isEnabled: _nights > 0,
            total: _totalPrice(accommodation.pricePerNight),
            onConfirm: () {
              // TODO: Submit booking to backend
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking confirmed! (placeholder)'),
                  backgroundColor: kGreen,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Accommodation header card ───────────────────────────────────────────────

class _AccommodationHeader extends StatelessWidget {
  final Accommodation accommodation;

  const _AccommodationHeader({required this.accommodation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kGreen.withValues(alpha: 0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              accommodation.imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, _) => Container(
                height: 160,
                color: kGreenSoft,
                child: const Icon(Icons.image_not_supported,
                    size: 48, color: kGreen),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  accommodation.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: kGreenLight),
                    const SizedBox(width: 4),
                    Text(
                      accommodation.parkName,
                      style: const TextStyle(
                          fontSize: 13, color: Colors.grey),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text(
                      '${accommodation.rating}',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'LKR ${accommodation.pricePerNight.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kGreen,
                      ),
                    ),
                    const Text(
                      ' / night',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Generic section card ────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kGreen.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: kGreen),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ── Date selection field ────────────────────────────────────────────────────

class _DateField extends StatelessWidget {
  final String label;
  final IconData icon;
  final DateTime? date;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.icon,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasDate = date != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: kGreenSoft,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasDate ? kGreen : kGreenLight.withValues(alpha: 0.4),
            width: hasDate ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: kGreen),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  hasDate
                      ? '${date!.day.toString().padLeft(2, '0')} / '
                          '${date!.month.toString().padLeft(2, '0')} / '
                          '${date!.year}'
                      : 'Select date',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: hasDate ? Colors.black87 : Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: kGreen.withValues(alpha: 0.6),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Guest counter ───────────────────────────────────────────────────────────

class _GuestCounter extends StatelessWidget {
  final int value;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  const _GuestCounter({
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.person_outline_rounded, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          value == 1 ? '1 Guest' : '$value Guests',
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const Spacer(),
        _CounterButton(
          icon: Icons.remove,
          onTap: onDecrement,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$value',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kGreen,
            ),
          ),
        ),
        _CounterButton(
          icon: Icons.add,
          onTap: onIncrement,
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CounterButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled ? kGreen : kGreenSoft,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}

// ── Price summary card ──────────────────────────────────────────────────────

class _PriceSummary extends StatelessWidget {
  final double pricePerNight;
  final int nights;
  final int guests;
  final double total;

  const _PriceSummary({
    required this.pricePerNight,
    required this.nights,
    required this.guests,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kGreen.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.receipt_long_outlined, size: 18, color: kGreen),
              SizedBox(width: 8),
              Text(
                'Price Summary',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _PriceRow(
            label:
                'LKR ${pricePerNight.toStringAsFixed(0)} × $nights ${nights == 1 ? 'night' : 'nights'}',
            value: nights > 0
                ? 'LKR ${(pricePerNight * nights).toStringAsFixed(0)}'
                : '—',
          ),
          const SizedBox(height: 8),
          _PriceRow(
            label: '$guests ${guests == 1 ? 'guest' : 'guests'}',
            value: '',
            isSubtle: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: kGreenSoft),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                nights > 0 ? 'LKR ${total.toStringAsFixed(0)}' : '—',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kGreen,
                ),
              ),
            ],
          ),
          if (nights == 0) ...[
            const SizedBox(height: 8),
            const Text(
              'Select check-in and check-out dates to see the total price.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isSubtle;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isSubtle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isSubtle ? Colors.grey : Colors.black87,
          ),
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
      ],
    );
  }
}

// ── Sticky booking footer ───────────────────────────────────────────────────

class _BookingFooter extends StatelessWidget {
  final bool isEnabled;
  final double total;
  final VoidCallback onConfirm;

  const _BookingFooter({
    required this.isEnabled,
    required this.total,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEnabled
                        ? 'LKR ${total.toStringAsFixed(0)}'
                        : 'Select dates',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isEnabled ? kGreen : Colors.grey,
                    ),
                  ),
                  const Text(
                    'total',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEnabled ? kGreen : Colors.grey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: isEnabled ? 2 : 0,
                  ),
                  onPressed: isEnabled ? onConfirm : null,
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
