#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector J_logistic_cpp(NumericMatrix X, NumericVector beta) {
  RNGScope scope;
  int n = X.nrow();
  int m = X.ncol();

  // Add intercept column if needed
  if (m + 1 == beta.size()) {
    NumericMatrix X_ext(n, m + 1);
    for (int i = 0; i < n; i++) {
      X_ext(i, 0) = 1.0;
      for (int j = 0; j < m; j++) {
        X_ext(i, j + 1) = X(i, j);
      }
    }
    X = X_ext;
    m = X.ncol();
  }

  // Initialize a numeric vector to store the predicted probabilities
  NumericVector y(n);

  // Loop over each observation
  for (int i = 0; i < n; i++) {
    // Calculate the linear combination of features and coefficients
    double z = 0.0;
    for (int j = 0; j < m; j++) {
      z += X(i, j) * beta[j];
    }

    // Apply the logistic function to compute the probability
    y[i] = 1.0 / (1.0 + exp(-z));
  }

  // Return the vector of predicted probabilities
  return y;
}
