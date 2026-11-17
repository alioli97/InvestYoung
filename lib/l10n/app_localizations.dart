import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ca.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('es'),
  ];

  /// Application name.
  ///
  /// In es, this message translates to:
  /// **'Invertir siendo Joven'**
  String get appTitle;

  /// Bottom navigation label for the Home tab.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// Bottom navigation label for the Goals tab.
  ///
  /// In es, this message translates to:
  /// **'Objetivos'**
  String get navGoals;

  /// Bottom navigation label for the Investments tab.
  ///
  /// In es, this message translates to:
  /// **'Inversiones'**
  String get navInvestments;

  /// Bottom navigation label for the Learn tab.
  ///
  /// In es, this message translates to:
  /// **'Aprender'**
  String get navLearn;

  /// Bottom navigation label for the Profile tab.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// Home screen app bar title.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get dashboardTitle;

  /// Goals screen app bar title.
  ///
  /// In es, this message translates to:
  /// **'Objetivos'**
  String get goalsTitle;

  /// Investments screen app bar title.
  ///
  /// In es, this message translates to:
  /// **'Inversiones'**
  String get investmentsTitle;

  /// Learn screen app bar title.
  ///
  /// In es, this message translates to:
  /// **'Aprender'**
  String get learnTitle;

  /// Profile screen app bar title.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profileTitle;

  /// Onboarding welcome title.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido/a'**
  String get onboardingWelcomeTitle;

  /// Onboarding welcome subtitle.
  ///
  /// In es, this message translates to:
  /// **'Organiza tus finanzas y empieza a invertir con cabeza.'**
  String get onboardingWelcomeBody;

  /// Placeholder text for sections not implemented yet.
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get commonComingSoon;

  /// Mandatory disclaimer shown with every return simulation.
  ///
  /// In es, this message translates to:
  /// **'Simulación orientativa, los resultados no están garantizados'**
  String get commonSimulationDisclaimer;

  /// Button to go to the previous step.
  ///
  /// In es, this message translates to:
  /// **'Atrás'**
  String get commonBack;

  /// Button to go to the next step.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get commonContinue;

  /// Yes option.
  ///
  /// In es, this message translates to:
  /// **'Sí'**
  String get commonYes;

  /// No option.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get commonNo;

  /// Helper text for optional fields.
  ///
  /// In es, this message translates to:
  /// **'Opcional'**
  String get commonOptional;

  /// Validation error for money fields.
  ///
  /// In es, this message translates to:
  /// **'Introduce un importe válido'**
  String get commonInvalidAmount;

  /// Legal notice title.
  ///
  /// In es, this message translates to:
  /// **'Aviso legal'**
  String get commonLegalNoticeTitle;

  /// Legal notice body (educational app, no financial advice, CNMV).
  ///
  /// In es, this message translates to:
  /// **'Invertir siendo Joven es una aplicación educativa. La información, los perfiles, los rangos y las simulaciones que muestra son orientativos y no constituyen asesoramiento financiero ni una recomendación personalizada de inversión, actividad regulada en España por la Comisión Nacional del Mercado de Valores (CNMV).\n\nInvertir conlleva riesgos, incluida la pérdida del capital invertido, y las rentabilidades pasadas no garantizan rentabilidades futuras. Antes de tomar decisiones de inversión, infórmate bien y, si lo necesitas, consulta con un profesional autorizado.\n\nTus datos se guardan solo en tu dispositivo.'**
  String get commonLegalNoticeBody;

  /// Progress label in onboarding.
  ///
  /// In es, this message translates to:
  /// **'Paso {current} de {total}'**
  String onboardingStepCounter(int current, int total);

  /// Language step title.
  ///
  /// In es, this message translates to:
  /// **'Elige tu idioma'**
  String get onboardingLanguageTitle;

  /// Spanish language option.
  ///
  /// In es, this message translates to:
  /// **'Castellano'**
  String get onboardingLanguageSpanish;

  /// Catalan language option.
  ///
  /// In es, this message translates to:
  /// **'Catalán'**
  String get onboardingLanguageCatalan;

  /// Checkbox to accept the legal notice.
  ///
  /// In es, this message translates to:
  /// **'He leído y acepto el aviso legal'**
  String get onboardingLegalAccept;

  /// Personal situation step title.
  ///
  /// In es, this message translates to:
  /// **'Tu situación'**
  String get onboardingSituationTitle;

  /// Age range question.
  ///
  /// In es, this message translates to:
  /// **'Edad'**
  String get onboardingAgeRange;

  /// Age range option.
  ///
  /// In es, this message translates to:
  /// **'16–20'**
  String get onboardingAge16To20;

  /// Age range option.
  ///
  /// In es, this message translates to:
  /// **'21–25'**
  String get onboardingAge21To25;

  /// Age range option.
  ///
  /// In es, this message translates to:
  /// **'26–30'**
  String get onboardingAge26To30;

  /// Age range option.
  ///
  /// In es, this message translates to:
  /// **'31–35'**
  String get onboardingAge31To35;

  /// Age range option.
  ///
  /// In es, this message translates to:
  /// **'Más de 35'**
  String get onboardingAgeOver35;

  /// Employment question.
  ///
  /// In es, this message translates to:
  /// **'Situación laboral'**
  String get onboardingEmployment;

  /// Employment option.
  ///
  /// In es, this message translates to:
  /// **'Contrato indefinido'**
  String get onboardingEmploymentPermanent;

  /// Employment option.
  ///
  /// In es, this message translates to:
  /// **'Contrato temporal'**
  String get onboardingEmploymentTemporary;

  /// Employment option.
  ///
  /// In es, this message translates to:
  /// **'Autónomo/a'**
  String get onboardingEmploymentSelfEmployed;

  /// Employment option.
  ///
  /// In es, this message translates to:
  /// **'Estudiante'**
  String get onboardingEmploymentStudent;

  /// Employment option.
  ///
  /// In es, this message translates to:
  /// **'En paro'**
  String get onboardingEmploymentUnemployed;

  /// Net monthly income field label.
  ///
  /// In es, this message translates to:
  /// **'Ingresos netos mensuales'**
  String get onboardingIncome;

  /// Dependents question.
  ///
  /// In es, this message translates to:
  /// **'¿Tienes personas a tu cargo?'**
  String get onboardingDependents;

  /// High-interest debt question.
  ///
  /// In es, this message translates to:
  /// **'¿Tienes deudas con intereses altos? (tarjetas de crédito, préstamos personales)'**
  String get onboardingDebt;

  /// Outstanding debt amount label.
  ///
  /// In es, this message translates to:
  /// **'Importe pendiente'**
  String get onboardingDebtAmount;

  /// Expenses step title.
  ///
  /// In es, this message translates to:
  /// **'Tus gastos mensuales'**
  String get onboardingExpensesTitle;

  /// Expenses step subtitle.
  ///
  /// In es, this message translates to:
  /// **'Aproximado está bien. Deja en blanco lo que no tengas.'**
  String get onboardingExpensesSubtitle;

  /// Expense category.
  ///
  /// In es, this message translates to:
  /// **'Vivienda (alquiler o hipoteca, suministros)'**
  String get onboardingExpenseHousing;

  /// Expense category.
  ///
  /// In es, this message translates to:
  /// **'Alimentación'**
  String get onboardingExpenseFood;

  /// Expense category.
  ///
  /// In es, this message translates to:
  /// **'Transporte'**
  String get onboardingExpenseTransport;

  /// Expense category.
  ///
  /// In es, this message translates to:
  /// **'Seguros'**
  String get onboardingExpenseInsurance;

  /// Expense category.
  ///
  /// In es, this message translates to:
  /// **'Suscripciones'**
  String get onboardingExpenseSubscriptions;

  /// Expense category.
  ///
  /// In es, this message translates to:
  /// **'Otros gastos fijos'**
  String get onboardingExpenseOtherFixed;

  /// Live total of monthly expenses.
  ///
  /// In es, this message translates to:
  /// **'Total: {amount} al mes'**
  String onboardingExpensesTotal(String amount);

  /// Risk step title.
  ///
  /// In es, this message translates to:
  /// **'Tu tolerancia al riesgo'**
  String get onboardingRiskTitle;

  /// Risk question 1.
  ///
  /// In es, this message translates to:
  /// **'Si tu inversión cae un 20 % en un mes…'**
  String get onboardingRiskQ1;

  /// Risk answer (1 point).
  ///
  /// In es, this message translates to:
  /// **'Lo vendo todo'**
  String get onboardingRiskQ1A1;

  /// Risk answer (2 points).
  ///
  /// In es, this message translates to:
  /// **'Espero a que se recupere'**
  String get onboardingRiskQ1A2;

  /// Risk answer (3 points).
  ///
  /// In es, this message translates to:
  /// **'Invierto más aprovechando la bajada'**
  String get onboardingRiskQ1A3;

  /// Risk question 2.
  ///
  /// In es, this message translates to:
  /// **'¿Cuándo crees que necesitarás este dinero?'**
  String get onboardingRiskQ2;

  /// Risk answer (1 point).
  ///
  /// In es, this message translates to:
  /// **'En menos de 2 años'**
  String get onboardingRiskQ2A1;

  /// Risk answer (2 points).
  ///
  /// In es, this message translates to:
  /// **'Entre 2 y 5 años'**
  String get onboardingRiskQ2A2;

  /// Risk answer (3 points).
  ///
  /// In es, this message translates to:
  /// **'En más de 5 años'**
  String get onboardingRiskQ2A3;

  /// Risk question 3.
  ///
  /// In es, this message translates to:
  /// **'¿Qué prefieres?'**
  String get onboardingRiskQ3;

  /// Risk answer (1 point).
  ///
  /// In es, this message translates to:
  /// **'Ganar poco, pero con seguridad'**
  String get onboardingRiskQ3A1;

  /// Risk answer (2 points).
  ///
  /// In es, this message translates to:
  /// **'Asumir algo de riesgo por algo más de rentabilidad'**
  String get onboardingRiskQ3A2;

  /// Risk answer (3 points).
  ///
  /// In es, this message translates to:
  /// **'Asumir mucho riesgo por la posibilidad de ganar mucho'**
  String get onboardingRiskQ3A3;

  /// Risk question 4.
  ///
  /// In es, this message translates to:
  /// **'¿Cómo te sentirías viendo tu inversión en negativo durante un año?'**
  String get onboardingRiskQ4;

  /// Risk answer (1 point).
  ///
  /// In es, this message translates to:
  /// **'Muy intranquilo/a, me quitaría el sueño'**
  String get onboardingRiskQ4A1;

  /// Risk answer (2 points).
  ///
  /// In es, this message translates to:
  /// **'Incómodo/a, pero lo aguantaría'**
  String get onboardingRiskQ4A2;

  /// Risk answer (3 points).
  ///
  /// In es, this message translates to:
  /// **'Tranquilo/a, es parte de invertir a largo plazo'**
  String get onboardingRiskQ4A3;

  /// Goals step title.
  ///
  /// In es, this message translates to:
  /// **'Tus objetivos'**
  String get onboardingGoalsTitle;

  /// Goals step subtitle.
  ///
  /// In es, this message translates to:
  /// **'Puedes elegir varios. Podrás ajustarlos más adelante.'**
  String get onboardingGoalsSubtitle;

  /// Emergency fund goal option.
  ///
  /// In es, this message translates to:
  /// **'Fondo de emergencia'**
  String get onboardingGoalEmergency;

  /// Explains why the emergency goal is always on.
  ///
  /// In es, this message translates to:
  /// **'Siempre es el primer paso'**
  String get onboardingGoalEmergencyHint;

  /// House down payment goal option.
  ///
  /// In es, this message translates to:
  /// **'Entrada de una vivienda'**
  String get onboardingGoalHousing;

  /// Retirement goal option.
  ///
  /// In es, this message translates to:
  /// **'Jubilación'**
  String get onboardingGoalRetirement;

  /// Custom goal option.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get onboardingGoalOther;

  /// Custom goal name field.
  ///
  /// In es, this message translates to:
  /// **'Nombre del objetivo'**
  String get onboardingGoalOtherName;

  /// Knowledge step title.
  ///
  /// In es, this message translates to:
  /// **'¿Cuánto sabes de inversión?'**
  String get onboardingKnowledgeTitle;

  /// Knowledge level option.
  ///
  /// In es, this message translates to:
  /// **'Nada, empiezo de cero'**
  String get onboardingKnowledgeNone;

  /// Knowledge level option.
  ///
  /// In es, this message translates to:
  /// **'Lo básico'**
  String get onboardingKnowledgeBasic;

  /// Knowledge level option.
  ///
  /// In es, this message translates to:
  /// **'Nivel intermedio'**
  String get onboardingKnowledgeIntermediate;

  /// Result step title.
  ///
  /// In es, this message translates to:
  /// **'Tu punto de partida'**
  String get onboardingResultTitle;

  /// Result: risk profile label.
  ///
  /// In es, this message translates to:
  /// **'Perfil de riesgo'**
  String get onboardingResultRiskProfile;

  /// Risk profile name.
  ///
  /// In es, this message translates to:
  /// **'Conservador'**
  String get onboardingRiskProfileConservative;

  /// Risk profile name.
  ///
  /// In es, this message translates to:
  /// **'Moderado'**
  String get onboardingRiskProfileModerate;

  /// Risk profile name.
  ///
  /// In es, this message translates to:
  /// **'Dinámico'**
  String get onboardingRiskProfileAggressive;

  /// Risk profile description.
  ///
  /// In es, this message translates to:
  /// **'Priorizas la estabilidad y te incomodan las caídas.'**
  String get onboardingRiskProfileConservativeDesc;

  /// Risk profile description.
  ///
  /// In es, this message translates to:
  /// **'Aceptas algo de volatilidad a cambio de más rentabilidad potencial.'**
  String get onboardingRiskProfileModerateDesc;

  /// Risk profile description.
  ///
  /// In es, this message translates to:
  /// **'Toleras bien las caídas y piensas a largo plazo.'**
  String get onboardingRiskProfileAggressiveDesc;

  /// Result: emergency fund card title.
  ///
  /// In es, this message translates to:
  /// **'Fondo de emergencia'**
  String get onboardingResultEmergencyTitle;

  /// Result: recommended emergency fund range.
  ///
  /// In es, this message translates to:
  /// **'Te recomendamos cubrir entre {min} y {max} meses de gastos: de {minAmount} a {maxAmount}.'**
  String onboardingResultEmergencyRange(
    int min,
    int max,
    String minAmount,
    String maxAmount,
  );

  /// Number of months.
  ///
  /// In es, this message translates to:
  /// **'{months, plural, =1{1 mes} other{{months} meses}}'**
  String onboardingResultMonths(int months);

  /// Result: chosen emergency fund target.
  ///
  /// In es, this message translates to:
  /// **'Tu objetivo: {amount}'**
  String onboardingResultTarget(String amount);

  /// Result: warning when expenses are zero.
  ///
  /// In es, this message translates to:
  /// **'No has indicado gastos, así que el objetivo es 0 €. Podrás cambiarlo más adelante.'**
  String get onboardingResultNoExpenses;

  /// Result: high-interest debt warning.
  ///
  /// In es, this message translates to:
  /// **'Prioriza pagar esta deuda antes de invertir'**
  String get onboardingResultDebtWarning;

  /// Result: recommended lessons heading.
  ///
  /// In es, this message translates to:
  /// **'Te recomendamos empezar por'**
  String get onboardingResultLessons;

  /// Final onboarding button.
  ///
  /// In es, this message translates to:
  /// **'Confirmar y empezar'**
  String get onboardingConfirm;

  /// Learn module name.
  ///
  /// In es, this message translates to:
  /// **'Fundamentos'**
  String get learnModuleFundamentals;

  /// Learn module name.
  ///
  /// In es, this message translates to:
  /// **'Fondo de emergencia'**
  String get learnModuleEmergencyFund;

  /// Learn module name.
  ///
  /// In es, this message translates to:
  /// **'Deudas'**
  String get learnModuleDebt;

  /// Learn module name.
  ///
  /// In es, this message translates to:
  /// **'Renta fija'**
  String get learnModuleFixedIncome;

  /// Learn module name.
  ///
  /// In es, this message translates to:
  /// **'Renta variable'**
  String get learnModuleEquities;

  /// Learn module name.
  ///
  /// In es, this message translates to:
  /// **'Criptomonedas'**
  String get learnModuleCrypto;

  /// Learn module name.
  ///
  /// In es, this message translates to:
  /// **'Fiscalidad básica en España'**
  String get learnModuleTaxes;

  /// Learn module name.
  ///
  /// In es, this message translates to:
  /// **'Psicología del inversor'**
  String get learnModulePsychology;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ca', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return AppLocalizationsCa();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
