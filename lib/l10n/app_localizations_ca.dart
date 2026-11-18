// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'Invertir sent Jove';

  @override
  String get navHome => 'Inici';

  @override
  String get navGoals => 'Objectius';

  @override
  String get navInvestments => 'Inversions';

  @override
  String get navLearn => 'Aprendre';

  @override
  String get navProfile => 'Perfil';

  @override
  String get dashboardTitle => 'Inici';

  @override
  String get goalsTitle => 'Objectius';

  @override
  String get investmentsTitle => 'Inversions';

  @override
  String get learnTitle => 'Aprendre';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get onboardingWelcomeTitle => 'Benvingut/da';

  @override
  String get onboardingWelcomeBody =>
      'Organitza les teves finances i comença a invertir amb seny.';

  @override
  String get commonComingSoon => 'Properament';

  @override
  String get commonSimulationDisclaimer =>
      'Simulació orientativa, els resultats no estan garantits';

  @override
  String get commonBack => 'Enrere';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonYes => 'Sí';

  @override
  String get commonNo => 'No';

  @override
  String get commonOptional => 'Opcional';

  @override
  String get commonInvalidAmount => 'Introdueix un import vàlid';

  @override
  String get commonLegalNoticeTitle => 'Avís legal';

  @override
  String get commonLegalNoticeBody =>
      'Invertir sent Jove és una aplicació educativa. La informació, els perfils, els rangs i les simulacions que mostra són orientatius i no constitueixen assessorament financer ni una recomanació personalitzada d\'inversió, activitat regulada a Espanya per la Comissió Nacional del Mercat de Valors (CNMV).\n\nInvertir comporta riscos, inclosa la pèrdua del capital invertit, i les rendibilitats passades no garanteixen rendibilitats futures. Abans de prendre decisions d\'inversió, informa\'t bé i, si cal, consulta un professional autoritzat.\n\nLes teves dades es desen només al teu dispositiu.';

  @override
  String onboardingStepCounter(int current, int total) {
    return 'Pas $current de $total';
  }

  @override
  String get onboardingLanguageTitle => 'Tria el teu idioma';

  @override
  String get onboardingLanguageSpanish => 'Castellà';

  @override
  String get onboardingLanguageCatalan => 'Català';

  @override
  String get onboardingLegalAccept => 'He llegit i accepto l\'avís legal';

  @override
  String get onboardingSituationTitle => 'La teva situació';

  @override
  String get onboardingAgeRange => 'Edat';

  @override
  String get onboardingAge16To20 => '16–20';

  @override
  String get onboardingAge21To25 => '21–25';

  @override
  String get onboardingAge26To30 => '26–30';

  @override
  String get onboardingAge31To35 => '31–35';

  @override
  String get onboardingAgeOver35 => 'Més de 35';

  @override
  String get onboardingEmployment => 'Situació laboral';

  @override
  String get onboardingEmploymentPermanent => 'Contracte indefinit';

  @override
  String get onboardingEmploymentTemporary => 'Contracte temporal';

  @override
  String get onboardingEmploymentSelfEmployed => 'Autònom/a';

  @override
  String get onboardingEmploymentStudent => 'Estudiant';

  @override
  String get onboardingEmploymentUnemployed => 'A l\'atur';

  @override
  String get onboardingIncome => 'Ingressos nets mensuals';

  @override
  String get onboardingDependents => 'Tens persones al teu càrrec?';

  @override
  String get onboardingDebt =>
      'Tens deutes amb interessos alts? (targetes de crèdit, préstecs personals)';

  @override
  String get onboardingDebtAmount => 'Import pendent';

  @override
  String get onboardingExpensesTitle => 'Les teves despeses mensuals';

  @override
  String get onboardingExpensesSubtitle =>
      'Aproximat ja està bé. Deixa en blanc el que no tinguis.';

  @override
  String get onboardingExpenseHousing =>
      'Habitatge (lloguer o hipoteca, subministraments)';

  @override
  String get onboardingExpenseFood => 'Alimentació';

  @override
  String get onboardingExpenseTransport => 'Transport';

  @override
  String get onboardingExpenseInsurance => 'Assegurances';

  @override
  String get onboardingExpenseSubscriptions => 'Subscripcions';

  @override
  String get onboardingExpenseOtherFixed => 'Altres despeses fixes';

  @override
  String onboardingExpensesTotal(String amount) {
    return 'Total: $amount al mes';
  }

  @override
  String get onboardingRiskTitle => 'La teva tolerància al risc';

  @override
  String get onboardingRiskQ1 => 'Si la teva inversió cau un 20 % en un mes…';

  @override
  String get onboardingRiskQ1A1 => 'Ho venc tot';

  @override
  String get onboardingRiskQ1A2 => 'Espero que es recuperi';

  @override
  String get onboardingRiskQ1A3 => 'Hi inverteixo més aprofitant la baixada';

  @override
  String get onboardingRiskQ2 => 'Quan creus que necessitaràs aquests diners?';

  @override
  String get onboardingRiskQ2A1 => 'En menys de 2 anys';

  @override
  String get onboardingRiskQ2A2 => 'Entre 2 i 5 anys';

  @override
  String get onboardingRiskQ2A3 => 'En més de 5 anys';

  @override
  String get onboardingRiskQ3 => 'Què prefereixes?';

  @override
  String get onboardingRiskQ3A1 => 'Guanyar poc, però amb seguretat';

  @override
  String get onboardingRiskQ3A2 =>
      'Assumir una mica de risc per una mica més de rendibilitat';

  @override
  String get onboardingRiskQ3A3 =>
      'Assumir molt de risc per la possibilitat de guanyar molt';

  @override
  String get onboardingRiskQ4 =>
      'Com et sentiries veient la teva inversió en negatiu durant un any?';

  @override
  String get onboardingRiskQ4A1 => 'Molt intranquil/a, em trauria la son';

  @override
  String get onboardingRiskQ4A2 => 'Incòmode/a, però ho aguantaria';

  @override
  String get onboardingRiskQ4A3 =>
      'Tranquil/a, és part d\'invertir a llarg termini';

  @override
  String get onboardingGoalsTitle => 'Els teus objectius';

  @override
  String get onboardingGoalsSubtitle =>
      'En pots triar diversos. Els podràs ajustar més endavant.';

  @override
  String get onboardingGoalEmergency => 'Fons d\'emergència';

  @override
  String get onboardingGoalEmergencyHint => 'Sempre és el primer pas';

  @override
  String get onboardingGoalHousing => 'Entrada d\'un habitatge';

  @override
  String get onboardingGoalRetirement => 'Jubilació';

  @override
  String get onboardingGoalOther => 'Un altre';

  @override
  String get onboardingGoalOtherName => 'Nom de l\'objectiu';

  @override
  String get onboardingKnowledgeTitle => 'Quant en saps, d\'inversió?';

  @override
  String get onboardingKnowledgeNone => 'Res, començo de zero';

  @override
  String get onboardingKnowledgeBasic => 'El bàsic';

  @override
  String get onboardingKnowledgeIntermediate => 'Nivell intermedi';

  @override
  String get onboardingResultTitle => 'El teu punt de partida';

  @override
  String get onboardingResultRiskProfile => 'Perfil de risc';

  @override
  String get onboardingRiskProfileConservative => 'Conservador';

  @override
  String get onboardingRiskProfileModerate => 'Moderat';

  @override
  String get onboardingRiskProfileAggressive => 'Dinàmic';

  @override
  String get onboardingRiskProfileConservativeDesc =>
      'Prioritzes l\'estabilitat i et incomoden les caigudes.';

  @override
  String get onboardingRiskProfileModerateDesc =>
      'Acceptes una mica de volatilitat a canvi de més rendibilitat potencial.';

  @override
  String get onboardingRiskProfileAggressiveDesc =>
      'Toleres bé les caigudes i penses a llarg termini.';

  @override
  String get onboardingResultEmergencyTitle => 'Fons d\'emergència';

  @override
  String onboardingResultEmergencyRange(
    int min,
    int max,
    String minAmount,
    String maxAmount,
  ) {
    return 'Et recomanem cobrir entre $min i $max mesos de despeses: de $minAmount a $maxAmount.';
  }

  @override
  String onboardingResultMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months mesos',
      one: '1 mes',
    );
    return '$_temp0';
  }

  @override
  String onboardingResultTarget(String amount) {
    return 'El teu objectiu: $amount';
  }

  @override
  String get onboardingResultNoExpenses =>
      'No has indicat despeses, així que l\'objectiu és 0 €. El podràs canviar més endavant.';

  @override
  String get onboardingResultDebtWarning =>
      'Prioritza pagar aquest deute abans d\'invertir';

  @override
  String get onboardingResultLessons => 'Et recomanem començar per';

  @override
  String get onboardingConfirm => 'Confirmar i començar';

  @override
  String get learnModuleFundamentals => 'Fonaments';

  @override
  String get learnModuleEmergencyFund => 'Fons d\'emergència';

  @override
  String get learnModuleDebt => 'Deutes';

  @override
  String get learnModuleFixedIncome => 'Renda fixa';

  @override
  String get learnModuleEquities => 'Renda variable';

  @override
  String get learnModuleCrypto => 'Criptomonedes';

  @override
  String get learnModuleTaxes => 'Fiscalitat bàsica a Espanya';

  @override
  String get learnModulePsychology => 'Psicologia de l\'inversor';

  @override
  String get commonSaveError =>
      'No s\'han pogut desar les dades. Torna-ho a provar.';

  @override
  String get commonClose => 'Tancar';

  @override
  String get profileRetakeQuestionnaire => 'Repetir el qüestionari';

  @override
  String get profileRetakeQuestionnaireSubtitle =>
      'Actualitza el teu perfil i el teu fons d\'emergència';

  @override
  String get profileRetakeSaved => 'Perfil actualitzat';

  @override
  String get commonLoadError => 'No s\'han pogut carregar les dades.';

  @override
  String get investmentsTotalValue => 'Valor total';

  @override
  String get investmentsCategoryEmergency => 'Fons d\'emergència';

  @override
  String get investmentsCategoryFixedIncome => 'Renda fixa';

  @override
  String get investmentsCategoryEquity => 'Renda variable';

  @override
  String get investmentsCategoryCrypto => 'Criptomonedes';

  @override
  String get investmentsCategoryEmergencyExamples =>
      'Comptes remunerats, dipòsits, fons monetaris';

  @override
  String get investmentsCategoryFixedIncomeExamples =>
      'Lletres del Tresor, bons, fons de renda fixa';

  @override
  String get investmentsCategoryEquityExamples => 'Fons indexats, ETF, accions';

  @override
  String get investmentsCategoryCryptoExamples => 'BTC, ETH…';

  @override
  String get commonSave => 'Desar';

  @override
  String get commonCancel => 'Cancel·lar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonClear => 'Esborrar';

  @override
  String get commonRequired => 'Camp obligatori';

  @override
  String get commonInvalidNumber => 'Introdueix un número vàlid';

  @override
  String get investmentsAddAsset => 'Afegir actiu';

  @override
  String get investmentsNewAsset => 'Nou actiu';

  @override
  String get investmentsEditAsset => 'Editar actiu';

  @override
  String get investmentsEmptyCategory =>
      'Encara no tens res en aquesta categoria';

  @override
  String get investmentsFieldName => 'Nom';

  @override
  String get investmentsFieldInstitution => 'Entitat';

  @override
  String get investmentsFieldApy => 'Rendibilitat anual (TAE)';

  @override
  String get investmentsFieldIssuer => 'Emissor';

  @override
  String get investmentsFieldYield => 'Rendibilitat o cupó anual';

  @override
  String get investmentsFieldMaturity => 'Data de venciment';

  @override
  String get investmentsFieldTicker => 'Ticker o ISIN';

  @override
  String get investmentsFieldSubtype => 'Tipus';

  @override
  String get investmentsFieldSymbol => 'Símbol';

  @override
  String get investmentsFieldExchange => 'Exchange o wallet';

  @override
  String get investmentsFieldGoal => 'Objectiu assignat';

  @override
  String get investmentsNoGoal => 'Cap';

  @override
  String get investmentsFieldNotes => 'Notes';

  @override
  String get investmentsSubtypeIndexFund => 'Fons indexat';

  @override
  String get investmentsSubtypeEtf => 'ETF';

  @override
  String get investmentsSubtypeStock => 'Acció';

  @override
  String get investmentsSubtypeOther => 'Altre';

  @override
  String investmentsApyShort(String rate) {
    return '$rate TAE';
  }

  @override
  String investmentsMaturityShort(String date) {
    return 'venç $date';
  }

  @override
  String get investmentsDeleteAssetTitle => 'Vols eliminar aquest actiu?';

  @override
  String get investmentsDeleteAssetBody =>
      'També se n\'eliminaran tots els moviments. Aquesta acció no es pot desfer.';

  @override
  String get investmentsCurrentValue => 'Valor actual';

  @override
  String get investmentsTransactions => 'Moviments';

  @override
  String get investmentsNoTransactions =>
      'Encara no hi ha moviments. Afegeix la teva primera aportació o compra.';

  @override
  String get investmentsAddTransaction => 'Afegir moviment';

  @override
  String get investmentsNewTransaction => 'Nou moviment';

  @override
  String get investmentsEditTransaction => 'Editar moviment';

  @override
  String get investmentsDeleteTransactionTitle =>
      'Vols eliminar aquest moviment?';

  @override
  String get investmentsTxDeposit => 'Aportació';

  @override
  String get investmentsTxWithdrawal => 'Retirada';

  @override
  String get investmentsTxBuy => 'Compra';

  @override
  String get investmentsTxSell => 'Venda';

  @override
  String get investmentsTxIncome => 'Dividend, cupó o interès';

  @override
  String get investmentsTxValuation => 'Actualitzar valor';

  @override
  String get investmentsTxAmountDeposit => 'Import aportat';

  @override
  String get investmentsTxAmountWithdrawal => 'Import retirat';

  @override
  String get investmentsTxAmountBuy => 'Import invertit';

  @override
  String get investmentsTxAmountSell => 'Import rebut';

  @override
  String get investmentsTxAmountIncome => 'Import cobrat';

  @override
  String get investmentsTxAmountValuation => 'Valor total actual';

  @override
  String get investmentsValuationHint =>
      'Indica quant val avui tot aquest actiu. S\'utilitzarà com a valor actual.';

  @override
  String get investmentsFieldDate => 'Data';

  @override
  String get investmentsFieldQuantity => 'Unitats o participacions';

  @override
  String get investmentsFieldFee => 'Comissió';

  @override
  String get investmentsFieldNote => 'Nota';

  @override
  String get investmentsAmountPositive => 'L\'import ha de ser més gran que 0';

  @override
  String investmentsSellTooMuch(String available) {
    return 'Només tens $available unitats';
  }

  @override
  String investmentsUnits(String quantity) {
    return '$quantity u.';
  }

  @override
  String get investmentsNetContributed => 'Capital aportat';

  @override
  String investmentsContributedShort(String amount) {
    return 'Aportat: $amount';
  }

  @override
  String get investmentsIncome => 'Dividends, cupons i interessos';

  @override
  String get investmentsReturn => 'Rendibilitat';

  @override
  String get investmentsHoldings => 'Unitats';

  @override
  String get investmentsAveragePrice => 'Preu mitjà de compra';

  @override
  String get investmentsReturnExplanation =>
      'Rendibilitat = valor actual + ingressos − capital aportat. Les comissions compten com a capital aportat.';

  @override
  String get goalsAddGoal => 'Nou objectiu';

  @override
  String get goalsNewGoal => 'Nou objectiu';

  @override
  String get goalsEditGoal => 'Editar objectiu';

  @override
  String get goalsCustomGoal => 'Objectiu personalitzat';

  @override
  String goalsProgressAmounts(String current, String target) {
    return '$current de $target';
  }

  @override
  String get goalsNoTarget => 'Encara no has definit l\'import objectiu';

  @override
  String get goalsSetUpPrompt =>
      'Configura aquest objectiu per calcular quant necessites';

  @override
  String get goalsRemaining => 'Et falta';

  @override
  String get goalsTargetDate => 'Data objectiu';

  @override
  String get goalsExpectedReturn => 'Rendibilitat anual esperada';

  @override
  String get goalsExpectedReturnHelp =>
      'Estimació orientativa; fes servir 0 % si els diners no s\'inverteixen';

  @override
  String get goalsRequiredMonthly => 'Aportació mensual necessària';

  @override
  String goalsMonthsLeft(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Queden $months mesos',
      one: 'Queda 1 mes',
    );
    return '$_temp0';
  }

  @override
  String get goalsDatePassed => 'La data objectiu ja ha arribat';

  @override
  String get goalsAssignedAssets => 'Actius de l\'objectiu';

  @override
  String get goalsAssignAssets => 'Assignar actius';

  @override
  String get goalsEmergencyAutoAssets =>
      'Els actius de la categoria Fons d\'emergència sense cap altre objectiu compten automàticament.';

  @override
  String get goalsNoAssets => 'Encara no hi ha actius assignats';

  @override
  String get goalsNoAssetsToAssign => 'Primer afegeix actius a Inversions';

  @override
  String goalsAssignedTo(String goal) {
    return 'Ara a: $goal';
  }

  @override
  String get goalsMonthlyExpenses => 'Despeses mensuals';

  @override
  String get goalsMonthsCovered => 'Mesos de despeses coberts';

  @override
  String goalsRecommendedMonths(int min, int max) {
    return 'Recomanat per al teu perfil: entre $min i $max mesos';
  }

  @override
  String get goalsHomePrice => 'Preu de l\'habitatge';

  @override
  String get goalsDownPayment => 'Entrada';

  @override
  String get goalsFees => 'Impostos i despeses';

  @override
  String get goalsFeesHelp =>
      'ITP o IVA, notaria, registre… solen rondar el 10 %';

  @override
  String get goalsCurrentAge => 'Edat actual';

  @override
  String get goalsRetirementAge => 'Edat de jubilació';

  @override
  String get goalsMonthlySpending => 'Despesa mensual a la jubilació';

  @override
  String get goalsMonthlySpendingHelp => 'En euros d\'avui';

  @override
  String get goalsRetirementRule =>
      'Objectiu calculat amb la regla del 4 % (despesa anual × 25)';

  @override
  String goalsInvalidAge(int min, int max) {
    return 'Introdueix una edat entre $min i $max';
  }

  @override
  String get goalsFieldName => 'Nom';

  @override
  String get goalsTargetAmount => 'Import objectiu';

  @override
  String get goalsComputedTarget => 'Objectiu';

  @override
  String get goalsDeleteTitle => 'Vols eliminar aquest objectiu?';

  @override
  String get goalsDeleteBody =>
      'Els seus actius no s\'eliminen; només deixen d\'estar assignats.';

  @override
  String get goalsProjectionTitle => 'Projecció fins a la jubilació';

  @override
  String goalsProjectionValue(String amount) {
    return 'Valor projectat: $amount';
  }

  @override
  String goalsProjectionContributed(String amount) {
    return 'Capital aportat: $amount';
  }

  @override
  String goalsProjectionAssumption(String amount) {
    return 'Suposant que aportes $amount al mes amb la rendibilitat esperada.';
  }

  @override
  String get dashboardNetWorth => 'Patrimoni total';

  @override
  String get dashboardAllocation => 'Repartiment per categoria';

  @override
  String get dashboardNoInvestments =>
      'Afegeix la teva primera inversió per veure\'n el repartiment';

  @override
  String get dashboardTipOfTheDay => 'Consell del dia';

  @override
  String investmentsEmergencyWarning(String current, String target) {
    return 'El teu fons d\'emergència encara no és complet ($current de $target). El més habitual és completar-lo abans d\'invertir en actius amb més risc, però pots continuar igualment.';
  }

  @override
  String get learnRecommended => 'Recomanat per a tu';

  @override
  String learnMinutes(int minutes) {
    return '$minutes min de lectura';
  }

  @override
  String get learnMarkRead => 'Marcar com a llegida';

  @override
  String get learnRead => 'Lliçó llegida';

  @override
  String get learnTakeQuiz => 'Fer el test';

  @override
  String get learnQuizRetake => 'Repetir';

  @override
  String get learnQuizPassedShort => 'Test superat';

  @override
  String get learnQuizTitle => 'Test';

  @override
  String get learnQuizCheck => 'Comprovar';

  @override
  String get learnQuizRetry => 'Tornar-ho a provar';

  @override
  String get learnBackToLesson => 'Tornar a la lliçó';

  @override
  String learnQuizScore(int correct, int total) {
    return '$correct de $total correctes';
  }

  @override
  String get learnQuizPassed => 'Perfecte! Has superat el test.';

  @override
  String get learnQuizFailed =>
      'Revisa les respostes marcades i torna-ho a provar.';

  @override
  String learnProgress(int read, int total) {
    return 'Has llegit $read de $total lliçons';
  }

  @override
  String get learnLessonsTab => 'Lliçons';

  @override
  String get learnTipsTab => 'Consells ràpids';

  @override
  String get profilePreferences => 'Preferències';

  @override
  String get profileYourData => 'Les teves dades';

  @override
  String get profileLanguage => 'Idioma';

  @override
  String get profileTheme => 'Tema';

  @override
  String get profileThemeSystem => 'Segons el sistema';

  @override
  String get profileThemeLight => 'Clar';

  @override
  String get profileThemeDark => 'Fosc';

  @override
  String get profileExport => 'Exportar còpia de seguretat';

  @override
  String get profileExportSubtitle =>
      'Desa o comparteix un fitxer amb totes les teves dades';

  @override
  String get profileExportError => 'No s\'ha pogut exportar la còpia';

  @override
  String get profileImport => 'Importar còpia de seguretat';

  @override
  String get profileImportSubtitle =>
      'Restaura les teves dades des d\'un fitxer';

  @override
  String get profileImportConfirmTitle =>
      'Vols substituir totes les teves dades?';

  @override
  String get profileImportConfirmBody =>
      'Les dades actuals s\'esborraran i se substituiran per les de la còpia. Aquesta acció no es pot desfer.';

  @override
  String get profileImportConfirm => 'Substituir';

  @override
  String get profileImportDone => 'Còpia importada';

  @override
  String get profileImportError =>
      'El fitxer no és una còpia vàlida de l\'app. No s\'ha canviat res.';

  @override
  String get profileDeleteAll => 'Esborrar totes les dades';

  @override
  String get profileDeleteAllSubtitle =>
      'Perfil, objectius, inversions i progrés';

  @override
  String get profileDeleteAllTitle => 'Vols esborrar totes les dades?';

  @override
  String get profileDeleteAllBody =>
      'S\'esborraran el teu perfil, els teus objectius, les teves inversions i el teu progrés. Si els vols conservar, exporta abans una còpia. Aquesta acció no es pot desfer.';

  @override
  String get profileDeleteAllConfirm => 'Esborrar-ho tot';

  @override
  String get profileInformation => 'Informació';

  @override
  String get profileAbout => 'Quant a';

  @override
  String get profileAboutBody =>
      'Aplicació educativa per organitzar les teves finances i aprendre a invertir. Funciona sense connexió: les teves dades es desen només al teu dispositiu i no s\'envien a cap servidor.';

  @override
  String get profileLegalSimulations =>
      'Les simulacions de rendibilitat són orientatives, es basen en les hipòtesis que tu introdueixes i no garanteixen resultats. Els perfils, rangs i percentatges que mostra l\'app són indicatius i no tenen en compte tota la teva situació personal.';
}
