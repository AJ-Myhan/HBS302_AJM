//Ava (AJ) Myhan
//HBS 302 -> Assignments -> PS1
//Instructor: Yanan Li
//2.4.2026

//1.INDENTIFY AND DESCRIBE YOUR DATASETS
//links: 
//Standford Education Data Archive (SEDA) 2024 Aux Rec https://edopportunity.org/recovery/data/downloads/#auxiliary-2024-2
// TN DOE- District-Level Data 2022-2023 https://www.tn.gov/education/districts/federal-programs-and-oversight/data/data-downloads.html

//I selected these datasets because they provide complementary perspectives on educational outcomes at both the national and Tennessee district levels. The SEDA dataset offers high-quality, research-grade measures of academic performance and demographic characteristics across the United States, while the TDOE dataset provides detailed, state-specific information on Tennessee districts. Together, these data allow me to explore how Tennessee compares to national patterns in academic recovery, demographics, and opportunity, and to examine which district characteristics are associated with stronger educational outcomes.


//2.LOAD YOUR DATA INTO STATA
//PERSONAL COMPUTER
//use "C:\Users\avamy\Downloads\seda_cov_state_annual_2024.2.dta"
//use "C:\Users\avamy\Downloads\HBS302Data2.dta"

cd ".." 

// 1. SEDA 2024 Auxiliary Recovery Data -
import delimited using"https://edopportunity.org/recovery/data/downloads/auxiliary/auxiliary_2024.csv",
clear case(preserve)

// 2. Tennessee Department of Education – District-Level Data
import delimited 
"https://www.tn.gov/content/dam/tn/education/data/district-profile-2022-2023.xlsx", 
clear case(preserve)

//3.PREPARE YOUR DATA Keep only 2022 and 2023
//cleaning up SEDA data
keep if year == 2022 | year == 2023
tab year
 keep year fips stateabb enrl38 avgrd38 perfrl perblk perhsp perwht totenrl lninc50all unempall povertyall single_momall sesall
rename fips state_fips
rename stateabb state
rename enrl38 enroll_3_8
rename avgrd38 avg_grade_enroll
rename perfrl prop_free_lunch
rename perblk prop_black
rename perhsp prop_hispanic
rename perwht prop_white
rename totenrl total_enrollment
rename lninc50all log_median_income
rename unempall unemployment_rate
rename povertyall poverty_rate
rename single_momall single_mother_rate
rename sesall ses_index
label variable year "School Year"
label variable state_fips "State FIPS Code"
label variable state "State Abbreviation"
label variable enroll_3_8 "Grade 3-8 Enrollment"
label variable avg_grade_enroll "Average Enrollment per Grade"
label variable prop_free_lunch "Proportion Free/Reduced Lunch"
label variable prop_black "Proportion Black Students"
label variable prop_hispanic "Proportion Hispanic Students"
label variable prop_white "Proportion White Students"
label variable total_enrollment "Total Enrollment"
label variable log_median_income "Log Median Household Income"
label variable unemployment_rate "Unemployment Rate"
label variable poverty_rate "Poverty Rate"
label variable single_mother_rate "Single Mother Household Rate"
label variable ses_index "Socioeconomic Status Index"

save "C:\Users\avamy\Downloads\seda_clean_22_23.dta"

//cleaning up TDOE data
keep school_year district_id district_name total african_american_pct asian_pct hispanic_pct white_pct economically_disadvantaged_pct female_pct male_pct students_with_disabilities_pct homeless_pct

rename school_year year
rename total tn_total_enrollment
rename african_american_pct tn_black_pct
rename asian_pct tn_asian_pct
rename hispanic_pct tn_hispanic_pct
rename white_pct tn_white_pct
rename economically_disadvantaged_pct tn_econ_disadv_pct
rename female_pct tn_female_pct
rename male_pct tn_male_pct
rename students_with_disabilities_pct tn_disability_pct
rename homeless_pct tn_homeless_pct
label variable year "School Year"
label variable district_id "Tennessee District Identifier"
label variable district_name "Tennessee District Name"
label variable tn_total_enrollment "Total Enrollment (TDOE)"
label variable tn_black_pct "Percent Black Students (TN)"
label variable tn_asian_pct "Percent Asian Students (TN)"
label variable tn_hispanic_pct "Percent Hispanic Students (TN)"
label variable tn_white_pct "Percent White Students (TN)"
label variable tn_econ_disadv_pct "Economically Disadvantaged Percent (TN)"
label variable tn_female_pct "Percent Female Students (TN)"
label variable tn_male_pct "Percent Male Students (TN)"
label variable tn_disability_pct "Percent Students with Disabilities (TN)"
label variable tn_homeless_pct "Percent Homeless Students (TN)"

save "C:\Users\avamy\Downloads\tn_clean_22-23.dta"

//TO MERGE
gen fips = 47
label var fips "State FIPS Code"
gen year_num = real(substr(year, 1, 4))
drop year
rename year_num year
destring fips, replace
fips already numeric; no replace
gen year_num = real(substr(year, 1, 4))
drop year
rename year_num year
destring fips, replace
fips already numeric; no replace
merge m:m fips using "C:\Users\avamy\Downloads\seda_clean_22_23.dta"

//4. EXPLORE YOUR DATA
describe
sum
tab

// 5. SAVE YOUR CLEANED DATA (in >2 formats)
save "C:\Users\avamy\Downloads\HBS302_Project.dta"
//also saved as excl