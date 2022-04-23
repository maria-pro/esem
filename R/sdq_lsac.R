#' Strengths and Difficulties Questionnaire (SDQ) of the Longitudinal Study of Australian Children (LSAC)
#'
#' The Longitudinal Study of Australian Children (LSAC) is a major study following
#' the development of 10,000 young people and their families from all parts of Australia.
#' It is conducted in partnership between the Department of Social Services,
#' the Australian Institute of Family Studies and the Australian Bureau of Statistics
#' with advice provided by a consortium of leading researchers.
#'
#' The study began in 2003 with a representative sample of children
#' from urban and rural areas of all states and territories in Australia.
#' The study has a multi-disciplinary base, and examines a broad range of topics,
#' including parenting, family, peers, education, child care and health.
#'
#'
#' Data are collected from two cohorts every two years.
#' The first cohort of 5,000 children was aged 0–1 years in 2003–04, and
#' the second cohort of 5,000 children was aged 4–5 years in 2003–04. The full dataset is available
#' \href{https://growingupinaustralia.gov.au/data-and-documentation}{here}
#' The SDQ is a 25-item instrument for children aged 4-17
#' years and includes fives scales: the “Hyperactivity,” “Emotional Symptoms,”
#' “Conduct Problems,” “Peer Problems,” and “Prosocial Behaviors”.
#'
#' The dataset was pre-processed and includes only variables relevant to the original latent
#' variables. The cleaning included:
#'
#'   - reverse coding items s7_1, s11_1, s14_1,  s21_1, s25_1.
#'   The reversed variables are named with R in the end: s7_1R, s11_1R, s14_1R,  s21_1R,s25_1R
#'
#'   - the missing data treatment was done is addressed following guidelines of Baraldi & Enders, 2010 and
#'   Baraldi & Enders, 2010.
#'
#'   The cases with more than 10% missing data were removed, other missing values were imputed
#'   with 5 iterations using multivariate imputations by chained equations approach that is based on Fully
#'   Conditional Specification,
#'   where each incomplete variable is imputed by a separate model (see
#'   \href{https://doi.org/10.18637/jss.v045.i03}{Groothuis-Oudshoorn, 2011}
#'
#' @format A tibble with 3840 rows and 25 variables:
#
#' }
#' @source \url{https://growingupinaustralia.gov.au/data-and-documentation}
"sdq_lsac"
