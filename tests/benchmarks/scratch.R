
bench::mark(
  stringi::stri_extract_first_regex("abcd,desc,abcd,gyte,sxcf", "^[^,]*"),
  stringi::stri_split_fixed("abcd,desc,abcd,gyte,sxcf", ",")[[1]][1],
  strsplit("abcd,desc,abcd,gyte,sxcf", split = ",")[[1]][1],
  #stringi::stri_sub("abcd,desc,abcd,gyte,sxcf", to = stringi::stri_locate_first_fixed("abcd,desc,abcd,gyte,sxcf", ",")[1] - 1, use_matrix = FALSE),
  iterations = 10000
)