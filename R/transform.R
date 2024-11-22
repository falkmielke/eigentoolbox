
# Apply the PCA
transform <- function( data, pca ) {

  stopifnot(
    assertthat = requireNamespace("assertthat", quietly = TRUE),
    dplyr = require("dplyr", quietly = TRUE)
  )

  assertthat::assert_that(
    is.data.frame(data),
    msg = "`data` must be a data.frame!")

  assertthat::assert_that(
    inherits(pca, "pca"),
    msg = "`pca` must be `eigentoolbox::pca` object!")


  # are all features in data coluns?
  assertthat::assert_that(
    all(!is.na(match(pca$features, colnames(data)))),
    msg = paste0(
      "Some features are no coluns: ",
      paste0(
        features[is.na(match(features, colnames(data)))],
        collapse = ", ")
    )
  )

  input_ <- data %>% select(all_of(pca$features))

  # centering
  for (feature in pca$features) {
    input_[, feature] <- input_[, feature] - pca$means[[feature]]
  }

  # transformed data
  data_trafo <- as.data.frame(data.frame(
      as.matrix(input_, wide = TRUE) %*% t(pca$mat)
      )) %>% setNames(paste0("PC", 1:pca$dim))

  return(data_trafo)
}
