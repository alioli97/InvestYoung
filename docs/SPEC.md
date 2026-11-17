# Functional specification — Invertir siendo Joven

## 1. Vision

Mobile app (Flutter) that helps young people organize their finances and start investing sensibly:
emergency fund first, then goals (housing, retirement) and investments.
Languages: **Spanish and Catalan** (UI). Currency: **euro**. Data: **local only**.

## 2. Navigation

Bottom navigation bar with 5 tabs:

1. **Home**: overall summary.
2. **Goals**: emergency fund, housing, retirement and custom goals.
3. **Investments**: Emergency Fund, Fixed Income, Equities and Crypto.
4. **Learn**: lessons and tips.
5. **Profile**: settings.

If onboarding has not been completed, the app opens onboarding instead of the bottom navigation.

## 3. Onboarding: goals questionnaire

Step-by-step flow (one question or group per screen), with a progress bar and a Back button.

0. **Language**: Spanish or Catalan (preselected from the device locale).
1. **Welcome and legal notice**: must be accepted to continue.
2. **Personal situation**
   - Age range: 16–20, 21–25, 26–30, 31–35, 35+.
   - Employment: permanent, temporary, self-employed, student, unemployed.
   - Net monthly income (optional).
   - Dependents (yes/no).
   - High-interest debt (credit cards, personal loans): yes/no, optional amount.
3. **Monthly expenses** by category, amounts in euros (can be 0): housing (rent or mortgage,
   utilities), food, transport, insurance, subscriptions, other fixed expenses.
   The total is shown live.
4. **Risk tolerance**: 4 multiple-choice questions, each answer worth 1–3 points.
   Example: "If your investment drops 20% in a month…" → sell everything (1) / wait (2) / invest more (3).
5. **Goals** (multi-select): emergency fund (always on), house down payment, retirement,
   other (free-text name).
6. **Prior knowledge**: none, basic or intermediate.
7. **Result**
   - Risk profile from the score: conservative (4–6), moderate (7–9), aggressive (10–12).
   - Emergency fund range in months:
     - **6–12 months** if the profile is conservative **or** employment is temporary, self-employed
       or unemployed **or** the user has dependents.
     - **3–6 months** otherwise.
   - Emergency fund target = total monthly expenses × months (show min and max; the user picks
     a value within the range with a slider, defaulting to the rounded midpoint).
   - If the user has high-interest debt: warning "Prioritize paying off this debt before investing".
   - Recommended lessons based on the knowledge level.
   - On confirm, the `UserProfile` and the selected `Goal`s are created.

The questionnaire can be retaken from Profile. Retaking it updates the profile and the emergency
goal, but never deletes existing investments or goals.

## 4. Home (dashboard)

- Total net worth (sum of the current value of all assets).
- Emergency fund progress card. If not complete, it is shown first and highlighted.
- Progress cards for the other goals.
- Pie chart with the allocation by investment category.
- Tip of the day (rotates through the Learn tips).
- If the emergency fund is not complete and the user adds an Equities or Crypto asset,
  show an informative (non-blocking) warning.

## 5. Goals

Each goal has: name, type, target amount, target date (optional for the emergency fund),
expected annual return, assigned assets and progress (% and amount).

### 5.1 Emergency fund
Created automatically from the questionnaire result. Its progress is the sum of the assets in the
*Emergency Fund* category (plus any other asset assigned to this goal).

### 5.2 House down payment
- Inputs: home price, down payment % (default 20%), taxes and fees % (default 10%, editable),
  target date.
- Target amount = price × (down payment % + fees %).
- Shows the required monthly contribution until the target date (formula in §8).

### 5.3 Retirement
- Inputs: current age, retirement age (default 67), expected monthly spending,
  expected annual return (default 5%, editable).
- Target capital = monthly spending × 12 × 25 (4% rule).
- Shows the required monthly contribution and a chart of the projected growth
  (compound interest) vs. contributed capital.
- Fixed text: "Indicative simulation, results are not guaranteed".

### 5.4 Custom
Name, target amount, target date and expected return (default 0%).

## 6. Investments

