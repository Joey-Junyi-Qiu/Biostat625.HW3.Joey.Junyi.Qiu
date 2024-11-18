## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(Biostat625.HW3.Joey.Junyi.Qiu)
library(Rcpp)

## ----load-packages------------------------------------------------------------
# Load required packages
library(Biostat625.HW3.Joey.Junyi.Qiu)
if (!requireNamespace("bench", quietly = TRUE)) {
  install.packages("bench")
}
library(bench)

## ----load-data----------------------------------------------------------------
# Load the dataset
# PimaIndiansDiabetes data is included in our package
data("PimaIndiansDiabetes")

# Prepare feature matrix (X) and target vector (y)
X <- as.matrix(PimaIndiansDiabetes[, -ncol(PimaIndiansDiabetes)])  # All columns except the last one
y <- as.numeric(PimaIndiansDiabetes$diabetes == "pos")  # Convert 'pos' to 1 and 'neg' to 0

## ----fit-example--------------------------------------------------------------

# Fit logistic regression model using custom function
custom_beta <- J_logistic_fit(X, y)
print(custom_beta)

## ----glm-fit------------------------------------------------------------------
# Fit logistic regression using glm()
model_glm <- glm(y ~ X, family = binomial)
# Extract coefficients from the model
beta_glm <- unname(coef(model_glm))
print(beta_glm)

## ----accuracy-comparison------------------------------------------------------
# Compare the coefficients from custom logistic regression and glm
coefficients_accuracy_comparison <- all.equal(custom_beta, beta_glm, tolerance = 1e-5)
print(coefficients_accuracy_comparison)

## ----predict-example----------------------------------------------------------
# Predict probabilities using the fitted model
predicted_probs <- J_logistic(X, custom_beta)
print(predicted_probs[1:10])  # Print the first 10 predicted probabilities

## ----predict-comparison-------------------------------------------------------
# Predict probabilities using glm()
predicted_probs_glm <- unname(predict(model_glm, type = "response"))

# Compare the predicted probabilities from custom logistic and glm
prob_accuracy_comparison <- all.equal(predicted_probs, predicted_probs_glm, tolerance = 1e-5)
print(prob_accuracy_comparison)

## ----predict-example Rcpp-----------------------------------------------------
# Predict probabilities using the fitted model
predicted_probs_cpp <- J_logistic_cpp(X, custom_beta)
print(predicted_probs_cpp[1:10])  # Print the first 10 predicted probabilities

## ----predict-comparison Rcpp--------------------------------------------------

# Compare the predicted probabilities from custom logistic and glm
prob_accuracy_comparison_cpp <- all.equal(predicted_probs_cpp, predicted_probs, tolerance = 1e-5)
print(prob_accuracy_comparison_cpp)

## ----loglik-example-----------------------------------------------------------
# Calculate the negative log-likelihood for the fitted model
log_likelihood_value <- J_log_likelihood(X, y, custom_beta)
print(log_likelihood_value)

## ----loglik-comparison--------------------------------------------------------
# Calculate the log-likelihood using glm()
log_likelihood_glm <- logLik(model_glm)

# Compare the negative log-likelihood from custom logistic and glm
loglik_accuracy_comparison <- all.equal(log_likelihood_value, as.numeric(log_likelihood_glm), tolerance = 1e-5)
print(loglik_accuracy_comparison)

## ----efficiency-comparison-fit------------------------------------------------
# Load bench package for benchmarking
if (!requireNamespace("bench", quietly = TRUE)) {
  install.packages("bench")
}
library(bench)

# Benchmark the computation time of custom logistic regression fit and glm
benchmark_results_fit <- bench::mark(
  Custom = J_logistic_fit(X, y),
  GLM = unname(coef(glm(y ~ X, family = binomial))),
  iterations = 10
)
print(benchmark_results_fit)

## ----efficiency-comparison-predict--------------------------------------------
# Benchmark the computation time of custom prediction and glm prediction
benchmark_results_predict <- bench::mark(
  Custom = J_logistic(X, custom_beta),
  GLM = unname(predict(model_glm, type = "response")),
  iterations = 10
)
print(benchmark_results_predict)

## ----efficiency-comparison-predict Rcpp---------------------------------------
# Benchmark the computation time of custom R prediction and Rcpp prediction
benchmark_results_predict_cpp <- bench::mark(
  Custom_R = J_logistic(X, custom_beta),
  Custon_Rcpp = J_logistic_cpp(X, custom_beta),
  iterations = 10
)
print(benchmark_results_predict_cpp)

## ----efficiency-comparison-loglik---------------------------------------------
# Benchmark the computation time of custom log-likelihood and glm logLik
benchmark_results_loglik <- bench::mark(
  Custom = J_log_likelihood(X, y, custom_beta),
  GLM = as.numeric(logLik(model_glm)),
  iterations = 10
)
print(benchmark_results_loglik)

## ----cleanup, include=FALSE---------------------------------------------------
# Cleanup - detach loaded packages to avoid conflicts
detach("package:Biostat625.HW3.Joey.Junyi.Qiu", unload = TRUE)
detach("package:bench", unload = TRUE)

