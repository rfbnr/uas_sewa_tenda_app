import 'package:equatable/equatable.dart';

final List<TendaItemModel> tendaItems = [
  TendaItemModel(
    id: 1,
    name: 'Eiger',
    description: 'Max 3 Orang',
    price: 50000,
  ),
  TendaItemModel(
    id: 2,
    name: 'Consina',
    description: 'Max 5 Orang',
    price: 100000,
  ),
  TendaItemModel(
    id: 3,
    name: 'Arei',
    description: 'Max 4 Orang',
    price: 70000,
  ),
  TendaItemModel(
    id: 4,
    name: 'Deuter',
    description: 'Max 2 Orang',
    price: 50000,
  ),
  TendaItemModel(
    id: 5,
    name: 'Osprey',
    description: 'Max 3 Orang',
    price: 60000,
  ),
  TendaItemModel(
    id: 6,
    name: 'Big Mountain',
    description: 'Max 5 orang',
    price: 160000,
  ),
  TendaItemModel(
    id: 7,
    name: 'The North Face',
    description: 'Max 4 Orang',
    price: 120000,
  ),
  TendaItemModel(
    id: 8,
    name: 'Eiger',
    description: 'Max 3 Orang',
    price: 50000,
  ),
  TendaItemModel(
    id: 9,
    name: 'Consina',
    description: 'Max 5 Orang',
    price: 100000,
  ),
  TendaItemModel(
    id: 10,
    name: 'Arei',
    description: 'Max 4 Orang',
    price: 70000,
  ),
];

final List<PaymentMethodItemModel> paymentMethodItems = [
  PaymentMethodItemModel(
    id: '1',
    name: 'Mandiri',
    number: 00448295774,
  ),
  PaymentMethodItemModel(
    id: '2',
    name: 'BCA',
    number: 00448295774,
  ),
  PaymentMethodItemModel(
    id: '3',
    name: 'DANA',
    number: 08123456789,
  ),
  PaymentMethodItemModel(
    id: '4',
    name: 'GOPAY',
    number: 08123456789,
  ),
  PaymentMethodItemModel(
    id: '5',
    name: 'OVO',
    number: 08123456789,
  ),
];

class PaymentMethodItemModel extends Equatable {
  final String id;
  final String name;
  final num number;

  const PaymentMethodItemModel({
    required this.id,
    required this.name,
    required this.number,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        number,
      ];
}

class TendaItemModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final int price;

  const TendaItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        price,
      ];
}
