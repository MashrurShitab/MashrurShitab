"""
Pulse Fitness SQL Analytics Platform
Updates reports/query_results_and_recommendations.md using generated results/*.csv files.
"""

from __future__ import annotations

import csv
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
RESULTS = ROOT / "results"
REPORT = ROOT / "reports" / "query_results_and_recommendations.md"


def read_csv(name: str) -> list[dict[str, str]]:
    path = RESULTS / name
    if not path.exists():
        return []
    with path.open(newline="", encoding="utf-8-sig") as f:
        return list(csv.DictReader(f))


def as_float(row: dict[str, str], key: str) -> float:
    value = (row.get(key) or "0").replace(",", "")
    try:
        return float(value)
    except ValueError:
        return 0.0


def money(value: float) -> str:
    return f"${value:,.2f}"


def pct(value: float) -> str:
    return f"{value:.2f}%"


def top(rows: list[dict[str, str]], key: str) -> dict[str, str] | None:
    if not rows:
        return None
    return max(rows, key=lambda r: as_float(r, key))


def first(rows: list[dict[str, str]]) -> dict[str, str] | None:
    return rows[0] if rows else None


rows_01 = read_csv("01_membership_revenue.csv")
rows_02 = read_csv("02_revenue_by_location.csv")
rows_03 = read_csv("03_payment_failure_analysis.csv")
rows_04 = read_csv("04_peak_usage_hours.csv")
rows_05 = read_csv("05_class_attendance_rate.csv")
rows_06 = read_csv("06_trainer_utilisation.csv")
rows_07 = read_csv("07_underutilised_members.csv")
rows_08 = read_csv("08_member_segmentation.csv")
rows_09 = read_csv("09_churn_risk_ranking.csv")
rows_10 = read_csv("10_customer_lifetime_value.csv")
rows_11 = read_csv("11_upgrade_opportunity.csv")
rows_12 = read_csv("12_location_efficiency_scorecard.csv")

t1 = top(rows_01, "TotalPaidRevenue")
t2 = top(rows_02, "TotalPaidRevenue")
missed_total = sum(as_float(r, "MissedOrReversedRevenue") for r in rows_03)
t4 = top(rows_04, "VisitCount")
t5_high = top(rows_05, "AttendanceRatePct")
t5_low = min(rows_05, key=lambda r: as_float(r, "AttendanceRatePct")) if rows_05 else None
t6 = top(rows_06, "TotalDeliveredSessions")
underutilised_count = len(rows_07)
segments: dict[str, int] = {}
for r in rows_08:
    segments[r.get("EngagementSegment", "Unknown")] = segments.get(r.get("EngagementSegment", "Unknown"), 0) + 1
t9 = first(rows_09)
t10 = top(rows_10, "LifetimePaidRevenue")
upgrade_count = len(rows_11)
upgrade_total = sum(as_float(r, "EstimatedMonthlyRevenueUplift") for r in rows_11)
t12 = first(rows_12)
all_rows = [
    rows_01,
    rows_02,
    rows_03,
    rows_04,
    rows_05,
    rows_06,
    rows_07,
    rows_08,
    rows_09,
    rows_10,
    rows_11,
    rows_12,
]
has_exported_data = any(all_rows)
intro = (
    "The result CSV files in `results/` contain the exported outputs from the MySQL analysis queries."
    if has_exported_data
    else "Result CSV files are structured as output templates. Final numeric results should be generated after running the SQL scripts in MySQL."
)


def pending_if_empty(rows: list[dict[str, str]], summary: str) -> str:
    return summary if rows else "Pending execution after running the MySQL scripts."


summary_01 = pending_if_empty(
    rows_01,
    f"{t1.get('MembershipType')} generated the highest paid revenue at {money(as_float(t1, 'TotalPaidRevenue'))}."
    if t1
    else "",
)
summary_02 = pending_if_empty(
    rows_02,
    f"{t2.get('LocationName')} was the top revenue branch with {money(as_float(t2, 'TotalPaidRevenue'))}."
    if t2
    else "",
)
summary_03 = pending_if_empty(
    rows_03,
    f"Failed and refunded payments represented {money(missed_total)} in missed or reversed revenue."
)
summary_04 = pending_if_empty(
    rows_04,
    f"{t4.get('LocationName')} had the busiest recorded hour at {t4.get('HourOfDay')}:00 with {int(as_float(t4, 'VisitCount'))} visits."
    if t4
    else "",
)
summary_05 = pending_if_empty(
    rows_05,
    f"{t5_high.get('ClassName')} had the strongest attendance rate at {pct(as_float(t5_high, 'AttendanceRatePct'))}; {t5_low.get('ClassName')} was lowest at {pct(as_float(t5_low, 'AttendanceRatePct'))}."
    if t5_high and t5_low
    else "",
)
summary_06 = pending_if_empty(
    rows_06,
    f"{t6.get('TrainerName')} delivered the most sessions with {int(as_float(t6, 'TotalDeliveredSessions'))} total delivered sessions."
    if t6
    else "",
)
summary_07 = pending_if_empty(
    rows_07,
    f"{underutilised_count} active paying members had fewer than three visits in the last 60 days."
)
summary_08 = pending_if_empty(
    rows_08,
    "; ".join(f"{segment}: {count}" for segment, count in sorted(segments.items()))
)
summary_09 = pending_if_empty(
    rows_09,
    f"{t9.get('FullName')} ranked highest for churn risk with a score of {t9.get('ChurnRiskScore')} ({t9.get('RiskBand')})."
    if t9
    else "",
)
summary_10 = pending_if_empty(
    rows_10,
    f"{t10.get('FullName')} generated the highest lifetime paid revenue at {money(as_float(t10, 'LifetimePaidRevenue'))}."
    if t10
    else "",
)
summary_11 = pending_if_empty(
    rows_11,
    f"{upgrade_count} Basic or Student members qualified for upgrade targeting, with estimated monthly uplift of {money(upgrade_total)}."
)
summary_12 = pending_if_empty(
    rows_12,
    f"{t12.get('LocationName')} ranked #1 on the location efficiency scorecard."
    if t12
    else "",
)

