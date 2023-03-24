#!/usr/bin/env Rscript

# create a stats summary for a comparison

help_message <- "Usage: summarize_stats.R <input_DE_config.yaml> <output_directory>\n"
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2 || any(args %in% c("-h", "--help"))) {
    cat(help_message)
    quit()
} 

inp_c <- args[1]
out_d <- args[2]


if(!file.exists(inp_c)) {
  stop(sprintf("File %s does not exist", inp_c))
}


if(!file.exists(out_d)) {
  dir.create(out_d)
} else {
  if(!file.info(out_d)$isdir) {
    stop(sprintf("File %s exists, but is not a directory"))
  }
}

library(Rseasnap)

pip <- load_de_pipeline(inp_c)

covar <- get_covariates(pip)
saveRDS(covar, file.path(out_d, "covariates.rds"))

res <- get_contrasts(pip)
saveRDS(res, file.path(out_d, "contrasts.rds"))

res <- get_tmod_res(pip)
saveRDS(res, file.path(out_d, "tmod_results.rds"))

annot <- get_annot(pip)
saveRDS(annot, file.path(out_d, "annotation.rds"))

ds2 <- get_deseq2(pip)
saveRDS(ds2, file.path(out_d, "deseq2.rds"))

file.copy(inp_c, file.path(out_d, "DE_config.yaml"))








