## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(Biostat625.HW3.Joey.Junyi.Qiu)

## ----fit-example--------------------------------------------------------------

# Load dataset

data("PimaIndiansDiabetes")

# Prepare feature matrix and response vector
X <- as.matrix(PimaIndiansDiabetes[, -ncol(PimaIndiansDiabetes)])
y <- as.numeric(PimaIndiansDiabetes$diabetes == "pos")

# Fit logistic regression model using custom function
fitted_beta <- J_logistic_fit(X, y)
print(fitted_beta)

## ----predict-example----------------------------------------------------------
# Predict probabilities using the fitted model
predicted_probs <- J_logistic(X, fitted_beta)
print(predicted_probs[1:10])  # Print the first 10 predicted probabilities

## ----loglik-example-----------------------------------------------------------
# Calculate the negative log-likelihood for the fitted model
log_likelihood_value <- J_log_likelihood(X, y, fitted_beta)
print(log_likelihood_value)

