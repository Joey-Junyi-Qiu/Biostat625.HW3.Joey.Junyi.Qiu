# Logistic regression prediction function in R
#' @title Logistic Regression Prediction Function
#' @description This function calculates the predicted probabilities using a logistic regression model.
#' @param X A numeric matrix where each row is an observation, and each column is a feature.
#' @param beta A numeric vector of coefficients for the logistic regression model.
#' @return A numeric vector of predicted probabilities.
#' @export
J_logistic <- function(X, beta) {
  # Get the number of observations (rows) in the matrix X
  n <- nrow(X)

  # Initialize a numeric vector y to store the predicted probabilities
  y <- numeric(n)

  # Loop over each observation
  for (i in 1:n) {
    # Calculate the linear combination of features and coefficients
    z <- sum(X[i, ] * beta)

    # Apply the logistic function to compute the probability
    y[i] <- 1 / (1 + exp(-z))
  }

  # Return the vector of predicted probabilities
  return(y)
}
