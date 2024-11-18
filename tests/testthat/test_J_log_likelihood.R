test_that("J_log_likelihood_computes_correct_negative_log-likelihood", {
  # Load the dataset
  data("PimaIndiansDiabetes")

  # Prepare data
  X <- as.matrix(PimaIndiansDiabetes[, -ncol(PimaIndiansDiabetes)])
  # Feature matrix
  y <- as.numeric(PimaIndiansDiabetes$diabetes == "pos")
  # Response vector (convert 'pos' to 1 and 'neg' to 0)

  # Fit model using the custom function
  beta_custom <- J_logistic_fit(X, y)

  # Compute negative log-likelihood using the custom function
  log_likelihood_custom <- J_log_likelihood(X, y, beta_custom)

  # Compute log-likelihood using glm()
  model_glm <- glm(y ~ X, family = binomial)
  log_likelihood_glm <- logLik(model_glm)

  # Check if the negative log-likelihood from the custom function matches that from glm()
  expect_equal(log_likelihood_custom, as.numeric(log_likelihood_glm), tolerance = 1e-5)
})
