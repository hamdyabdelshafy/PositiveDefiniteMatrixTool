
/* 
This function, 'topdm', is designed to ensure that an input matrix (sig) is positive definite.
A positive definite matrix has all positive eigenvalues, which is essential in many statistical and mathematical applications. 
The function performs eigenvalue decomposition and modifies any non-positive eigenvalues to ensure the output matrix is positive definite.
*/

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


