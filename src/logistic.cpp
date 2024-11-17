#include <Rcpp.h>
using namespace Rcpp;


//' @title Logistic Regression Prediction Function
//' @description This function calculates the predicted probabilities using a logistic regression model.
//' @param X A numeric matrix where each row is an observation, and each column is a feature.
//' @param beta A numeric vector of coefficients for the logistic regression model.
//' @return A numeric vector of predicted probabilities.
//' @export
// [[Rcpp::export]]
 NumericVector logistic(NumericMatrix X, NumericVector beta) {
   // Get the number of rows in matrix X (i.e., the number of observations)
   int n = X.nrow();

   // Initialize a NumericVector y with size n to store the predicted probabilities
   NumericVector y(n);

   // Loop over each observation for each row of matrix X
   for (int i = 0; i < n; i++) {

     double z = 0.0; // Initialize z to calculate the linear combination

     // Loop over each feature (each column of matrix X)

     for (int j = 0; j < X.ncol(); j++) {

       // Calculate the linear combination: z = X[i,1]*beta[1] + X[i,2]*beta[2] + ...

       z += X(i, j) * beta[j];

     }

     // Apply the logistic function to the linear combination z

     // The logistic function is defined as: 1 / (1 + exp(-z))

     y[i] = 1.0 / (1.0 + exp(-z)); // Store the predicted probability in y
   }


   return y;  // Return the vector of predicted probabilities
 }
