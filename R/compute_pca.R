# compute a PCA via SVD of the COV
compute_pca <- function( data, features = NULL ) {

  stopifnot(
    assertthat = requireNamespace("assertthat", quietly = TRUE),
    dplyr = require("dplyr", quietly = TRUE)
  )

  assertthat::assert_that(
    is.data.frame(data),
    msg = "`data` must be a data.frame!")


  if (is.null(features)) {
    num_cols <- unlist(lapply(data, is.numeric), use.names = FALSE)
    features <- names(data)[num_cols]
    message(
      "No features provided; using all numeric columns: ",
      paste0(
        features[1:max(c(length(features),3))],
        collapse = ", "),
      ", ...")
  }

  # are all features in data coluns?
  assertthat::assert_that(
    all(!is.na(match(features, colnames(data)))),
    msg = paste0(
      "Some features are no coluns: ",
      paste0(
        features[is.na(match(features, colnames(data)))],
        collapse = ", ")
    )
  )


  # pca list
  pca <- list("features" = features,
    dim = length(features))
  class(pca) <- "pca"


  input_ <- data %>% select(all_of(features))

  # center; note: standardization not needed (spatial units)
  pca$means <- input_ %>%
    summarize_all(mean)

  for (feature in features) {
    data[, feature] <- data[, feature] - pca$means[[feature]]
  }

  pca_input <- as.matrix(input_, wide = TRUE)

  # get the covariance matrix
  # https://www.r-bloggers.com/2021/07/how-to-create-a-covariance-matrix-in-r
  pca_cov <- cov(pca_input)

  # eigenanalysis - SVD
  # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/svd
  s <- svd(pca_cov, nu = 3)
  pca$val <- s$d
  pca$mat <- s$u

  # return pca
  return(pca)
}
