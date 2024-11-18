


test_that("J_logistic_fit_computes_correct_coefficients", {
   # Load the dataset
   data("PimaIndiansDiabetes")

   # Prepare data
   X <- as.matrix(PimaIndiansDiabetes[, -ncol(PimaIndiansDiabetes)])
   # Feature matrix
   y <- as.numeric(PimaIndiansDiabetes$diabetes == "pos")
   # Response vector (convert 'pos' to 1 and 'neg' to 0)

   # Compute regression coefficients using the custom function
   beta_custom <- J_logistic_fit(X, y)

   # Compute regression coefficients using glm()
   model_glm <- glm(y ~ X, family = binomial)
   beta_glm <- unname(coef(model_glm))

   # Check if the custom function's coefficients match those from glm()
   expect_equal(beta_custom, beta_glm, tolerance = 1e-5)})
