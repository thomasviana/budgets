import '../../../../presentation/resources/colors.dart';
import 'category_model.dart';

class SubCategory extends CategoryModel {
  CategoryId categoryId;
  SubCategory({
    required CategoryId id,
    required String name,
    required int icon,
    required int color,
    double? balance,
    required this.categoryId,
  }) : super(
          id: id,
          name: name,
          icon: icon,
          color: color,
          balance: balance ?? 0,
        );

  SubCategory copyWith({
    String? name,
    int? icon,
    int? color,
    double? balance,
    CategoryId? categoryId,
  }) {
    return SubCategory(
      id: id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      balance: balance ?? this.balance,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  // ??????  HOUSING

  factory SubCategory.housing() => SubCategory(
        id: CategoryId('housing'),
        name: 'Vivienda (general)',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.rent() => SubCategory(
        id: CategoryId('rent'),
        name: 'Arriendo',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.morgage() => SubCategory(
        id: CategoryId('morgage'),
        name: 'Hipoteca',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.housingServices() => SubCategory(
        id: CategoryId('housingServices'),
        name: 'Servicios Públicos',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.admin() => SubCategory(
        id: CategoryId('admin'),
        name: 'Administración',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.houseMaintenance() => SubCategory(
        id: CategoryId('houseMaintenance'),
        name: 'Mantenimiento',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('housing'),
      );

  factory SubCategory.propertyTaxes() => SubCategory(
        id: CategoryId('propertyTaxes'),
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
        id: CategoryId('generalFood'),
        name: 'Mercado general',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('food'),
      );

  factory SubCategory.meats() => SubCategory(
        id: CategoryId('meats'),
        name: 'Carnes',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('food'),
      );

  factory SubCategory.fruitsAndVegetables() => SubCategory(
        id: CategoryId('fruitsAndVegetables'),
        name: 'Frutas y verduras',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('food'),
      );

  factory SubCategory.miscellaneous() => SubCategory(
        id: CategoryId('miscellaneous'),
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
        id: CategoryId('publicTransport'),
        name: 'Transporte público',
        icon: 0xf6b0,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.uber() => SubCategory(
        id: CategoryId('uber'),
        name: 'Uber / Taxi',
        icon: 0xf880,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.tolls() => SubCategory(
        id: CategoryId('tolls'),
        name: 'Peajes',
        icon: 0xf0242,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.gas() => SubCategory(
        id: CategoryId('gas'),
        name: 'Gasolina',
        icon: 0xf86d,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.parking() => SubCategory(
        id: CategoryId('parking'),
        name: 'Parqueadero',
        icon: 0xf876,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.carCredit() => SubCategory(
        id: CategoryId('carCredit'),
        name: 'Cuota vehicular',
        icon: 0xf618,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.carAssurance() => SubCategory(
        id: CategoryId('carAssurance'),
        name: 'Seguro vehicular',
        icon: 0xf013e,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.carTaxes() => SubCategory(
        id: CategoryId('carTaxes'),
        name: 'Impuesto vehicular',
        icon: 0xf021b,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.maintenance() => SubCategory(
        id: CategoryId('maintenance'),
        name: 'Mantenimiento',
        icon: 0xf619,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  factory SubCategory.carWash() => SubCategory(
        id: CategoryId('carWash'),
        name: 'Lavada',
        icon: 0xf867,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('transportation'),
      );

  // ??????  HEALTH CARE

  factory SubCategory.healthCare() => SubCategory(
        id: CategoryId('healthCare'),
        name: 'Salud (general)',
        icon: 0xf013e,
        color: CategoryColors.cyan,
        categoryId: CategoryId('healthCare'),
      );

  factory SubCategory.publicHealth() => SubCategory(
        id: CategoryId('publicHealth'),
        name: 'Eps / Seguridad Social',
        icon: 0xf013e,
        color: CategoryColors.cyan,
        categoryId: CategoryId('healthCare'),
      );

  factory SubCategory.healthCarePlan() => SubCategory(
        id: CategoryId('healthCarePlan'),
        name: 'Medicina prepagada',
        icon: 0xf7df,
        color: CategoryColors.cyan,
        categoryId: CategoryId('healthCare'),
      );

  factory SubCategory.medicalAppointments() => SubCategory(
        id: CategoryId('medicalAppointments'),
        name: 'Citas médicas',
        icon: 0xf7de,
        color: CategoryColors.cyan,
        categoryId: CategoryId('healthCare'),
      );

  factory SubCategory.medicines() => SubCategory(
        id: CategoryId('medicines'),
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
        id: CategoryId('cellPhonePlan'),
        name: 'Plan celular',
        icon: 0xf0078,
        color: CategoryColors.indigo,
        categoryId: CategoryId('services'),
      );

  factory SubCategory.homePlan() => SubCategory(
        id: CategoryId('homePlan'),
        name: 'Plan hogar (Wifi, TV)',
        icon: 0xe6e7,
        color: CategoryColors.indigo,
        categoryId: CategoryId('services'),
      );

  factory SubCategory.subscriptions() => SubCategory(
        id: CategoryId('subscriptions'),
        name: 'Suscripciones',
        icon: 0xf860,
        color: CategoryColors.indigo,
        categoryId: CategoryId('services'),
      );

  factory SubCategory.otherServices() => SubCategory(
        id: CategoryId('otherServices'),
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
        id: CategoryId('restaurants'),
        name: 'Restaurantes',
        icon: 0xf0112,
        color: CategoryColors.purple,
        categoryId: CategoryId('recreation'),
      );

  factory SubCategory.cinema() => SubCategory(
        id: CategoryId('cinema'),
        name: 'Cine',
        icon: 0xed7e,
        color: CategoryColors.purple,
        categoryId: CategoryId('recreation'),
      );

  factory SubCategory.events() => SubCategory(
        id: CategoryId('events'),
        name: 'Otros eventos',
        icon: 0xe23e,
        color: CategoryColors.purple,
        categoryId: CategoryId('recreation'),
      );

  factory SubCategory.travels() => SubCategory(
        id: CategoryId('travels'),
        name: 'Viajes',
        icon: 0xf54c,
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
        id: CategoryId('clothes'),
        name: 'Ropa',
        icon: 0xf016f,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.home() => SubCategory(
        id: CategoryId('home'),
        name: 'Hogar',
        icon: 0xf0036,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.electronics() => SubCategory(
        id: CategoryId('electronics'),
        name: 'Electronicos',
        icon: 0xf664,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.healthAndBeauty() => SubCategory(
        id: CategoryId('healthAndBeauty'),
        name: 'Cuidado y belleza',
        icon: 0xf016f,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.accessories() => SubCategory(
        id: CategoryId('accessories'),
        name: 'Accesorios',
        icon: 0xf016f,
        color: CategoryColors.blue,
        categoryId: CategoryId('shopping'),
      );

  factory SubCategory.gifts() => SubCategory(
        id: CategoryId('gifts'),
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
        color: CategoryColors.green,
        categoryId: CategoryId('financial'),
      );

  factory SubCategory.loans() => SubCategory(
        id: CategoryId('loans'),
        name: 'Creditos',
        icon: 0xf58f,
        color: CategoryColors.green,
        categoryId: CategoryId('financial'),
      );

  factory SubCategory.creditCards() => SubCategory(
        id: CategoryId('creditCards'),
        name: 'Tarjetas de crédito',
        icon: 0xe19f,
        color: CategoryColors.green,
        categoryId: CategoryId('financial'),
      );

  factory SubCategory.assurances() => SubCategory(
        id: CategoryId('assurances'),
        name: 'Seguros',
        icon: 0xf013e,
        color: CategoryColors.green,
        categoryId: CategoryId('financial'),
      );

  factory SubCategory.taxes() => SubCategory(
        id: CategoryId('taxes'),
        name: 'Impuestos',
        icon: 0xf6ce,
        color: CategoryColors.green,
        categoryId: CategoryId('financial'),
      );

  // ??????  EDUCATION

  factory SubCategory.education() => SubCategory(
        id: CategoryId('education'),
        name: 'Educación (general)',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('education'),
      );

  factory SubCategory.books() => SubCategory(
        id: CategoryId('books'),
        name: 'Libros',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('education'),
      );

  factory SubCategory.courses() => SubCategory(
        id: CategoryId('courses'),
        name: 'Cursos',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('education'),
      );

  factory SubCategory.educationalEvents() => SubCategory(
        id: CategoryId('educationalEvents'),
        name: 'Eventos educativos',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('education'),
      );

  factory SubCategory.university() => SubCategory(
        id: CategoryId('university'),
        name: 'Universidad',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('education'),
      );

  factory SubCategory.educationLoan() => SubCategory(
        id: CategoryId('educationLoan'),
        name: 'Crédito educativo',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('education'),
      );

  // ??????  CONTRIBUTION

  factory SubCategory.contribution() => SubCategory(
        id: CategoryId('contribution'),
        name: 'Contribución (general)',
        icon: 983707,
        color: CategoryColors.pink,
        categoryId: CategoryId('contribution'),
      );

  factory SubCategory.donations() => SubCategory(
        id: CategoryId('donations'),
        name: 'Donaciones',
        icon: 983707,
        color: CategoryColors.pink,
        categoryId: CategoryId('contribution'),
      );

  factory SubCategory.curchTithe() => SubCategory(
        id: CategoryId('curchTithe'),
        name: 'Diezmo',
        icon: 983707,
        color: CategoryColors.pink,
        categoryId: CategoryId('contribution'),
      );

  factory SubCategory.offering() => SubCategory(
        id: CategoryId('offering'),
        name: 'Ofrendas',
        icon: 983707,
        color: CategoryColors.pink,
        categoryId: CategoryId('contribution'),
      );

  factory SubCategory.tips() => SubCategory(
        id: CategoryId('tips'),
        name: 'Propinas',
        icon: 983707,
        color: CategoryColors.pink,
        categoryId: CategoryId('contribution'),
      );

  // ??????  DEPENDENTS

  factory SubCategory.dependents() => SubCategory(
        id: CategoryId('dependents'),
        name: 'Dependientes (general)',
        icon: 58502,
        color: CategoryColors.orange,
        categoryId: CategoryId('dependents'),
      );

  factory SubCategory.familyDepenent() => SubCategory(
        id: CategoryId('familyDepenent'),
        name: 'Familiares dependientes',
        icon: 58502,
        color: CategoryColors.orange,
        categoryId: CategoryId('dependents'),
      );

  factory SubCategory.allowance() => SubCategory(
        id: CategoryId('allowance'),
        name: 'Mesadas',
        icon: 63036,
        color: CategoryColors.orange,
        categoryId: CategoryId('dependents'),
      );

  factory SubCategory.school() => SubCategory(
        id: CategoryId('school'),
        name: 'Colegio',
        icon: 983342,
        color: CategoryColors.orange,
        categoryId: CategoryId('dependents'),
      );

  factory SubCategory.pets() => SubCategory(
        id: CategoryId('pets'),
        name: 'Mascotas',
        icon: 983159,
        color: CategoryColors.orange,
        categoryId: CategoryId('dependents'),
      );

  // ??????  INVESTMENTS

  factory SubCategory.investments() => SubCategory(
        id: CategoryId('investments'),
        name: 'Inversiones (general)',
        icon: 63513,
        color: CategoryColors.teal,
        categoryId: CategoryId('investments'),
      );

  factory SubCategory.realEstate() => SubCategory(
        id: CategoryId('realEstate'),
        name: 'Propiedad raiz',
        icon: 983697,
        color: CategoryColors.teal,
        categoryId: CategoryId('investments'),
      );

  factory SubCategory.stocks() => SubCategory(
        id: CategoryId('stocks'),
        name: 'Mercado de valores',
        icon: 63513,
        color: CategoryColors.teal,
        categoryId: CategoryId('investments'),
      );

  factory SubCategory.shares() => SubCategory(
        id: CategoryId('shares'),
        name: 'Acciones',
        icon: 63513,
        color: CategoryColors.teal,
        categoryId: CategoryId('investments'),
      );

  factory SubCategory.financialInvestments() => SubCategory(
        id: CategoryId('financialInvestments'),
        name: 'Inversiones financieras',
        icon: 63513,
        color: CategoryColors.teal,
        categoryId: CategoryId('investments'),
      );

  factory SubCategory.nfts() => SubCategory(
        id: CategoryId('nfts'),
        name: 'NFTs',
        icon: 62849,
        color: CategoryColors.teal,
        categoryId: CategoryId('investments'),
      );

  factory SubCategory.crypto() => SubCategory(
        id: CategoryId('crypto'),
        name: 'Criptomonedas',
        icon: 59060,
        color: CategoryColors.teal,
        categoryId: CategoryId('investments'),
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
    ...housingSubCategories,
    ...foodSubCategories,
    ...transportationSubCategories,
    ...healthCareSubCategories,
    ...servicesSubCategories,
    ...recreationSubCategories,
    ...shoppingSubCategories,
    ...financialSubCategories,
    ...educationSubCategories,
    ...contributionSubCategories,
    ...dependentsSubCategories,
    ...investmentsSubCategories,
    ...incomeSubCategories
  ];

  static List<SubCategory> housingSubCategories = [
    SubCategory.housing(),
    SubCategory.rent(),
    SubCategory.morgage(),
    SubCategory.housingServices(),
    SubCategory.admin(),
    SubCategory.houseMaintenance(),
    SubCategory.propertyTaxes(),
  ];

  static List<SubCategory> foodSubCategories = [
    SubCategory.food(),
    SubCategory.generalFood(),
    SubCategory.meats(),
    SubCategory.fruitsAndVegetables(),
    SubCategory.miscellaneous(),
  ];

  static List<SubCategory> transportationSubCategories = [
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
  ];

  static List<SubCategory> healthCareSubCategories = [
    SubCategory.healthCare(),
    SubCategory.publicHealth(),
    SubCategory.healthCarePlan(),
    SubCategory.medicalAppointments(),
    SubCategory.medicines(),
  ];

  static List<SubCategory> servicesSubCategories = [
    SubCategory.services(),
    SubCategory.cellPhonePlan(),
    SubCategory.homePlan(),
    SubCategory.subscriptions(),
    SubCategory.otherServices(),
  ];

  static List<SubCategory> recreationSubCategories = [
    SubCategory.recreation(),
    SubCategory.restaurants(),
    SubCategory.cinema(),
    SubCategory.events(),
    SubCategory.travels(),
  ];

  static List<SubCategory> shoppingSubCategories = [
    SubCategory.shopping(),
    SubCategory.clothes(),
    SubCategory.home(),
    SubCategory.electronics(),
    SubCategory.healthAndBeauty(),
    SubCategory.accessories(),
    SubCategory.gifts(),
  ];

  static List<SubCategory> financialSubCategories = [
    SubCategory.financial(),
    SubCategory.loans(),
    SubCategory.creditCards(),
    SubCategory.assurances(),
    SubCategory.taxes(),
  ];

  static List<SubCategory> educationSubCategories = [
    SubCategory.education(),
    SubCategory.books(),
    SubCategory.courses(),
    SubCategory.educationalEvents(),
    SubCategory.university(),
    SubCategory.educationLoan(),
  ];

  static List<SubCategory> contributionSubCategories = [
    SubCategory.contribution(),
    SubCategory.donations(),
    SubCategory.curchTithe(),
    SubCategory.offering(),
    SubCategory.tips(),
  ];

  static List<SubCategory> dependentsSubCategories = [
    SubCategory.dependents(),
    SubCategory.familyDepenent(),
    SubCategory.allowance(),
    SubCategory.school(),
    SubCategory.pets(),
  ];

  static List<SubCategory> investmentsSubCategories = [
    SubCategory.investments(),
    SubCategory.realEstate(),
    SubCategory.stocks(),
    SubCategory.shares(),
    SubCategory.financialInvestments(),
    SubCategory.nfts(),
    SubCategory.crypto(),
  ];

  static List<SubCategory> incomeSubCategories = [
    SubCategory.salary(),
    SubCategory.honorarium(),
    SubCategory.rental(),
    SubCategory.business(),
    SubCategory.dividends(),
    SubCategory.pension(),
    SubCategory.occasional(),
    SubCategory.gift(),
  ];
}
