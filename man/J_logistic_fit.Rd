% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/J_logistic_fit.R
\name{J_logistic_fit}
\alias{J_logistic_fit}
\title{Logistic Regression Fit Function using Newton's Method}
\usage{
J_logistic_fit(X, y, iterations = 1000, tol = 1e-06)
}
\arguments{
\item{X}{A numeric matrix where each row represents an observation and each column represents a feature.}

\item{y}{A numeric vector of binary outcomes (0 or 1) for each observation.}

\item{iterations}{An integer representing the maximum number of iterations for Newton's method. Default is 1000.}

\item{tol}{A numeric value representing the convergence tolerance. Default is 1e-6.}
}
\value{
A numeric vector of fitted coefficients (including intercept).
}
\description{
This function fits a logistic regression model using Newton's method.
}
\examples{
data(PimaIndiansDiabetes)
X <- as.matrix(PimaIndiansDiabetes[, -9])
y <- as.numeric(PimaIndiansDiabetes$diabetes)-1
iterations <- 1000
tol = 1e-6
J_logistic_fit(X, y, iterations, tol)
#The result for this example: -8.4046963669  0.1231822984  0.0351637146 -0.0132955469
#0.0006189644 -0.0011916990  0.0897009700  0.9451797406  0.0148690047
}
