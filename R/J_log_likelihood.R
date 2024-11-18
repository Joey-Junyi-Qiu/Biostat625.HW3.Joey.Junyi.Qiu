# Log-likelihood function in R
#' @title Log-Likelihood Function for Logistic Regression
#' @description This function computes the negative log-likelihood for a logistic regression model.
#' @param X A numeric matrix where each row represents an observation and each column represents a feature.
#' @param y A numeric vector of binary outcomes (0 or 1) for each observation.
#' @param beta A numeric vector of regression coefficients.
#' @return The negative log-likelihood value.
#' @examples
#' X <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3, byrow = TRUE)
#' y <- c(1, 0, 1)
#' beta <- c(0.5, -0.2)
#' J_log_likelihood(X, y, beta)
#' #The result for this example: -1.988591
#' @export
J_log_likelihood <- function(X, y, beta) {
  # Ensure X has an intercept column (all ones) if necessary
  if (ncol(X) + 1 == length(beta)) {
    X <- cbind(1, X)
  }

  # Calculate the linear predictor
  z <- X %*% beta

  # Get predicted probabilities
  predictions <- 1 / (1 + exp(-z))

  # Avoid log(0) by adding a small epsilon to predictions
  epsilon <- 1e-10
  predictions <- pmin(pmax(predictions, epsilon), 1 - epsilon)

  # Calculate the negative log-likelihood
  loglik <- sum(y * log(predictions) + (1 - y) * log(1 - predictions))

  # Return the negative log-likelihood
  return(loglik)
}
