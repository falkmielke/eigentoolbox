#' Compute a PCA via svd of the cov.
#'
#' @param data a data frame containing numeric features
#' @param features vector of feature columns (must be numeric)
#'
#' @return a pca object to use for (re-)transformation
#' @export
#'
#' @importFrom dplyr select all_of summarize_all
#' @importFrom stats cov
#'
#' @examples
#'    test_data <- as.data.frame(cbind(1:4, 4:7))
#'    colnames(test_data) <- c("feat1", "feat2")
#'    test_pca <- compute_pca(test_data)
#'
compute_pca <- function( data, features = NULL ) {

  stopifnot(
    assertthat = requireNamespace("assertthat", quietly = TRUE),
    dplyr = requireNamespace("dplyr", quietly = TRUE)
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

  input_ <- data |> select(all_of(features))

  # pca list
  pca <- list("features" = features,
    dim = length(features),
    raw_data = input_
    )
  class(pca) <- c("pca")



  # center; note: standardization not needed (spatial units)
  pca$means <- input_ |>
    summarize_all(mean)

  for (feature in features) {
    input_[, feature] <- input_[, feature] - pca$means[[feature]]
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



#' Quick bivariate plot of PCA data.
#'
#' Just trying some S3 method overloading,
#' with defaults for some crucial plot attributes.
#' see here:
#'    https://stackoverflow.com/q/13120895
#'    https://aksela.wordpress.com/2018/08/18/simple-example-for-creating-a-custom-s3-class-with-methods
#'    https://www.datamentor.io/r-programming/s3-class
#'
#' @param pca a pca object (see above)
#' @param cex marker size
#' @param col marker fill color
#' @param pch shape of the scatter marker
#' @param xlab a title for the x axis
#' @param ylab a title for the y axis
#' @importFrom graphics plot.default
#'
#' @return Nothing. Side-effect: plots graphs.
#' @export
#'
plot.pca <- function(x,
      y = NULL,
      cex = NULL,
      col = NULL,
      pch = NULL,
      xlab = NULL,
      ylab = NULL,
      ...) {

  pca <- x
  data_trafo <- eigentransform( pca$raw_data, pca )
  w1 <- round(100 * pca$val[[1]] / sum(pca$val), 1)
  w2 <- round(100 * pca$val[[2]] / sum(pca$val), 1)

  if (is.null(cex)) {cex =  1}
  if (is.null(col)) {col = "white"}
  if (is.null(pch)) {pch = 21}
  if (is.null(xlab)) {xlab = paste0("PC1 (", w1, "%)")}
  if (is.null(ylab)) {ylab = paste0("PC2 (", w2, "%)")}


  plot.default(
    x = data_trafo$pc1,
    y = data_trafo$pc2,
    cex = cex,
    pch = pch,
    xlab = xlab,
    ylab = ylab,
    ...
  )

}
