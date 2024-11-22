
#' Apply a PCA to data.
#'
#' @param data a data frame with data to be transformed.
#' @param pca the pca object used for transformation.
#'
#' @return transformed data (data.frame)
#' @export
#'
#' @importFrom stats setNames
#'
#' @examples
#' \dontrun{
#'   data_trafo <- eigentransform( data, pca )
#' }
#'
eigentransform <- function( data, pca ) {

  stopifnot(
    assertthat = requireNamespace("assertthat", quietly = TRUE),
    dplyr = requireNamespace("dplyr", quietly = TRUE)
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
        pca$features[is.na(match(pca$features, colnames(data)))],
        collapse = ", ")
    )
  )

  input_ <- data |> select(all_of(pca$features))

  # centering
  for (feature in pca$features) {
    input_[, feature] <- input_[, feature] - pca$means[[feature]]
  }

  # transformed data
  data_trafo <- as.data.frame(data.frame(
      as.matrix(input_, wide = TRUE) %*% t(pca$mat)
      )) |> setNames(paste0("pc", 1:pca$dim))

  return(data_trafo)
}
