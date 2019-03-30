## vim:textwidth=80:expandtab:shiftwidth=2:softtabstop=2
library(oceanglider)

context("subset")

test_that("subset seaexplorer by 'ascending'", {
          files <- system.file("extdata/seaexplorer/sub",
                               c("sea021.49.gli.sub.100.gz",
                                 "sea021.49.pld1.sub.100.gz"), package="oceanglider")
          expect_silent(g <- read.glider.seaexplorer.sub(files))
          ##capture_output(gdeep <- subset(g, "ascending", debug=3), print=TRUE)
          capture_output(gdeep <- subset(g, "ascending"), print=TRUE)
          ##expect_equal(gdeep[["payload1"]], g[["payload1"]][deep,])
})


test_that("subset seaexplorer by pressure", {
          files <- system.file("extdata/seaexplorer/sub",
                               c("sea021.49.gli.sub.100.gz",
                                 "sea021.49.pld1.sub.100.gz"), package="oceanglider")
          expect_silent(g <- read.glider.seaexplorer.sub(files))
          deep <- g[["pressure"]] > 20
          deep[is.na(deep)] <- FALSE
          expect_warning(gdeep <- subset(g, pressure > 20),
                         "evaluating in the context of payload1 only; cannot evaluate in glider context yet")
          expect_equal(gdeep[["payload1"]], g[["payload1"]][deep,])
})

##context("subset")
## test_that("ascending subset", {
##           files <- system.file("extdata/seaexplorer/sub",
##                                c("sea021.49.gli.sub.100.gz",
##                                  "sea021.49.pld1.sub.100.gz"), package="oceanglider")
##           g <- read.glider.seaexplorer.sub(files)
##           print(class(g))
##           ### ## capture_output(ascending <- subset(g, "ascending"), print=TRUE)
##           ### capture_output(ascending <- subset(g, navState==117), print=TRUE)
##           ### expect_true(all(ascending[["NAV_RESOURCE"]] == 117))
##           ### expect_true(all(ascending[["NAV_RESOURCE", "payload"]] == 117))
##           ### expect_true(all(ascending[["navState"]] == 117))
##           ### expect_true(all(ascending[["navState", "glider"]] == 117))
##           ### expect_true(all(ascending[["payload"]]$NAV_RESOURCE == 117))
##           ### expect_true(all(ascending[["glider"]]$navState == 117))
## })
## 
## test_that("descending subset", {
##           files <- system.file("extdata/seaexplorer/sub",
##                                c("sea024.32.gli.sub.200.gz",
##                                  "sea024.32.pld1.sub.200.gz"), package="oceanglider")
##           g <- read.glider.seaexplorer.sub(files)
##           capture_output(print(class(g)), print=TRUE)
##           ### ## capture_output(descending <- subset(g, "descending"), print=TRUE)
##           ### capture_output(descending <- subset(g, navState == 100), print=TRUE)
##           ### expect_true(all(descending[["NAV_RESOURCE"]] == 100))
##           ### expect_true(all(descending[["NAV_RESOURCE", "payload"]] == 100))
##           ### expect_true(all(descending[["navState"]] == 100))
##           ### expect_true(all(descending[["navState", "glider"]] == 100))
##           ### expect_true(all(descending[["payload"]]$NAV_RESOURCE == 100))
##           ### expect_true(all(descending[["glider"]]$navState == 100))
## })
## 
## ## FIXME: add a test on length, once we get a longer test dataset
## 