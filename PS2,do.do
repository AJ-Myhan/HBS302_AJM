// Ava Myhan
// HBS203 PS2
// 2.17.2026
// Instructor: Yanan Li
// Purpose: Data Exploration and Visualization 
**************************************************************************

//Do-File Setup
// 1. Set up your environment (ln.18)
// 2. Explore your data (ln.28)
// 3. Generate tables (ln.36)
// 4. Visualize your findings (ln.66)
// 5. Refine and polish (ln.94)
// 6. Wrap up and submit (ln.102)

**************************************************************************

// 1. Set up your environment

clear
cd "C:\Users\avamy\Downloads\HBS302"
use "C:\Users\avamy\Downloads\HBS302_Project.dta"
// OR DOWNLOAD OFF EXCEL
use https://liveutk-my.sharepoint.com/:x:/g/personal/amyhan1_vols_utk_edu/IQCFpfor0-N8Rr_LD4K142TmASGfvlc7XyNj3PbDahzFx9o?e=HaoWgM

**************************************************************************

// 2. Explore your data

summarize tn_total_enrollment tn_econ_disadv_pct tn_black_pct

// District enrollment ranges from as low as 24 students to 973,983, producing a mean of about 13,162 (and a large Standard deviation). Economic disadvantage averages 31% across districts (ranging from 2%-67%), while the percent of black students average 14% but spand a wide range from 0.5%-89%, showing substantial ddemographic variation across Tennessee.

**************************************************************************

// 3. Generate tables
**Frequency Table
*Create categories for economically disadvantaged percentage
gen econ_cat = .
replace econ_cat = 1 if tn_econ_disadv_pct < 20
replace econ_cat = 2 if tn_econ_disadv_pct >= 20 & tn_econ_disadv_pct < 30
replace econ_cat = 3 if tn_econ_disadv_pct >= 30 & tn_econ_disadv_pct < 40
replace econ_cat = 4 if tn_econ_disadv_pct >= 40
label define econ_lbl 1 "<20%" 2 "20–29%" 3 "30–39%" 4 "40%+"
label values econ_cat econ_lbl
*Frequency table econ
tab econ_cat

**Shows that most TN districts fall into the 20%-39% economically disadvantaged range, with fewer districts in the extremes. This distribution suggests that moderate levels of economic disadvantage are the most commmon statewide.**

**Cross Tabulation
*Create a category for female percentage
gen female_cat = .
replace female_cat = 1 if tn_female_pct < 48
replace female_cat = 2 if tn_female_pct >= 48 & tn_female_pct <= 50
replace female_cat = 3 if tn_female_pct > 50
label define female_lbl 1 "<48%" 2 "48–50%" 3 ">50%"
label values female_cat female_lbl
*Cross-tabulation: female category by econ category
tab female_cat econ_cat, row col

**This shows that most districts fall into the 48%-50% female category across all levels of economic disadvantage, indicating that gender balance is highly consistent statewide. There is no meaningful pattern linking female enrollment levels to economic disadvantage, suggesting the two variables are largely independent.**

**************************************************************************

// 4. Visualize your findings

**Bar Chart
keep if inlist(district_name, ///
    "Anderson County", "Oak Ridge", "Alcoa", "Maryville")
graph bar tn_total_enrollment, over(district_name, sort(1) label(angle(45))) ///
title("Total Enrollment by District") ///
ytitle("Enrollment") ///
bar(1, color(navy)) ///
legend(off)

**Anderson County has the highest enrollment among the 4 districts shown, with the other decreasing steadily from Maryville to Alcoa.**

**Pie Chart
gen black_cat = .
replace black_cat = 1 if tn_black_pct < 5
replace black_cat = 2 if tn_black_pct >= 5 & tn_black_pct < 15
replace black_cat = 3 if tn_black_pct >= 15
label define black_lbl 1 "<5% Black" 2 "5–14% Black" 3 "15%+ Black"
label values black_cat black_lbl
graph pie, over(black_cat) ///
    title("Distribution of Black Student Enrollment Categories") ///
    plabel(_all percent, format(%4.1f))
	
**The pie chart shows that districts are fairly evenly distributed across the three Black enrollment categories, with no single group dominating the statewide landscape.

**************************************************************************

// 5. Refine and polish

* Export graphs for submission
graph export "enrollment_chart.png", replace
graph export "black_distribution_pie.png", replace

**************************************************************************

// 6. Wrap up and submit

**This project explored Tennessee district data through descriptive statistics, tables, and two visualizations (a bar chart and a pie chart). The bar chart highlighted large differences in total enrollment across districts, while the pie chart showed how districts are distributed across demographic categories. Refinements such as clear labels, consistent colors, and clean graph regions improved readability and presentation quality. All graphs were exported for submission to ensure reproducibility and professional formatting.