getFilename <- function () {

  return(paste0("tests/benchmarks/output/",
                stringr::str_extract(rstudioapi::getSourceEditorContext()$path, "[^/]+$"),
                "_",
                format(Sys.time(), "%Y%M%d%H%M%S"),
                ".Rout"))
}