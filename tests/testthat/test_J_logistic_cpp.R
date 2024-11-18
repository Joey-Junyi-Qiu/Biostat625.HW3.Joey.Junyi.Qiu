# tests/testthat/test_J_logistic_cpp.R

test_that("J_logistic_predicts_correct_probabilities", {
  library(Rcpp)
  # Load the dataset
  data("PimaIndiansDiabetes")

  # Prepare data
  X <- as.matrix(PimaIndiansDiabetes[, -ncol(PimaIndiansDiabetes)])  # Feature matrix
  y <- as.numeric(PimaIndiansDiabetes$diabetes == "pos")
  # Response vector (convert 'pos' to 1 and 'neg' to 0)

  # Fit model using the custom function
  beta_custom <- J_logistic_fit(X, y)

  # Predict probabilities using the custom function
  predicted_probs_custom_cpp <- J_logistic_cpp(X, beta_custom)

  # Predict probabilities using glm()
  model_glm <- glm(y ~ X, family = binomial)
  predicted_probs_glm <- unname(predict(model_glm, type = "response"))

  # Check if the predicted probabilities from the custom function match those from glm()
  expect_equal(predicted_probs_custom_cpp, predicted_probs_glm, tolerance = 1e-5)
})
