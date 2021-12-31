import '../../../../presentation/resources/colors.dart';
import 'category_model.dart';

class SubCategory extends CategoryModel {
  SubCategory({
    required CategoryId id,
    required String name,
    required int icon,
    required int color,
  }) : super(id: id, name: name, icon: icon, color: color);

  // ??????  HOUSING

  factory SubCategory.rent() => SubCategory(
        id: CategoryId.auto(),
        name: 'Arriendo',
        icon: 0xe318,
        color: CategoryColors.amber,
      );

  factory SubCategory.morgage() => SubCategory(
        id: CategoryId.auto(),
        name: 'Hipoteca',
        icon: 0xe318,
        color: CategoryColors.amber,
      );

  factory SubCategory.services() => SubCategory(
        id: CategoryId.auto(),
        name: 'Servicios Públicos',
        icon: 0xe318,
        color: CategoryColors.amber,
      );

  // ??????  FOOD

  factory SubCategory.meats() => SubCategory(
        id: CategoryId.auto(),
        name: 'Carnes',
        icon: 0xe532,
        color: CategoryColors.red,
      );
  factory SubCategory.fruitsAndVegetables() => SubCategory(
        id: CategoryId.auto(),
        name: 'Frutas y verduras',
        icon: 0xe532,
        color: CategoryColors.red,
      );
  factory SubCategory.miscellaneous() => SubCategory(
        id: CategoryId.auto(),
        name: 'Miscelaneos',
        icon: 0xe532,
        color: CategoryColors.red,
      );

  // ??????  TRANSPORTATION

  factory SubCategory.publicTransport() => SubCategory(
        id: CategoryId.auto(),
        name: 'Transporte Público',
        icon: 0xf6b0,
        color: CategoryColors.blue_grey,
      );

  factory SubCategory.uber() => SubCategory(
        id: CategoryId.auto(),
        name: 'Uber / Taxi',
        icon: 0xf880,
        color: CategoryColors.blue_grey,
      );

  factory SubCategory.tolls() => SubCategory(
        id: CategoryId.auto(),
        name: 'Peajes',
        icon: 0xf0242,
        color: CategoryColors.blue_grey,
      );

  factory SubCategory.gas() => SubCategory(
        id: CategoryId.auto(),
        name: 'Gasolina',
        icon: 0xf86d,
        color: CategoryColors.blue_grey,
      );

  factory SubCategory.parking() => SubCategory(
        id: CategoryId.auto(),
        name: 'Parqueadero',
        icon: 0xf876,
        color: CategoryColors.blue_grey,
      );

  factory SubCategory.carCredit() => SubCategory(
        id: CategoryId.auto(),
        name: 'Cuota vehicular',
        icon: 0xf618,
        color: CategoryColors.blue_grey,
      );

  factory SubCategory.carAssurance() => SubCategory(
        id: CategoryId.auto(),
        name: 'Seguro vehicular',
        icon: 0xf013e,
        color: CategoryColors.blue_grey,
      );

  factory SubCategory.carTaxes() => SubCategory(
        id: CategoryId.auto(),
        name: 'Impuesto vehicular',
        icon: 0xf021b,
        color: CategoryColors.blue_grey,
      );

  factory SubCategory.maintenance() => SubCategory(
        id: CategoryId.auto(),
        name: 'Mantenimiento',
        icon: 0xf619,
        color: CategoryColors.blue_grey,
      );

  factory SubCategory.carWash() => SubCategory(
        id: CategoryId.auto(),
        name: 'Lavada',
        icon: 0xf867,
        color: CategoryColors.blue_grey,
      );

  // ??????  HEALTH CARE

  factory SubCategory.publicHealth() => SubCategory(
        id: CategoryId.auto(),
        name: 'Eps / Seguridad Social',
        icon: 0xf013e,
        color: CategoryColors.cyan,
      );

  factory SubCategory.healthCarePlan() => SubCategory(
        id: CategoryId.auto(),
        name: 'Medicina prepagada',
        icon: 0xf7df,
        color: CategoryColors.cyan,
      );

  factory SubCategory.medicalAppointments() => SubCategory(
        id: CategoryId.auto(),
        name: 'Citas médicas',
        icon: 0xf7de,
        color: CategoryColors.cyan,
      );

  factory SubCategory.medicines() => SubCategory(
        id: CategoryId.auto(),
        name: 'Medicamentos',
        icon: 0xe3d9,
        color: CategoryColors.cyan,
      );

  // ??????  SERVICES

  factory SubCategory.cellPhonePlan() => SubCategory(
        id: CategoryId.auto(),
        name: 'Plan celular',
        icon: 0xf0078,
        color: CategoryColors.indigo,
      );

  factory SubCategory.homePlan() => SubCategory(
        id: CategoryId.auto(),
        name: 'Plan hogar (Wifi, TV)',
        icon: 0xe6e7,
        color: CategoryColors.indigo,
      );

