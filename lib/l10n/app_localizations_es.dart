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

  @override
  String get commonSaveError =>
      'No se han podido guardar los datos. Inténtalo de nuevo.';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get profileRetakeQuestionnaire => 'Repetir cuestionario';

  @override
  String get profileRetakeQuestionnaireSubtitle =>
      'Actualiza tu perfil y tu fondo de emergencia';

  @override
  String get profileRetakeSaved => 'Perfil actualizado';

  @override
  String get commonLoadError => 'No se han podido cargar los datos.';

  @override
  String get investmentsTotalValue => 'Valor total';

  @override
  String get investmentsCategoryEmergency => 'Fondo de emergencia';

  @override
  String get investmentsCategoryFixedIncome => 'Renta fija';

  @override
  String get investmentsCategoryEquity => 'Renta variable';

  @override
  String get investmentsCategoryCrypto => 'Criptomonedas';

  @override
  String get investmentsCategoryEmergencyExamples =>
      'Cuentas remuneradas, depósitos, fondos monetarios';

  @override
  String get investmentsCategoryFixedIncomeExamples =>
      'Letras del Tesoro, bonos, fondos de renta fija';

  @override
  String get investmentsCategoryEquityExamples =>
      'Fondos indexados, ETF, acciones';

  @override
  String get investmentsCategoryCryptoExamples => 'BTC, ETH…';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonClear => 'Borrar';

  @override
  String get commonRequired => 'Campo obligatorio';

  @override
  String get commonInvalidNumber => 'Introduce un número válido';

  @override
  String get investmentsAddAsset => 'Añadir activo';

  @override
  String get investmentsNewAsset => 'Nuevo activo';

  @override
  String get investmentsEditAsset => 'Editar activo';

  @override
  String get investmentsEmptyCategory => 'Aún no tienes nada en esta categoría';

  @override
  String get investmentsFieldName => 'Nombre';

  @override
  String get investmentsFieldInstitution => 'Entidad';

  @override
  String get investmentsFieldApy => 'Rentabilidad anual (TAE)';

  @override
  String get investmentsFieldIssuer => 'Emisor';

  @override
  String get investmentsFieldYield => 'Rentabilidad o cupón anual';

  @override
  String get investmentsFieldMaturity => 'Fecha de vencimiento';

  @override
  String get investmentsFieldTicker => 'Ticker o ISIN';

  @override
  String get investmentsFieldSubtype => 'Tipo';

  @override
  String get investmentsFieldSymbol => 'Símbolo';

  @override
  String get investmentsFieldExchange => 'Exchange o wallet';

  @override
  String get investmentsFieldGoal => 'Objetivo asignado';

  @override
  String get investmentsNoGoal => 'Ninguno';

  @override
  String get investmentsFieldNotes => 'Notas';

  @override
  String get investmentsSubtypeIndexFund => 'Fondo indexado';

  @override
  String get investmentsSubtypeEtf => 'ETF';

  @override
  String get investmentsSubtypeStock => 'Acción';

  @override
  String get investmentsSubtypeOther => 'Otro';

  @override
  String investmentsApyShort(String rate) {
    return '$rate TAE';
  }

  @override
  String investmentsMaturityShort(String date) {
    return 'vence $date';
  }

  @override
  String get investmentsDeleteAssetTitle => '¿Eliminar este activo?';

  @override
  String get investmentsDeleteAssetBody =>
      'Se eliminarán también todos sus movimientos. Esta acción no se puede deshacer.';

  @override
  String get investmentsCurrentValue => 'Valor actual';

  @override
  String get investmentsTransactions => 'Movimientos';

  @override
  String get investmentsNoTransactions =>
      'Aún no hay movimientos. Añade tu primera aportación o compra.';

  @override
  String get investmentsAddTransaction => 'Añadir movimiento';

  @override
  String get investmentsNewTransaction => 'Nuevo movimiento';

  @override
  String get investmentsEditTransaction => 'Editar movimiento';

  @override
  String get investmentsDeleteTransactionTitle => '¿Eliminar este movimiento?';

  @override
  String get investmentsTxDeposit => 'Aportación';

  @override
  String get investmentsTxWithdrawal => 'Retirada';

  @override
  String get investmentsTxBuy => 'Compra';

  @override
  String get investmentsTxSell => 'Venta';

  @override
  String get investmentsTxIncome => 'Dividendo, cupón o interés';

  @override
  String get investmentsTxValuation => 'Actualizar valor';

  @override
  String get investmentsTxAmountDeposit => 'Importe aportado';

  @override
  String get investmentsTxAmountWithdrawal => 'Importe retirado';

  @override
  String get investmentsTxAmountBuy => 'Importe invertido';

  @override
  String get investmentsTxAmountSell => 'Importe recibido';

  @override
  String get investmentsTxAmountIncome => 'Importe cobrado';

  @override
  String get investmentsTxAmountValuation => 'Valor total actual';

  @override
  String get investmentsValuationHint =>
      'Indica cuánto vale hoy todo este activo. Se usará como valor actual.';

  @override
  String get investmentsFieldDate => 'Fecha';

  @override
  String get investmentsFieldQuantity => 'Unidades o participaciones';

  @override
  String get investmentsFieldFee => 'Comisión';

  @override
  String get investmentsFieldNote => 'Nota';

  @override
  String get investmentsAmountPositive => 'El importe debe ser mayor que 0';

  @override
  String investmentsSellTooMuch(String available) {
    return 'Solo tienes $available unidades';
  }

  @override
  String investmentsUnits(String quantity) {
    return '$quantity uds.';
  }

  @override
  String get investmentsNetContributed => 'Capital aportado';

  @override
  String investmentsContributedShort(String amount) {
    return 'Aportado: $amount';
  }

  @override
  String get investmentsIncome => 'Dividendos, cupones e intereses';

  @override
  String get investmentsReturn => 'Rentabilidad';

  @override
  String get investmentsHoldings => 'Unidades';

  @override
  String get investmentsAveragePrice => 'Precio medio de compra';

  @override
  String get investmentsReturnExplanation =>
      'Rentabilidad = valor actual + ingresos − capital aportado. Las comisiones cuentan como capital aportado.';

  @override
  String get goalsAddGoal => 'Nuevo objetivo';

  @override
  String get goalsNewGoal => 'Nuevo objetivo';

  @override
  String get goalsEditGoal => 'Editar objetivo';

  @override
  String get goalsCustomGoal => 'Objetivo personalizado';

  @override
  String goalsProgressAmounts(String current, String target) {
    return '$current de $target';
  }

  @override
  String get goalsNoTarget => 'Aún no has definido el importe objetivo';

  @override
  String get goalsSetUpPrompt =>
      'Configura este objetivo para calcular cuánto necesitas';

  @override
  String get goalsRemaining => 'Te falta';

  @override
  String get goalsTargetDate => 'Fecha objetivo';

  @override
  String get goalsExpectedReturn => 'Rentabilidad anual esperada';

  @override
  String get goalsExpectedReturnHelp =>
      'Estimación orientativa; usa 0 % si el dinero no se invierte';

  @override
  String get goalsRequiredMonthly => 'Aportación mensual necesaria';

  @override
  String goalsMonthsLeft(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Quedan $months meses',
      one: 'Queda 1 mes',
    );
    return '$_temp0';
  }

  @override
  String get goalsDatePassed => 'La fecha objetivo ya ha llegado';

  @override
  String get goalsAssignedAssets => 'Activos del objetivo';

  @override
  String get goalsAssignAssets => 'Asignar activos';

  @override
  String get goalsEmergencyAutoAssets =>
      'Los activos de la categoría Fondo de emergencia sin otro objetivo cuentan automáticamente.';

  @override
  String get goalsNoAssets => 'Todavía no hay activos asignados';

  @override
  String get goalsNoAssetsToAssign => 'Primero añade activos en Inversiones';

  @override
  String goalsAssignedTo(String goal) {
    return 'Ahora en: $goal';
  }

  @override
  String get goalsMonthlyExpenses => 'Gastos mensuales';

  @override
  String get goalsMonthsCovered => 'Meses de gastos cubiertos';

  @override
  String goalsRecommendedMonths(int min, int max) {
    return 'Recomendado para tu perfil: entre $min y $max meses';
  }

  @override
  String get goalsHomePrice => 'Precio de la vivienda';

  @override
  String get goalsDownPayment => 'Entrada';

  @override
  String get goalsFees => 'Impuestos y gastos';

  @override
  String get goalsFeesHelp =>
      'ITP o IVA, notaría, registro… suelen rondar el 10 %';

  @override
  String get goalsCurrentAge => 'Edad actual';

  @override
  String get goalsRetirementAge => 'Edad de jubilación';

  @override
  String get goalsMonthlySpending => 'Gasto mensual en la jubilación';

  @override
  String get goalsMonthlySpendingHelp => 'En euros de hoy';

  @override
  String get goalsRetirementRule =>
      'Objetivo calculado con la regla del 4 % (gasto anual × 25)';

  @override
  String goalsInvalidAge(int min, int max) {
    return 'Introduce una edad entre $min y $max';
  }

  @override
  String get goalsFieldName => 'Nombre';

  @override
  String get goalsTargetAmount => 'Importe objetivo';

  @override
  String get goalsComputedTarget => 'Objetivo';

  @override
  String get goalsDeleteTitle => '¿Eliminar este objetivo?';

  @override
  String get goalsDeleteBody =>
      'Sus activos no se eliminan; solo dejan de estar asignados.';

  @override
  String get goalsProjectionTitle => 'Proyección hasta la jubilación';

  @override
  String goalsProjectionValue(String amount) {
    return 'Valor proyectado: $amount';
  }

  @override
  String goalsProjectionContributed(String amount) {
    return 'Capital aportado: $amount';
  }

  @override
  String goalsProjectionAssumption(String amount) {
    return 'Suponiendo que aportas $amount al mes con la rentabilidad esperada.';
  }

  @override
  String get dashboardNetWorth => 'Patrimonio total';

  @override
  String get dashboardAllocation => 'Reparto por categoría';

  @override
  String get dashboardNoInvestments =>
      'Añade tu primera inversión para ver tu reparto';

  @override
  String get dashboardTipOfTheDay => 'Consejo del día';

  @override
  String investmentsEmergencyWarning(String current, String target) {
    return 'Tu fondo de emergencia aún no está completo ($current de $target). Lo habitual es completarlo antes de invertir en activos con más riesgo, pero puedes continuar igualmente.';
  }

  @override
  String get learnRecommended => 'Recomendado para ti';

  @override
  String learnMinutes(int minutes) {
    return '$minutes min de lectura';
  }

  @override
  String get learnMarkRead => 'Marcar como leída';

  @override
  String get learnRead => 'Lección leída';

  @override
  String get learnTakeQuiz => 'Hacer el test';

  @override
  String get learnQuizRetake => 'Repetir';

  @override
  String get learnQuizPassedShort => 'Test superado';

  @override
  String get learnQuizTitle => 'Test';

  @override
  String get learnQuizCheck => 'Comprobar';

  @override
  String get learnQuizRetry => 'Volver a intentarlo';

  @override
  String get learnBackToLesson => 'Volver a la lección';

  @override
  String learnQuizScore(int correct, int total) {
    return '$correct de $total correctas';
  }

  @override
  String get learnQuizPassed => '¡Perfecto! Has superado el test.';

  @override
  String get learnQuizFailed =>
      'Revisa las respuestas marcadas y vuelve a intentarlo.';

  @override
  String learnProgress(int read, int total) {
    return 'Has leído $read de $total lecciones';
  }

  @override
  String get learnLessonsTab => 'Lecciones';

  @override
  String get learnTipsTab => 'Consejos rápidos';

  @override
  String get profilePreferences => 'Preferencias';

  @override
  String get profileYourData => 'Tus datos';

  @override
  String get profileLanguage => 'Idioma';

  @override
  String get profileTheme => 'Tema';

  @override
  String get profileThemeSystem => 'Según el sistema';

  @override
  String get profileThemeLight => 'Claro';

  @override
  String get profileThemeDark => 'Oscuro';

  @override
  String get profileExport => 'Exportar copia de seguridad';

  @override
  String get profileExportSubtitle =>
      'Guarda o comparte un archivo con todos tus datos';

  @override
  String get profileExportError => 'No se ha podido exportar la copia';

  @override
  String get profileImport => 'Importar copia de seguridad';

  @override
  String get profileImportSubtitle => 'Restaura tus datos desde un archivo';

  @override
  String get profileImportConfirmTitle => '¿Reemplazar todos tus datos?';

  @override
  String get profileImportConfirmBody =>
      'Los datos actuales se borrarán y se sustituirán por los de la copia. Esta acción no se puede deshacer.';

  @override
  String get profileImportConfirm => 'Reemplazar';

  @override
  String get profileImportDone => 'Copia importada';

  @override
  String get profileImportError =>
      'El archivo no es una copia válida de la app. No se ha cambiado nada.';

  @override
  String get profileDeleteAll => 'Borrar todos los datos';

  @override
  String get profileDeleteAllSubtitle =>
      'Perfil, objetivos, inversiones y progreso';

  @override
  String get profileDeleteAllTitle => '¿Borrar todos los datos?';

  @override
  String get profileDeleteAllBody =>
      'Se borrarán tu perfil, tus objetivos, tus inversiones y tu progreso. Si quieres conservarlos, exporta antes una copia. Esta acción no se puede deshacer.';

  @override
  String get profileDeleteAllConfirm => 'Borrar todo';

  @override
  String get profileInformation => 'Información';

  @override
  String get profileAbout => 'Acerca de';

  @override
  String get profileAboutBody =>
      'Aplicación educativa para organizar tus finanzas y aprender a invertir. Funciona sin conexión: tus datos se guardan solo en tu dispositivo y no se envían a ningún servidor.';

  @override
  String get profileLegalSimulations =>
      'Las simulaciones de rentabilidad son orientativas, se basan en las hipótesis que tú introduces y no garantizan resultados. Los perfiles, rangos y porcentajes que muestra la app son indicativos y no tienen en cuenta toda tu situación personal.';

  @override
  String get goalsEmptyTitle => 'Aún no tienes objetivos';

  @override
  String get goalsEmptyBody =>
      'Crea uno para saber cuánto necesitas y cuánto aportar cada mes.';

  @override
  String goalsProgressSemantics(String goal) {
    return 'Progreso de $goal';
  }

  @override
  String get goalsCompleted => 'Objetivo completado';
}
