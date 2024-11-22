
# Un-apply the PCA
retrafo <- function( data_trafo, pca ) {

  stopifnot(
    assertthat = requireNamespace("assertthat", quietly = TRUE),
    dplyr = require("dplyr", quietly = TRUE)
  )

  assertthat::assert_that(
    is.data.frame(data_trafo),
    msg = "`data` must be a data.frame!")

  assertthat::assert_that(
    inherits(pca, "pca"),
    msg = "`pca` must be `eigentoolbox::pca` object!")


  # are all features in data coluns?
  assertthat::assert_that(
    ncol(data_trafo) == pca$dim,
    msg = paste0("Transformed data dimension (ncol) does not match pca dimension.")
  )


  # retrafo
  retrafo <- as.data.frame(data.frame(
      as.matrix(data_trafo) %*% pca$mat
    ))

  # data format
  colnames(retrafo) <- pca$features

  # uncenter
  for (feature in pca$features) {
    retrafo[, feature] <- retrafo[, feature] + pca$means[[feature]]
  }

  return(retrafo)
}
