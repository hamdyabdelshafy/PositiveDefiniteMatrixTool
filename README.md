# Converts a non positive definite symmetric matrix to positive definite symmetric matrix

### Author: Hamdy Abdel-Shafy
### Date: October 2024
### Affiliation: Department of Animal Production, Cairo University, Faculty of Agriculture 

# This repository contains code originally inspired by a MATLAB function created by Felix Fernando González-Navarro (2024), which converts a non-positive definite symmetric matrix to a positive definite symmetric matrix. The original MATLAB version can be found on [MATLAB Central File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/35938-converts-a-non-positive-definite-symmetric-matrix-to-positive-definite-symmetric-matrix), retrieved on October 8, 2024. This version has been adapted for use in SAS.


## Overview

This repository contains a SAS IML implementation of a function called `topdm` that transforms a given square matrix into a positive definite matrix. 
The function checks for non-positive eigenvalues and replaces them with a small positive value, ensuring that the resulting matrix is valid for further statistical analysis.

## Function Details

### `topdm(sig)`

- **Input**: 
  - `sig`: A square matrix (n x n) that may or may not be positive definite.
  
- **Output**: 
  - Returns a positive definite version of the input matrix.

### Steps in the Function

1. **Initialization**: 
   - Set small constants `EPS` and `ZERO` to manage the eigenvalue threshold.

2. **Eigenvalue Decomposition**: 
   - Calculate the eigenvalues and eigenvectors of the input matrix `sig`.

3. **Check for Non-Positive Eigenvalues**: 
   - If any eigenvalue is less than or equal to `ZERO`, replace it with `EPS`.

4. **Matrix Reconstruction**: 
   - Reconstruct the matrix using the modified eigenvalues and the original eigenvectors.

5. **Return Result**: 
   - If the original matrix was positive definite, return it unchanged.

## Example Usage

```sas
proc iml;
start topdm(sig);
  /* Set a small value to replace zero or negative eigenvalues */
    EPS = 1E-6;   /* Set the value to replace zero or negative eigenvalues */
    ZERO = 1E-10; /* Threshold for detecting non-positive eigenvalues */

    /* Calculate eigenvalues and eigenvectors */
    call eigen(values, vectors, sig);

    /* If any eigenvalues are <= ZERO, replace them with EPS */
    do i = 1 to nrow(values);
        if values[i] <= ZERO then values[i] = EPS;
    end;

    /* Recompose the matrix using updated eigenvalues */
    sigma = vectors * diag(values) * t(vectors);

    return(sigma);
finish;

/* Example usage: */
sig = {1 2, 2 1}; /* Non-positive definite matrix example */
positive_definite_matrix = topdm(sig); /* Call the function with the example matrix */
print positive_definite_matrix; /* Print the resulting positive definite matrix */
quit;

```

## Requirements

- SAS software with IML module.

## License

This project is licensed under licensed under the [MIT License](LICENSE).

