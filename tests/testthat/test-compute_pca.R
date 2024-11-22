test_data <- as.data.frame(cbind(1:4, 4:7))
colnames(test_data) <- c("feat1", "feat2")
test_pca <- compute_pca(test_data)

test_that("PCA works", {
  expect_equal(round(test_pca$val[1], 4), 3.3333)
  expect_equal(abs(round(test_pca$mat[1], 4)), 0.7071)
})
