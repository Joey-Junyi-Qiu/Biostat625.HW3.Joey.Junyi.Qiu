# Biostat625.HW3.Joey.Junyi.Qiu

## Table of Contents

1. [Overview](#overview)
2. [Installation](#installation)
   - [From GitHub](#from-github)
3. [Functions and Usage](#functions-and-usage)
   - [J_logistic_fit()](#1-j_logistic_fit)
   - [J_logistic()](#2-j_logistic)
   - [J_log_likelihood()](#3-j_log_likelihood)
4. [Example](#example)
5. [Testing](#Testing)
6. [Contributing](#contributing)
7. [License](#license)
8. [Acknowledgments](#acknowledgments)

## Overview

`Biostat625.HW3.Joey.Junyi.Qiu` is an R package that provides custom logistic regression functions. The package includes the following key functions:

1. **`J_logistic_fit()`**: Fits a logistic regression model using Newton's method.
2. **`J_logistic()`**: Predicts probabilities using the fitted logistic regression model.
3. **`J_log_likelihood()`**: Computes the negative log-likelihood for a logistic regression model.

## Installation

### From GitHub

You can install the package directly from GitHub using the `devtools` package:

```r
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
devtools::install_github("Joey-Junyi-Qiu/Biostat625.HW3.Joey.Junyi.Qiu")
```

## Functions and Usage

### 1. `J_logistic_fit()`

**Description**: Fits a logistic regression model using Newton's method.

**Usage**:

```r
# Load the package
library(Biostat625.HW3.Joey.Junyi.Qiu)

# Load a dataset (e.g., PimaIndiansDiabetes included in this R package)
data("PimaIndiansDiabetes")

# Prepare feature matrix and response vector
X <- as.matrix(PimaIndiansDiabetes[, -ncol(PimaIndiansDiabetes)])
# Feature matrix
y <- as.numeric(PimaIndiansDiabetes$diabetes == "pos")
# Response vector (convert 'pos' to 1 and 'neg' to 0)

# Fit logistic regression model
fitted_beta <- J_logistic_fit(X, y)
print(fitted_beta)
```

### 2. `J_logistic()`

**Description**: Predicts probabilities for each observation using the fitted logistic regression model.

**Usage**:

```r
# Predict probabilities using the fitted model
predicted_probs <- J_logistic(X, fitted_beta)
print(predicted_probs[1:10])  # Print the first 10 predicted probabilities
```

### 3. `J_log_likelihood()`

**Description**: Computes the negative log-likelihood for a logistic regression model given the feature matrix, target vector, and model coefficients.

**Usage**:

```r
# Calculate the negative log-likelihood for the fitted model
log_likelihood_value <- J_log_likelihood(X, y, fitted_beta)
print(log_likelihood_value)
```

## Example

Here is a complete example using the `PimaIndiansDiabetes` dataset to fit a logistic regression model, make predictions, and calculate the negative log-likelihood.

```r
# Load the package
library(Biostat625.HW3.Joey.Junyi.Qiu)

# Load dataset
data("PimaIndiansDiabetes")

# Prepare data
X <- as.matrix(PimaIndiansDiabetes[, -ncol(PimaIndiansDiabetes)])
# Feature matrix
y <- as.numeric(PimaIndiansDiabetes$diabetes == "pos")
# Response vector (convert 'pos' to 1 and 'neg' to 0)

# Fit model
fitted_beta <- J_logistic_fit(X, y)

# Predict probabilities
predicted_probs <- J_logistic(X, fitted_beta)

# Calculate negative log-likelihood
log_likelihood_value <- J_log_likelihood(X, y, fitted_beta)

# Print results
print(fitted_beta)
print(predicted_probs[1:10])  # Print the first 10 predicted probabilities
print(log_likelihood_value)
```

## Testing
This R package contains tests for functions and comparisons with the results of the glm() model(original R functions), using the all.equal() and bench::mark() to demonstrate the correctness and the efficiency. And all of them can output the correct results. You can find references in documents such as vignettes.

## Contributing

If you would like to contribute to this package, feel free to fork the repository and create pull requests. Feedback, bug reports, and feature requests are welcome.

## License

This package is licensed under the MIT License. See the `LICENSE` file for more details.

## Acknowledgments

This package was developed for educational purposes as part of the Biostat 625 course at the University of Michigan. Special thanks to the instructors for their support and feedback.








