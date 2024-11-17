# Log-likelihood function in R
#' @title Log-Likelihood Function for Logistic Regression
#' @description This function computes the negative log-likelihood for a logistic regression model.
#' @param X A numeric matrix where each row represents an observation and each column represents a feature.
#' @param y A numeric vector of binary outcomes (0 or 1) for each observation.
#' @param beta A numeric vector of regression coefficients.
#' @return The negative log-likelihood value.
#' @export
J_log_likelihood <- function(X, y, beta) {
  # Get the number of observations (rows) in the matrix X
  n <- nrow(X)

  # Initialize the log-likelihood value
  loglik <- 0

  # Loop over each observation to compute the log-likelihood
  for (i in 1:n) {
    # Calculate the linear combination of features and coefficients
    z <- sum(X[i, ] * beta)

    # Apply the logistic function to compute the probability
    p <- 1 / (1 + exp(-z))

    # Accumulate the log-likelihood value
    loglik <- loglik + (y[i] * log(p) + (1 - y[i]) * log(1 - p))
  }

  # Return the negative log-likelihood value
  return(-loglik)
}
