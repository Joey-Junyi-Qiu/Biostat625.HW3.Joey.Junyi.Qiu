# Logistic Regression Fit Function using Newton's Method
#' @title Logistic Regression Fit Function using Newton's Method
#' @description This function fits a logistic regression model using Newton's method.
#' @param X A numeric matrix where each row represents an observation and each column represents a feature.
#' @param y A numeric vector of binary outcomes (0 or 1) for each observation.
#' @param iterations An integer representing the maximum number of iterations for Newton's method. Default is 1000.
#' @param tol A numeric value representing the convergence tolerance. Default is 1e-6.
#' @return A numeric vector of fitted coefficients (including intercept).
#' @examples
#' data(PimaIndiansDiabetes)
#' X <- as.matrix(PimaIndiansDiabetes[, -9])
#' y <- as.numeric(PimaIndiansDiabetes$diabetes)-1
#' iterations <- 1000
#' tol = 1e-6
#' J_logistic_fit(X, y, iterations, tol)
#' #The result for this example: -8.4046963669  0.1231822984  0.0351637146 -0.0132955469
#' #0.0006189644 -0.0011916990  0.0897009700  0.9451797406  0.0148690047
#' @export
J_logistic_fit <- function(X, y, iterations = 1000, tol = 1e-6) {
  # Add an intercept column (all ones) to the feature matrix
  X <- cbind(1, X)

  # Get the number of observations and features
  n <- nrow(X)
  m <- ncol(X)

  # Initialize coefficients to 0 (including the intercept term)
  beta <- rep(0, m)

  # Define the sigmoid function
  sigmoid <- function(z) {
    return(1 / (1 + exp(-z)))
  }

  # Iteratively update the coefficients using Newton's method
  for (iter in 1:iterations) {
    # Calculate predictions for each observation
    z <- X %*% beta
    predictions <- sigmoid(z)

    # Calculate the gradient (first derivative of the log-likelihood)
    gradient <- t(X) %*% (y - predictions)

    # Calculate the Hessian (second derivative of the log-likelihood)
    W <- diag(as.vector(predictions * (1 - predictions)), n, n)
    hessian <- -t(X) %*% W %*% X

    # Update beta using Newton's method: beta = beta - H^(-1) * gradient
    beta_update <- solve(hessian) %*% gradient
    beta <- beta - beta_update

    # Check for convergence
    if (max(abs(beta_update)) < tol) {
      break
    }
  }

  # Return the fitted coefficients (including intercept)
  return(as.vector(beta))
}
