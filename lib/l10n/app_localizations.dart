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

  /// Generic error when saving fails.
  ///
  /// In es, this message translates to:
  /// **'No se han podido guardar los datos. Inténtalo de nuevo.'**
  String get commonSaveError;

  /// Close button tooltip.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get commonClose;

  /// Profile option to retake onboarding.
  ///
  /// In es, this message translates to:
  /// **'Repetir cuestionario'**
  String get profileRetakeQuestionnaire;

  /// Subtitle of the retake option.
  ///
  /// In es, this message translates to:
  /// **'Actualiza tu perfil y tu fondo de emergencia'**
  String get profileRetakeQuestionnaireSubtitle;

  /// Shown after retaking the questionnaire.
  ///
  /// In es, this message translates to:
  /// **'Perfil actualizado'**
  String get profileRetakeSaved;

  /// Generic error when loading data fails.
  ///
  /// In es, this message translates to:
  /// **'No se han podido cargar los datos.'**
  String get commonLoadError;

  /// Label of the total value of all investments.
  ///
  /// In es, this message translates to:
  /// **'Valor total'**
  String get investmentsTotalValue;

  /// Investment category.
  ///
  /// In es, this message translates to:
  /// **'Fondo de emergencia'**
  String get investmentsCategoryEmergency;

  /// Investment category.
  ///
  /// In es, this message translates to:
  /// **'Renta fija'**
  String get investmentsCategoryFixedIncome;

  /// Investment category.
  ///
  /// In es, this message translates to:
  /// **'Renta variable'**
  String get investmentsCategoryEquity;

  /// Investment category.
  ///
  /// In es, this message translates to:
  /// **'Criptomonedas'**
  String get investmentsCategoryCrypto;

  /// Examples of the emergency fund category.
  ///
  /// In es, this message translates to:
  /// **'Cuentas remuneradas, depósitos, fondos monetarios'**
  String get investmentsCategoryEmergencyExamples;

  /// Examples of the fixed income category.
  ///
  /// In es, this message translates to:
  /// **'Letras del Tesoro, bonos, fondos de renta fija'**
  String get investmentsCategoryFixedIncomeExamples;

  /// Examples of the equities category.
  ///
  /// In es, this message translates to:
  /// **'Fondos indexados, ETF, acciones'**
  String get investmentsCategoryEquityExamples;

  /// Examples of the crypto category.
  ///
  /// In es, this message translates to:
  /// **'BTC, ETH…'**
  String get investmentsCategoryCryptoExamples;

  /// Save button.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get commonSave;

  /// Cancel button.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// Delete button.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get commonDelete;

  /// Clear a field.
  ///
  /// In es, this message translates to:
  /// **'Borrar'**
  String get commonClear;

  /// Validation error for required fields.
  ///
  /// In es, this message translates to:
  /// **'Campo obligatorio'**
  String get commonRequired;

  /// Validation error for numeric fields.
  ///
  /// In es, this message translates to:
  /// **'Introduce un número válido'**
  String get commonInvalidNumber;

  /// Button to add an asset.
  ///
  /// In es, this message translates to:
  /// **'Añadir activo'**
  String get investmentsAddAsset;

  /// Title of the create asset form.
  ///
  /// In es, this message translates to:
  /// **'Nuevo activo'**
  String get investmentsNewAsset;

  /// Title of the edit asset form.
  ///
  /// In es, this message translates to:
  /// **'Editar activo'**
  String get investmentsEditAsset;

  /// Empty state of a category.
  ///
  /// In es, this message translates to:
  /// **'Aún no tienes nada en esta categoría'**
  String get investmentsEmptyCategory;

  /// Asset name field.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get investmentsFieldName;

  /// Bank or institution field.
  ///
  /// In es, this message translates to:
  /// **'Entidad'**
  String get investmentsFieldInstitution;

  /// Annual percentage yield field.
  ///
  /// In es, this message translates to:
  /// **'Rentabilidad anual (TAE)'**
  String get investmentsFieldApy;

  /// Fixed income issuer field.
  ///
  /// In es, this message translates to:
  /// **'Emisor'**
  String get investmentsFieldIssuer;

  /// Fixed income yield or coupon field.
  ///
  /// In es, this message translates to:
  /// **'Rentabilidad o cupón anual'**
  String get investmentsFieldYield;

  /// Maturity date field.
  ///
  /// In es, this message translates to:
  /// **'Fecha de vencimiento'**
  String get investmentsFieldMaturity;

  /// Ticker or ISIN field.
  ///
  /// In es, this message translates to:
  /// **'Ticker o ISIN'**
  String get investmentsFieldTicker;

  /// Equity subtype field.
  ///
  /// In es, this message translates to:
  /// **'Tipo'**
  String get investmentsFieldSubtype;

  /// Crypto symbol field.
  ///
  /// In es, this message translates to:
  /// **'Símbolo'**
  String get investmentsFieldSymbol;

  /// Crypto exchange or wallet field.
  ///
  /// In es, this message translates to:
  /// **'Exchange o wallet'**
  String get investmentsFieldExchange;

  /// Assigned goal field.
  ///
  /// In es, this message translates to:
  /// **'Objetivo asignado'**
  String get investmentsFieldGoal;

  /// No goal assigned option.
  ///
  /// In es, this message translates to:
  /// **'Ninguno'**
  String get investmentsNoGoal;

  /// Notes field.
  ///
  /// In es, this message translates to:
  /// **'Notas'**
  String get investmentsFieldNotes;

  /// Equity subtype.
  ///
  /// In es, this message translates to:
  /// **'Fondo indexado'**
  String get investmentsSubtypeIndexFund;

  /// Equity subtype.
  ///
  /// In es, this message translates to:
  /// **'ETF'**
  String get investmentsSubtypeEtf;

  /// Equity subtype.
  ///
  /// In es, this message translates to:
  /// **'Acción'**
  String get investmentsSubtypeStock;

  /// Equity subtype.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get investmentsSubtypeOther;

  /// APY shown in asset lists.
  ///
  /// In es, this message translates to:
  /// **'{rate} TAE'**
  String investmentsApyShort(String rate);

  /// Maturity shown in asset lists.
  ///
  /// In es, this message translates to:
  /// **'vence {date}'**
  String investmentsMaturityShort(String date);

  /// Delete asset dialog title.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar este activo?'**
  String get investmentsDeleteAssetTitle;

  /// Delete asset dialog body.
  ///
  /// In es, this message translates to:
  /// **'Se eliminarán también todos sus movimientos. Esta acción no se puede deshacer.'**
  String get investmentsDeleteAssetBody;

  /// Current value label.
  ///
  /// In es, this message translates to:
  /// **'Valor actual'**
  String get investmentsCurrentValue;

  /// Transactions section title.
  ///
  /// In es, this message translates to:
  /// **'Movimientos'**
  String get investmentsTransactions;

  /// Empty transactions list.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay movimientos. Añade tu primera aportación o compra.'**
  String get investmentsNoTransactions;

  /// Button to add a transaction.
  ///
  /// In es, this message translates to:
  /// **'Añadir movimiento'**
  String get investmentsAddTransaction;

  /// Title of the create transaction form.
  ///
  /// In es, this message translates to:
  /// **'Nuevo movimiento'**
  String get investmentsNewTransaction;

  /// Title of the edit transaction form.
  ///
  /// In es, this message translates to:
  /// **'Editar movimiento'**
  String get investmentsEditTransaction;

  /// Delete transaction dialog title.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar este movimiento?'**
  String get investmentsDeleteTransactionTitle;

  /// Transaction type: deposit.
  ///
  /// In es, this message translates to:
  /// **'Aportación'**
  String get investmentsTxDeposit;

  /// Transaction type: withdrawal.
  ///
  /// In es, this message translates to:
  /// **'Retirada'**
  String get investmentsTxWithdrawal;

  /// Transaction type: buy.
  ///
  /// In es, this message translates to:
  /// **'Compra'**
  String get investmentsTxBuy;

  /// Transaction type: sell.
  ///
  /// In es, this message translates to:
  /// **'Venta'**
  String get investmentsTxSell;

  /// Transaction type: income.
  ///
  /// In es, this message translates to:
  /// **'Dividendo, cupón o interés'**
  String get investmentsTxIncome;

  /// Transaction type: valuation.
  ///
  /// In es, this message translates to:
  /// **'Actualizar valor'**
  String get investmentsTxValuation;

  /// Amount label for deposits.
  ///
  /// In es, this message translates to:
  /// **'Importe aportado'**
  String get investmentsTxAmountDeposit;

  /// Amount label for withdrawals.
  ///
  /// In es, this message translates to:
  /// **'Importe retirado'**
  String get investmentsTxAmountWithdrawal;

  /// Amount label for buys.
  ///
  /// In es, this message translates to:
  /// **'Importe invertido'**
  String get investmentsTxAmountBuy;

  /// Amount label for sells.
  ///
  /// In es, this message translates to:
  /// **'Importe recibido'**
  String get investmentsTxAmountSell;

  /// Amount label for income.
  ///
  /// In es, this message translates to:
  /// **'Importe cobrado'**
  String get investmentsTxAmountIncome;

  /// Amount label for valuations.
  ///
  /// In es, this message translates to:
  /// **'Valor total actual'**
  String get investmentsTxAmountValuation;

  /// Explains the valuation transaction.
  ///
  /// In es, this message translates to:
  /// **'Indica cuánto vale hoy todo este activo. Se usará como valor actual.'**
  String get investmentsValuationHint;

  /// Transaction date field.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get investmentsFieldDate;

  /// Quantity field.
  ///
  /// In es, this message translates to:
  /// **'Unidades o participaciones'**
  String get investmentsFieldQuantity;

  /// Fee field.
  ///
  /// In es, this message translates to:
  /// **'Comisión'**
  String get investmentsFieldFee;

  /// Transaction note field.
  ///
  /// In es, this message translates to:
  /// **'Nota'**
  String get investmentsFieldNote;

  /// Validation: amount must be positive.
  ///
  /// In es, this message translates to:
  /// **'El importe debe ser mayor que 0'**
  String get investmentsAmountPositive;

  /// Validation: selling more units than held.
  ///
  /// In es, this message translates to:
  /// **'Solo tienes {available} unidades'**
  String investmentsSellTooMuch(String available);

  /// Quantity of units shown in lists.
  ///
  /// In es, this message translates to:
  /// **'{quantity} uds.'**
  String investmentsUnits(String quantity);

  /// Net contributed capital label.
  ///
  /// In es, this message translates to:
  /// **'Capital aportado'**
  String get investmentsNetContributed;

  /// Net contributed in the total card.
  ///
  /// In es, this message translates to:
  /// **'Aportado: {amount}'**
  String investmentsContributedShort(String amount);

  /// Income received label.
  ///
  /// In es, this message translates to:
  /// **'Dividendos, cupones e intereses'**
  String get investmentsIncome;

  /// Return label.
  ///
  /// In es, this message translates to:
  /// **'Rentabilidad'**
  String get investmentsReturn;

  /// Holdings label.
  ///
  /// In es, this message translates to:
  /// **'Unidades'**
  String get investmentsHoldings;

  /// Average purchase price label.
  ///
  /// In es, this message translates to:
  /// **'Precio medio de compra'**
  String get investmentsAveragePrice;

  /// Explains how the return is calculated.
  ///
  /// In es, this message translates to:
  /// **'Rentabilidad = valor actual + ingresos − capital aportado. Las comisiones cuentan como capital aportado.'**
  String get investmentsReturnExplanation;

  /// Button to add a goal.
  ///
  /// In es, this message translates to:
  /// **'Nuevo objetivo'**
  String get goalsAddGoal;

  /// Title of the create goal form.
  ///
  /// In es, this message translates to:
  /// **'Nuevo objetivo'**
  String get goalsNewGoal;

  /// Title of the edit goal form.
  ///
  /// In es, this message translates to:
  /// **'Editar objetivo'**
  String get goalsEditGoal;

  /// Custom goal type.
  ///
  /// In es, this message translates to:
  /// **'Objetivo personalizado'**
  String get goalsCustomGoal;

  /// Goal progress amounts.
  ///
  /// In es, this message translates to:
  /// **'{current} de {target}'**
  String goalsProgressAmounts(String current, String target);

  /// Goal without target.
  ///
  /// In es, this message translates to:
  /// **'Aún no has definido el importe objetivo'**
  String get goalsNoTarget;

  /// Prompt to set up a goal.
  ///
  /// In es, this message translates to:
  /// **'Configura este objetivo para calcular cuánto necesitas'**
  String get goalsSetUpPrompt;

  /// Remaining amount label.
  ///
  /// In es, this message translates to:
  /// **'Te falta'**
  String get goalsRemaining;

  /// Target date label.
  ///
  /// In es, this message translates to:
  /// **'Fecha objetivo'**
  String get goalsTargetDate;

  /// Expected annual return label.
  ///
  /// In es, this message translates to:
  /// **'Rentabilidad anual esperada'**
  String get goalsExpectedReturn;

  /// Help text for the expected return.
  ///
  /// In es, this message translates to:
  /// **'Estimación orientativa; usa 0 % si el dinero no se invierte'**
  String get goalsExpectedReturnHelp;

  /// Required monthly contribution label.
  ///
  /// In es, this message translates to:
  /// **'Aportación mensual necesaria'**
  String get goalsRequiredMonthly;

  /// Months left until the target date.
  ///
  /// In es, this message translates to:
  /// **'{months, plural, =1{Queda 1 mes} other{Quedan {months} meses}}'**
  String goalsMonthsLeft(int months);

  /// Target date reached.
  ///
  /// In es, this message translates to:
  /// **'La fecha objetivo ya ha llegado'**
  String get goalsDatePassed;

  /// Assigned assets section title.
  ///
  /// In es, this message translates to:
  /// **'Activos del objetivo'**
  String get goalsAssignedAssets;

  /// Button to assign assets to a goal.
  ///
  /// In es, this message translates to:
  /// **'Asignar activos'**
  String get goalsAssignAssets;

  /// Explains the emergency fund counting rule.
  ///
  /// In es, this message translates to:
  /// **'Los activos de la categoría Fondo de emergencia sin otro objetivo cuentan automáticamente.'**
  String get goalsEmergencyAutoAssets;

  /// No assets for a goal.
  ///
  /// In es, this message translates to:
  /// **'Todavía no hay activos asignados'**
  String get goalsNoAssets;

  /// No assets exist yet.
  ///
  /// In es, this message translates to:
  /// **'Primero añade activos en Inversiones'**
  String get goalsNoAssetsToAssign;

  /// Asset currently assigned to another goal.
  ///
  /// In es, this message translates to:
  /// **'Ahora en: {goal}'**
  String goalsAssignedTo(String goal);

  /// Monthly expenses label.
  ///
  /// In es, this message translates to:
  /// **'Gastos mensuales'**
  String get goalsMonthlyExpenses;

  /// Emergency fund months label.
  ///
  /// In es, this message translates to:
  /// **'Meses de gastos cubiertos'**
  String get goalsMonthsCovered;

  /// Recommended emergency months.
  ///
  /// In es, this message translates to:
  /// **'Recomendado para tu perfil: entre {min} y {max} meses'**
  String goalsRecommendedMonths(int min, int max);

  /// Home price label.
  ///
  /// In es, this message translates to:
  /// **'Precio de la vivienda'**
  String get goalsHomePrice;

  /// Down payment percent label.
  ///
  /// In es, this message translates to:
  /// **'Entrada'**
  String get goalsDownPayment;

  /// Taxes and fees percent label.
  ///
  /// In es, this message translates to:
  /// **'Impuestos y gastos'**
  String get goalsFees;

  /// Help for taxes and fees.
  ///
  /// In es, this message translates to:
  /// **'ITP o IVA, notaría, registro… suelen rondar el 10 %'**
  String get goalsFeesHelp;

  /// Current age label.
  ///
  /// In es, this message translates to:
  /// **'Edad actual'**
  String get goalsCurrentAge;

  /// Retirement age label.
  ///
  /// In es, this message translates to:
  /// **'Edad de jubilación'**
  String get goalsRetirementAge;

  /// Monthly spending in retirement label.
  ///
  /// In es, this message translates to:
  /// **'Gasto mensual en la jubilación'**
  String get goalsMonthlySpending;

  /// Help for retirement spending.
  ///
  /// In es, this message translates to:
  /// **'En euros de hoy'**
  String get goalsMonthlySpendingHelp;

  /// Explains the 4% rule.
  ///
  /// In es, this message translates to:
  /// **'Objetivo calculado con la regla del 4 % (gasto anual × 25)'**
  String get goalsRetirementRule;

  /// Invalid age error.
  ///
  /// In es, this message translates to:
  /// **'Introduce una edad entre {min} y {max}'**
  String goalsInvalidAge(int min, int max);

  /// Goal name field.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get goalsFieldName;

  /// Custom goal target amount.
  ///
  /// In es, this message translates to:
  /// **'Importe objetivo'**
  String get goalsTargetAmount;

  /// Computed target label.
  ///
  /// In es, this message translates to:
  /// **'Objetivo'**
  String get goalsComputedTarget;

  /// Delete goal dialog title.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar este objetivo?'**
  String get goalsDeleteTitle;

  /// Delete goal dialog body.
  ///
  /// In es, this message translates to:
  /// **'Sus activos no se eliminan; solo dejan de estar asignados.'**
  String get goalsDeleteBody;

  /// Retirement chart title.
  ///
  /// In es, this message translates to:
  /// **'Proyección hasta la jubilación'**
  String get goalsProjectionTitle;

  /// Legend: projected value with compound interest.
  ///
  /// In es, this message translates to:
  /// **'Valor proyectado: {amount}'**
  String goalsProjectionValue(String amount);

  /// Legend: contributed capital.
  ///
  /// In es, this message translates to:
  /// **'Capital aportado: {amount}'**
  String goalsProjectionContributed(String amount);

  /// Explains the chart assumptions.
  ///
  /// In es, this message translates to:
  /// **'Suponiendo que aportas {amount} al mes con la rentabilidad esperada.'**
  String goalsProjectionAssumption(String amount);

  /// Net worth label.
  ///
  /// In es, this message translates to:
  /// **'Patrimonio total'**
  String get dashboardNetWorth;

  /// Allocation chart title.
  ///
  /// In es, this message translates to:
  /// **'Reparto por categoría'**
  String get dashboardAllocation;

  /// Home empty state for investments.
  ///
  /// In es, this message translates to:
  /// **'Añade tu primera inversión para ver tu reparto'**
  String get dashboardNoInvestments;

  /// Tip of the day label.
  ///
  /// In es, this message translates to:
  /// **'Consejo del día'**
  String get dashboardTipOfTheDay;

  /// Non-blocking warning when adding equities or crypto before the emergency fund is complete.
  ///
  /// In es, this message translates to:
  /// **'Tu fondo de emergencia aún no está completo ({current} de {target}). Lo habitual es completarlo antes de invertir en activos con más riesgo, pero puedes continuar igualmente.'**
  String investmentsEmergencyWarning(String current, String target);

  /// Marks modules recommended for the user's knowledge level.
  ///
  /// In es, this message translates to:
  /// **'Recomendado para ti'**
  String get learnRecommended;

  /// Lesson reading time.
  ///
  /// In es, this message translates to:
  /// **'{minutes} min de lectura'**
  String learnMinutes(int minutes);
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