content = f"""# Query Results and Recommendations

{intro}

Default analysis period: `2025-01-01` to `2025-06-30`.

| # | Business Question | Difficulty | Result Summary | Business Insight | Management Recommendation | SQL | Result |
|---:|---|---|---|---|---|---|---|
| 1 | Which membership types generated the most paid revenue? | Basic | {summary_01} | Identifies which plans contribute most to recurring revenue. | Review plan pricing and campaign focus by revenue contribution. | `analysis/01_membership_revenue.sql` | `results/01_membership_revenue.csv` |
| 2 | Which gym branches generated the highest paid revenue? | Basic | {summary_02} | Shows branch-level revenue concentration. | Allocate resources and campaigns based on branch performance. | `analysis/02_revenue_by_location.sql` | `results/02_revenue_by_location.csv` |
| 3 | How much revenue was lost due to failed or refunded payments? | Basic to Intermediate | {summary_03} | Quantifies payment leakage and recovery opportunity. | Implement payment retry and member notification workflows. | `analysis/03_payment_failure_analysis.sql` | `results/03_payment_failure_analysis.csv` |
| 4 | What are the busiest check-in hours by location? | Intermediate | {summary_04} | Reveals peak operating windows. | Align staffing, cleaning, and equipment checks with demand. | `analysis/04_peak_usage_hours.sql` | `results/04_peak_usage_hours.csv` |
| 5 | Which classes have the highest and lowest attendance rates? | Intermediate | {summary_05} | Separates bookings from actual attendance. | Expand high-attendance classes and review weak slots. | `analysis/05_class_attendance_rate.sql` | `results/05_class_attendance_rate.csv` |
| 6 | Which trainers deliver the most sessions and receive the highest ratings? | Intermediate | {summary_06} | Combines workload and quality signals. | Reward strong performers and coach trainers needing support. | `analysis/06_trainer_utilisation.sql` | `results/06_trainer_utilisation.csv` |
| 7 | Which active paying members have visited fewer than three times recently? | Intermediate | {summary_07} | Finds members paying but disengaging. | Trigger re-engagement campaigns before churn. | `analysis/07_underutilised_members.sql` | `results/07_underutilised_members.csv` |
| 8 | How can members be segmented by visits, attendance, and PT usage? | Advanced | {summary_08} | Groups members by engagement intensity. | Personalise campaigns by engagement segment. | `analysis/08_member_segmentation.sql` | `results/08_member_segmentation.csv` |
| 9 | Which members are most likely to churn? | Advanced | {summary_09} | Scores inactivity, payment issues, and low engagement. | Prioritise outreach by risk rank. | `analysis/09_churn_risk_ranking.sql` | `results/09_churn_risk_ranking.csv` |
| 10 | Which members have generated the highest lifetime revenue? | Advanced | {summary_10} | Highlights high-value members and plan-level value differences. | Build VIP retention and referral offers. | `analysis/10_customer_lifetime_value.sql` | `results/10_customer_lifetime_value.csv` |
| 11 | Which Basic or Student members behave like Premium members? | Expert | {summary_11} | Identifies realistic upgrade targets. | Run targeted Premium upgrade campaigns. | `analysis/11_upgrade_opportunity.sql` | `results/11_upgrade_opportunity.csv` |
| 12 | Which gym locations are most operationally efficient? | Expert | {summary_12} | Combines revenue, visits, attendance, trainer quality, payment success, and members. | Use the scorecard for branch strategy and operational reviews. | `analysis/12_location_efficiency_scorecard.sql` | `results/12_location_efficiency_scorecard.csv` |
"""

REPORT.write_text(content, encoding="utf-8")
print(f"Updated {REPORT}")