Main screen with the 4 categories (total and change for each) → category screen →
asset list → asset detail with its transactions.

| Category | Examples | Specific fields |
|---|---|---|
| Emergency Fund | high-yield savings account, deposit, money market fund | institution, APY |
| Fixed Income | Spanish T-bills (Letras del Tesoro), bonds, bond funds | issuer, yield or coupon %, maturity date |
| Equities | index fund, ETF, stock | ticker or ISIN, subtype |
| Crypto | BTC, ETH… | symbol, exchange or wallet |

**Common asset fields:** name, category, assigned goal (optional), notes, created date.

**Transactions:**
- `deposit`: contribution (amount).
- `withdrawal`: withdrawal (amount).
- `buy`: purchase (amount, quantity, fee).
- `sell`: sale (amount, quantity, fee).
- `income`: dividend, coupon or interest (amount).
- `valuation`: manual update of the current value (total amount).

**Per-asset metrics:**
- Net contributed capital = deposits + buys − withdrawals − sells.
- Current value = latest `valuation`; if there is none, the net contributed capital.
- Return = current value + income − net contributed capital (in € and %).
- Equities and Crypto: holdings = Σ buy quantities − Σ sell quantities, plus average purchase price.

## 7. Learn

- Modules with Markdown lessons (`assets/learn/{es,ca}/`), indexed in `assets/learn/index.json`.
- Each lesson: title, reading time, content and a 2–3 question quiz (defined in the JSON).
- Saved progress: lesson read, quiz passed.
- "Quick tips" tab: short tips, also used for the Home tip of the day.

Initial modules:
1. Fundamentals: 50/30/20 budget, inflation, compound interest.
2. Emergency fund.
3. Debt.
4. Fixed income.
5. Equities: diversification, index funds, dollar-cost averaging (DCA).
6. Crypto: risks, volatility, custody.
7. Basic taxation in Spain.
8. Investor psychology.

## 8. Formulas (core/utils/finance.dart)

- `emergencyFundTarget(monthlyExpenses, months)` = expenses × months.
- `requiredMonthlyContribution(target, current, annualRate, months)`:
  - r = (1 + annualRate)^(1/12) − 1
  - FV of current capital = current × (1 + r)^n
  - If r = 0: (target − FVcurrent) / n
  - Otherwise: (target − FVcurrent) × r / ((1 + r)^n − 1)
  - Clamped to a minimum of 0.
- `retirementTarget(monthlyExpense)` = monthlyExpense × 12 × 25.
- `projectGrowth(current, monthly, annualRate, months)` → monthly series for the chart.

All of them take and return cents (`int`), using `double` only for intermediate calculations.
They have unit tests, including edge cases (n = 0, r = 0, goal already reached).

## 9. Profile

- Language (es/ca).
- Theme: system, light or dark.
- Retake the questionnaire.
- Export backup (JSON with every table plus a `schemaVersion`) via share/save.
- Import backup (with confirmation: replaces all data).
- Delete all data.
- Legal notice and About.

## 10. Data model (Drift)

- `user_profiles`: id, age_range, employment, monthly_income_cents?, has_dependents,
  has_high_interest_debt, debt_cents?, risk_score, risk_profile, knowledge_level,
  emergency_months, locale, onboarding_completed_at.
- `monthly_expenses`: id, category, amount_cents.
- `goals`: id, type (emergency|housing|retirement|custom), name, target_cents, target_date?,
  expected_annual_return (REAL), params_json (type-specific inputs), created_at.
- `assets`: id, category (emergency|fixed_income|equity|crypto), name, goal_id?, metadata_json,
  notes?, created_at, archived.
- `transactions`: id, asset_id, type (deposit|withdrawal|buy|sell|income|valuation), date,
  amount_cents, quantity (TEXT Decimal)?, fee_cents?, note?.
- `lesson_progress`: lesson_id, read_at?, quiz_passed_at?.

## 11. Out of scope for the MVP

Login, cloud sync, automatic prices via API, recurring contribution reminders, CSV export,
biometric/PIN lock. Planned for later phases (see ROADMAP).