  factory SubCategory.subscriptions() => SubCategory(
        id: CategoryId.auto(),
        name: 'Suscripciones',
        icon: 0xf860,
        color: CategoryColors.indigo,
      );

  factory SubCategory.otherServices() => SubCategory(
        id: CategoryId.auto(),
        name: 'Otros servicios',
        icon: 0xf7f4,
        color: CategoryColors.indigo,
      );

  // ??????  RECREATION

  factory SubCategory.restaurants() => SubCategory(
        id: CategoryId.auto(),
        name: 'Restaurantes',
        icon: 0xf0112,
        color: CategoryColors.green,
      );

  factory SubCategory.cinema() => SubCategory(
        id: CategoryId.auto(),
        name: 'Cine',
        icon: 0xed7e,
        color: CategoryColors.green,
      );

  factory SubCategory.events() => SubCategory(
        id: CategoryId.auto(),
        name: 'Otros eventos',
        icon: 0xe23e,
        color: CategoryColors.green,
      );

  // ??????  SHOPPING

  factory SubCategory.clothes() => SubCategory(
        id: CategoryId.auto(),
        name: 'Ropa',
        icon: 0xf016f,
        color: CategoryColors.blue,
      );

  factory SubCategory.home() => SubCategory(
        id: CategoryId.auto(),
        name: 'Hogar',
        icon: 0xf0036,
        color: CategoryColors.blue,
      );

  factory SubCategory.electronics() => SubCategory(
        id: CategoryId.auto(),
        name: 'Electronicos',
        icon: 0xf664,
        color: CategoryColors.blue,
      );

  factory SubCategory.healthAndBeauty() => SubCategory(
        id: CategoryId.auto(),
        name: 'Cuidado y belleza',
        icon: 0xf016f,
        color: CategoryColors.blue,
      );

  factory SubCategory.accessories() => SubCategory(
        id: CategoryId.auto(),
        name: 'Accesorios',
        icon: 0xf016f,
        color: CategoryColors.blue,
      );

  factory SubCategory.pets() => SubCategory(
        id: CategoryId.auto(),
        name: 'Para mascotas',
        icon: 0xf0077,
        color: CategoryColors.blue,
      );

  factory SubCategory.gifts() => SubCategory(
        id: CategoryId.auto(),
        name: 'Regalos',
        icon: 0xf61a,
        color: CategoryColors.blue,
      );

  // ??????  SHOPPING

  factory SubCategory.loans() => SubCategory(
        id: CategoryId.auto(),
        name: 'Creditos',
        icon: 0xf58f,
        color: CategoryColors.teal,
      );

  factory SubCategory.creditCards() => SubCategory(
        id: CategoryId.auto(),
        name: 'Tarjetas de crédito',
        icon: 0xe19f,
        color: CategoryColors.teal,
      );

  factory SubCategory.assurances() => SubCategory(
        id: CategoryId.auto(),
        name: 'Seguros',
        icon: 0xf013e,
        color: CategoryColors.teal,
      );

  factory SubCategory.taxes() => SubCategory(
        id: CategoryId.auto(),
        name: 'Impuestos',
        icon: 0xf6ce,
        color: CategoryColors.teal,
      );

  static List<SubCategory> housingSubCategories = [
    SubCategory.rent(),
    SubCategory.morgage(),
    SubCategory.services(),
  ];

  static List<SubCategory> foodSubCategories = [
    SubCategory.meats(),
    SubCategory.fruitsAndVegetables(),
    SubCategory.miscellaneous(),
  ];

  static List<SubCategory> transportationSubCategories = [
    SubCategory.publicTransport(),
    SubCategory.uber(),
    SubCategory.tolls(),
    SubCategory.gas(),
    SubCategory.parking(),
    SubCategory.carCredit(),
    SubCategory.carAssurance(),
    SubCategory.carTaxes(),
    SubCategory.maintenance(),
    SubCategory.carWash(),
  ];

  static List<SubCategory> healthCareSubCategories = [
    SubCategory.publicHealth(),
    SubCategory.healthCarePlan(),
    SubCategory.medicalAppointments(),
    SubCategory.medicines(),
  ];

  static List<SubCategory> servicesSubCategories = [
    SubCategory.cellPhonePlan(),
    SubCategory.homePlan(),
    SubCategory.subscriptions(),
    SubCategory.otherServices(),
  ];

  static List<SubCategory> recreationSubCategories = [
    SubCategory.restaurants(),
    SubCategory.cinema(),
    SubCategory.events(),
  ];

  static List<SubCategory> shoppingSubCategories = [
    SubCategory.clothes(),
    SubCategory.home(),
    SubCategory.electronics(),
    SubCategory.healthAndBeauty(),
    SubCategory.accessories(),
    SubCategory.pets(),
    SubCategory.gifts(),
  ];

  static List<SubCategory> financialSubCategories = [
    SubCategory.loans(),
    SubCategory.creditCards(),
    SubCategory.assurances(),
    SubCategory.taxes(),
  ];
}
