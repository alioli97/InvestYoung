// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Invertir siendo Joven';

  @override
  String get navHome => 'Inicio';

  @override
  String get navGoals => 'Objetivos';

  @override
  String get navInvestments => 'Inversiones';

  @override
  String get navLearn => 'Aprender';

  @override
  String get navProfile => 'Perfil';

  @override
  String get dashboardTitle => 'Inicio';

  @override
  String get goalsTitle => 'Objetivos';

  @override
  String get investmentsTitle => 'Inversiones';

  @override
  String get learnTitle => 'Aprender';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get onboardingWelcomeTitle => 'Bienvenido/a';

  @override
  String get onboardingWelcomeBody =>
      'Organiza tus finanzas y empieza a invertir con cabeza.';

  @override
  String get commonComingSoon => 'Próximamente';

  @override
  String get commonSimulationDisclaimer =>
      'Simulación orientativa, los resultados no están garantizados';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonYes => 'Sí';

  @override
  String get commonNo => 'No';

  @override
  String get commonOptional => 'Opcional';

  @override
  String get commonInvalidAmount => 'Introduce un importe válido';

  @override
  String get commonLegalNoticeTitle => 'Aviso legal';

  @override
  String get commonLegalNoticeBody =>
      'Invertir siendo Joven es una aplicación educativa. La información, los perfiles, los rangos y las simulaciones que muestra son orientativos y no constituyen asesoramiento financiero ni una recomendación personalizada de inversión, actividad regulada en España por la Comisión Nacional del Mercado de Valores (CNMV).\n\nInvertir conlleva riesgos, incluida la pérdida del capital invertido, y las rentabilidades pasadas no garantizan rentabilidades futuras. Antes de tomar decisiones de inversión, infórmate bien y, si lo necesitas, consulta con un profesional autorizado.\n\nTus datos se guardan solo en tu dispositivo.';

  @override
  String onboardingStepCounter(int current, int total) {
    return 'Paso $current de $total';
  }

  @override
  String get onboardingLanguageTitle => 'Elige tu idioma';

  @override
  String get onboardingLanguageSpanish => 'Castellano';

  @override
  String get onboardingLanguageCatalan => 'Catalán';

  @override
  String get onboardingLegalAccept => 'He leído y acepto el aviso legal';

  @override
  String get onboardingSituationTitle => 'Tu situación';

  @override
  String get onboardingAgeRange => 'Edad';

  @override
  String get onboardingAge16To20 => '16–20';

  @override
  String get onboardingAge21To25 => '21–25';

  @override
  String get onboardingAge26To30 => '26–30';

  @override
  String get onboardingAge31To35 => '31–35';

  @override
  String get onboardingAgeOver35 => 'Más de 35';

  @override
  String get onboardingEmployment => 'Situación laboral';

  @override
  String get onboardingEmploymentPermanent => 'Contrato indefinido';

  @override
  String get onboardingEmploymentTemporary => 'Contrato temporal';

  @override
  String get onboardingEmploymentSelfEmployed => 'Autónomo/a';

  @override
  String get onboardingEmploymentStudent => 'Estudiante';

  @override
  String get onboardingEmploymentUnemployed => 'En paro';

  @override
  String get onboardingIncome => 'Ingresos netos mensuales';

  @override
  String get onboardingDependents => '¿Tienes personas a tu cargo?';

  @override
  String get onboardingDebt =>
      '¿Tienes deudas con intereses altos? (tarjetas de crédito, préstamos personales)';

  @override
  String get onboardingDebtAmount => 'Importe pendiente';

  @override
  String get onboardingExpensesTitle => 'Tus gastos mensuales';

  @override
  String get onboardingExpensesSubtitle =>
      'Aproximado está bien. Deja en blanco lo que no tengas.';

  @override
  String get onboardingExpenseHousing =>
      'Vivienda (alquiler o hipoteca, suministros)';

  @override
  String get onboardingExpenseFood => 'Alimentación';

  @override
  String get onboardingExpenseTransport => 'Transporte';

  @override
  String get onboardingExpenseInsurance => 'Seguros';

  @override
  String get onboardingExpenseSubscriptions => 'Suscripciones';

  @override
  String get onboardingExpenseOtherFixed => 'Otros gastos fijos';

  @override
  String onboardingExpensesTotal(String amount) {
    return 'Total: $amount al mes';
  }

  @override
  String get onboardingRiskTitle => 'Tu tolerancia al riesgo';

  @override
  String get onboardingRiskQ1 => 'Si tu inversión cae un 20 % en un mes…';

  @override
  String get onboardingRiskQ1A1 => 'Lo vendo todo';

  @override
  String get onboardingRiskQ1A2 => 'Espero a que se recupere';

  @override
  String get onboardingRiskQ1A3 => 'Invierto más aprovechando la bajada';

  @override
  String get onboardingRiskQ2 => '¿Cuándo crees que necesitarás este dinero?';

  @override
  String get onboardingRiskQ2A1 => 'En menos de 2 años';

  @override
  String get onboardingRiskQ2A2 => 'Entre 2 y 5 años';

  @override
  String get onboardingRiskQ2A3 => 'En más de 5 años';

  @override
  String get onboardingRiskQ3 => '¿Qué prefieres?';

  @override
  String get onboardingRiskQ3A1 => 'Ganar poco, pero con seguridad';

  @override
  String get onboardingRiskQ3A2 =>
      'Asumir algo de riesgo por algo más de rentabilidad';

  @override
  String get onboardingRiskQ3A3 =>
      'Asumir mucho riesgo por la posibilidad de ganar mucho';

  @override
  String get onboardingRiskQ4 =>
      '¿Cómo te sentirías viendo tu inversión en negativo durante un año?';

  @override
  String get onboardingRiskQ4A1 => 'Muy intranquilo/a, me quitaría el sueño';

  @override
  String get onboardingRiskQ4A2 => 'Incómodo/a, pero lo aguantaría';

  @override
  String get onboardingRiskQ4A3 =>
      'Tranquilo/a, es parte de invertir a largo plazo';

  @override
  String get onboardingGoalsTitle => 'Tus objetivos';

  @override
  String get onboardingGoalsSubtitle =>
      'Puedes elegir varios. Podrás ajustarlos más adelante.';

  @override
  String get onboardingGoalEmergency => 'Fondo de emergencia';

  @override
  String get onboardingGoalEmergencyHint => 'Siempre es el primer paso';

  @override
  String get onboardingGoalHousing => 'Entrada de una vivienda';

  @override
  String get onboardingGoalRetirement => 'Jubilación';

  @override
  String get onboardingGoalOther => 'Otro';

  @override
  String get onboardingGoalOtherName => 'Nombre del objetivo';

  @override
  String get onboardingKnowledgeTitle => '¿Cuánto sabes de inversión?';

  @override
  String get onboardingKnowledgeNone => 'Nada, empiezo de cero';

  @override
  String get onboardingKnowledgeBasic => 'Lo básico';

  @override
  String get onboardingKnowledgeIntermediate => 'Nivel intermedio';

  @override
  String get onboardingResultTitle => 'Tu punto de partida';

  @override
  String get onboardingResultRiskProfile => 'Perfil de riesgo';

  @override
  String get onboardingRiskProfileConservative => 'Conservador';

  @override
  String get onboardingRiskProfileModerate => 'Moderado';

  @override
  String get onboardingRiskProfileAggressive => 'Dinámico';

  @override
  String get onboardingRiskProfileConservativeDesc =>
      'Priorizas la estabilidad y te incomodan las caídas.';

  @override
  String get onboardingRiskProfileModerateDesc =>
      'Aceptas algo de volatilidad a cambio de más rentabilidad potencial.';

  @override
  String get onboardingRiskProfileAggressiveDesc =>
      'Toleras bien las caídas y piensas a largo plazo.';

  @override
  String get onboardingResultEmergencyTitle => 'Fondo de emergencia';

  @override
  String onboardingResultEmergencyRange(
    int min,
    int max,
    String minAmount,
    String maxAmount,
  ) {
    return 'Te recomendamos cubrir entre $min y $max meses de gastos: de $minAmount a $maxAmount.';
  }

  @override
  String onboardingResultMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months meses',
      one: '1 mes',
    );
    return '$_temp0';
  }

  @override
  String onboardingResultTarget(String amount) {
    return 'Tu objetivo: $amount';
  }

  @override
  String get onboardingResultNoExpenses =>
      'No has indicado gastos, así que el objetivo es 0 €. Podrás cambiarlo más adelante.';

  @override
  String get onboardingResultDebtWarning =>
      'Prioriza pagar esta deuda antes de invertir';

  @override
  String get onboardingResultLessons => 'Te recomendamos empezar por';

  @override
  String get onboardingConfirm => 'Confirmar y empezar';

  @override
  String get learnModuleFundamentals => 'Fundamentos';

  @override
  String get learnModuleEmergencyFund => 'Fondo de emergencia';

  @override
  String get learnModuleDebt => 'Deudas';

  @override
  String get learnModuleFixedIncome => 'Renta fija';

  @override
  String get learnModuleEquities => 'Renta variable';

  @override
  String get learnModuleCrypto => 'Criptomonedas';

  @override
  String get learnModuleTaxes => 'Fiscalidad básica en España';

  @override
  String get learnModulePsychology => 'Psicología del inversor';
}
