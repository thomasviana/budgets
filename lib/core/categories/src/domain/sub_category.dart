import '../../../../presentation/resources/colors.dart';
import 'category_model.dart';

class SubCategory extends CategoryModel {
  CategoryId categoryId;
  SubCategory({
    required CategoryId id,
    required String name,
    required int icon,
    required int color,
    double? amount,
    required this.categoryId,
  }) : super(
          id: id,
          name: name,
          icon: icon,
          color: color,
          amount: amount ?? 0,
        );

  // ??????  HOUSING

  factory SubCategory.housing() => SubCategory(
        id: CategoryId('housing'),
        name: 'Vivienda (general)',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.rent() => SubCategory(
        id: CategoryId.auto(),
        name: 'Arriendo',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.morgage() => SubCategory(
        id: CategoryId.auto(),
        name: 'Hipoteca',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.housingServices() => SubCategory(
        id: CategoryId.auto(),
        name: 'Servicios Públicos',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.admin() => SubCategory(
        id: CategoryId.auto(),
        name: 'Administración',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.houseMaintenance() => SubCategory(
        id: CategoryId.auto(),
        name: 'Mantenimiento',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.propertyTaxes() => SubCategory(
        id: CategoryId.auto(),
        name: 'Impuesto predial',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  // ??????  FOOD

  factory SubCategory.food() => SubCategory(
        id: CategoryId('food'),
        name: 'Alimentación (general)',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('food'),
      );

  factory SubCategory.generalFood() => SubCategory(
        id: CategoryId.auto(),
        name: 'Mercado general',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('food'),
      );

  factory SubCategory.meats() => SubCategory(
        id: CategoryId.auto(),
        name: 'Carnes',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('food'),
      );

  factory SubCategory.fruitsAndVegetables() => SubCategory(
        id: CategoryId.auto(),
        name: 'Frutas y verduras',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('food'),
      );

  factory SubCategory.miscellaneous() => SubCategory(
        id: CategoryId.auto(),
        name: 'Otros',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('food'),
      );

  // ??????  TRANSPORTATION

  factory SubCategory.transportation() => SubCategory(
        id: CategoryId('transportation'),
        name: 'Transporte (general)',
        icon: 0xf6b0,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.publicTransport() => SubCategory(
        id: CategoryId.auto(),
        name: 'Transporte público',
        icon: 0xf6b0,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.uber() => SubCategory(
        id: CategoryId.auto(),
        name: 'Uber / Taxi',
        icon: 0xf880,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.tolls() => SubCategory(
        id: CategoryId.auto(),
        name: 'Peajes',
        icon: 0xf0242,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.gas() => SubCategory(
        id: CategoryId.auto(),
        name: 'Gasolina',
        icon: 0xf86d,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.parking() => SubCategory(
        id: CategoryId.auto(),
        name: 'Parqueadero',
        icon: 0xf876,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.carCredit() => SubCategory(
        id: CategoryId.auto(),
        name: 'Cuota vehicular',
        icon: 0xf618,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.carAssurance() => SubCategory(
        id: CategoryId.auto(),
        name: 'Seguro vehicular',
        icon: 0xf013e,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.carTaxes() => SubCategory(
        id: CategoryId.auto(),
        name: 'Impuesto vehicular',
        icon: 0xf021b,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.maintenance() => SubCategory(
        id: CategoryId.auto(),
        name: 'Mantenimiento',
        icon: 0xf619,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.carWash() => SubCategory(
        id: CategoryId.auto(),
        name: 'Lavada',
        icon: 0xf867,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  // ??????  HEALTH CARE

  factory SubCategory.healthCare() => SubCategory(
        id: CategoryId('healthCare'),
        name: 'Eps / Seguridad Social',
        icon: 0xf013e,
        color: CategoryColors.cyan,
        categoryId: CategoryId('healthCare'),
      );

  factory SubCategory.publicHealth() => SubCategory(
        id: CategoryId.auto(),
        name: 'Eps / Seguridad Social',
        icon: 0xf013e,
        color: CategoryColors.cyan,
        categoryId: CategoryId('healthCare'),
      );

  factory SubCategory.healthCarePlan() => SubCategory(
        id: CategoryId.auto(),
        name: 'Medicina prepagada',
        icon: 0xf7df,
        color: CategoryColors.cyan,
        categoryId: CategoryId('healthCare'),
      );

  factory SubCategory.medicalAppointments() => SubCategory(
        id: CategoryId.auto(),
        name: 'Citas médicas',
        icon: 0xf7de,
        color: CategoryColors.cyan,
        categoryId: CategoryId('healthCare'),
      );

  factory SubCategory.medicines() => SubCategory(
        id: CategoryId.auto(),
        name: 'Medicamentos',
        icon: 0xe3d9,
        color: CategoryColors.cyan,
        categoryId: CategoryId('healthCare'),
      );

  // ??????  SERVICES

  factory SubCategory.services() => SubCategory(
        id: CategoryId('services'),
        name: 'Servicios (general)',
        icon: 0xf0078,
        color: CategoryColors.indigo,
        categoryId: CategoryId('services'),
      );

  factory SubCategory.cellPhonePlan() => SubCategory(
        id: CategoryId.auto(),
        name: 'Plan celular',
        icon: 0xf0078,
        color: CategoryColors.indigo,
        categoryId: CategoryId('services'),
      );

  factory SubCategory.homePlan() => SubCategory(
        id: CategoryId.auto(),
        name: 'Plan hogar (Wifi, TV)',
        icon: 0xe6e7,
        color: CategoryColors.indigo,
        categoryId: CategoryId('services'),
      );

  factory SubCategory.subscriptions() => SubCategory(
        id: CategoryId.auto(),
        name: 'Suscripciones',
        icon: 0xf860,
        color: CategoryColors.indigo,
        categoryId: CategoryId('services'),
      );

  factory SubCategory.otherServices() => SubCategory(
        id: CategoryId.auto(),
        name: 'Otros servicios',
        icon: 0xf7f4,
        color: CategoryColors.indigo,
        categoryId: CategoryId('services'),
      );

  // ??????  RECREATION

  factory SubCategory.recreation() => SubCategory(
        id: CategoryId('recreation'),
        name: 'Diversión (general)',
        icon: 0xf0112,
        color: CategoryColors.purple,
        categoryId: CategoryId('recreation'),
      );

  factory SubCategory.restaurants() => SubCategory(
        id: CategoryId.auto(),
        name: 'Restaurantes',
        icon: 0xf0112,
        color: CategoryColors.purple,
        categoryId: CategoryId('recreation'),
      );

  factory SubCategory.cinema() => SubCategory(
        id: CategoryId.auto(),
        name: 'Cine',
        icon: 0xed7e,
        color: CategoryColors.purple,
        categoryId: CategoryId('recreation'),
      );

  factory SubCategory.events() => SubCategory(
        id: CategoryId.auto(),
        name: 'Otros eventos',
        icon: 0xe23e,
        color: CategoryColors.purple,
        categoryId: CategoryId('recreation'),
      );

  // ??????  SHOPPING

  factory SubCategory.shopping() => SubCategory(
        id: CategoryId('shopping'),
        name: 'Compras (general)',
        icon: 0xf016f,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.clothes() => SubCategory(
        id: CategoryId.auto(),
        name: 'Ropa',
        icon: 0xf016f,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.home() => SubCategory(
        id: CategoryId.auto(),
        name: 'Hogar',
        icon: 0xf0036,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.electronics() => SubCategory(
        id: CategoryId.auto(),
        name: 'Electronicos',
        icon: 0xf664,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.healthAndBeauty() => SubCategory(
        id: CategoryId.auto(),
        name: 'Cuidado y belleza',
        icon: 0xf016f,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.accessories() => SubCategory(
        id: CategoryId.auto(),
        name: 'Accesorios',
        icon: 0xf016f,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.pets() => SubCategory(
        id: CategoryId.auto(),
        name: 'Para mascotas',
        icon: 0xf0077,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.gifts() => SubCategory(
        id: CategoryId.auto(),
        name: 'Regalos',
        icon: 0xf61a,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  // ??????  FINANCIAL

  factory SubCategory.financial() => SubCategory(
        id: CategoryId('financial'),
        name: 'Gastos financieros (general)',
        icon: 0xf58f,
        color: CategoryColors.teal,
        categoryId: CategoryId('financial'),
      );

  factory SubCategory.loans() => SubCategory(
        id: CategoryId.auto(),
        name: 'Creditos',
        icon: 0xf58f,
        color: CategoryColors.teal,
        categoryId: CategoryId('financial'),
      );

  factory SubCategory.creditCards() => SubCategory(
        id: CategoryId.auto(),
        name: 'Tarjetas de crédito',
        icon: 0xe19f,
        color: CategoryColors.teal,
        categoryId: CategoryId('financial'),
      );

  factory SubCategory.assurances() => SubCategory(
        id: CategoryId.auto(),
        name: 'Seguros',
        icon: 0xf013e,
        color: CategoryColors.teal,
        categoryId: CategoryId('financial'),
      );

  factory SubCategory.taxes() => SubCategory(
        id: CategoryId.auto(),
        name: 'Impuestos',
        icon: 0xf6ce,
        color: CategoryColors.teal,
        categoryId: CategoryId('financial'),
      );

  // !!!!!!!  SALARY

  factory SubCategory.salary() => SubCategory(
        id: CategoryId('salary'),
        name: 'Salario (general)',
        icon: 0xf58f,
        color: CategoryColors.amber,
        categoryId: CategoryId('salary'),
      );

  // !!!!!!!  HONORARIUM

  factory SubCategory.honorarium() => SubCategory(
        id: CategoryId('honorarium'),
        name: 'Honorarios (general)',
        icon: 0xf58f,
        color: CategoryColors.red,
        categoryId: CategoryId('honorarium'),
      );

  // !!!!!!!  RENT

  factory SubCategory.rental() => SubCategory(
        id: CategoryId('rental'),
        name: 'Rentas de capital (general)',
        icon: 0xf58f,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('rental'),
      );

  // !!!!!!!  BUSINESS

  factory SubCategory.business() => SubCategory(
        id: CategoryId('business'),
        name: 'Negocios (general)',
        icon: 0xf58f,
        color: CategoryColors.cyan,
        categoryId: CategoryId('business'),
      );

  // !!!!!!!  DIVIDENDS

  factory SubCategory.dividends() => SubCategory(
        id: CategoryId('dividends'),
        name: 'Dividendos (general)',
        icon: 0xf58f,
        color: CategoryColors.indigo,
        categoryId: CategoryId('dividends'),
      );

  // !!!!!!!  PENSIONS

  factory SubCategory.pension() => SubCategory(
        id: CategoryId('pension'),
        name: 'Pensión (general)',
        icon: 0xf58f,
        color: CategoryColors.purple,
        categoryId: CategoryId('pension'),
      );

  // !!!!!!!  OCASSIONAL

  factory SubCategory.occasional() => SubCategory(
        id: CategoryId('occasional'),
        name: 'Ocasional (general)',
        icon: 0xf58f,
        color: CategoryColors.blue,
        categoryId: CategoryId('occasional'),
      );

  // !!!!!!!  GIFT

  factory SubCategory.gift() => SubCategory(
        id: CategoryId('gift'),
        name: 'Regalos (general)',
        icon: 0xf58f,
        color: CategoryColors.teal,
        categoryId: CategoryId('gift'),
      );

  static List<SubCategory> allSubCategories = [
    SubCategory.housing(),
    SubCategory.rent(),
    SubCategory.morgage(),
    SubCategory.housingServices(),
    SubCategory.admin(),
    SubCategory.houseMaintenance(),
    SubCategory.propertyTaxes(),
    SubCategory.food(),
    SubCategory.generalFood(),
    SubCategory.meats(),
    SubCategory.fruitsAndVegetables(),
    SubCategory.miscellaneous(),
    SubCategory.transportation(),
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
    SubCategory.healthCare(),
    SubCategory.publicHealth(),
    SubCategory.healthCarePlan(),
    SubCategory.medicalAppointments(),
    SubCategory.medicines(),
    SubCategory.services(),
    SubCategory.cellPhonePlan(),
    SubCategory.homePlan(),
    SubCategory.subscriptions(),
    SubCategory.otherServices(),
    SubCategory.recreation(),
    SubCategory.restaurants(),
    SubCategory.cinema(),
    SubCategory.events(),
    SubCategory.shopping(),
    SubCategory.clothes(),
    SubCategory.home(),
    SubCategory.electronics(),
    SubCategory.healthAndBeauty(),
    SubCategory.accessories(),
    SubCategory.pets(),
    SubCategory.gifts(),
    SubCategory.financial(),
    SubCategory.loans(),
    SubCategory.creditCards(),
    SubCategory.assurances(),
    SubCategory.taxes(),
    SubCategory.salary(),
    SubCategory.honorarium(),
    SubCategory.rental(),
    SubCategory.dividends(),
    SubCategory.pension(),
  ];

  static List<SubCategory> housingSubCategories = [
    SubCategory.rent(),
    SubCategory.morgage(),
    SubCategory.housingServices(),
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
