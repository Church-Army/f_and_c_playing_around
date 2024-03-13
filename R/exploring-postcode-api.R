library(PostcodesioR)
library(purrr)

postcodes <- str_remove(result$preferred_postcode, " ")

postcodes <- unique(postcodes)
postcodes <- postcodes[!is.na(postcodes)]

postcode_list <- split(postcodes, ceiling(seq_along(postcodes)/100))

tmp_list <- split(tmp, ceiling(seq_along(tmp)/10))

postcode_result <- lapply(postcode_list, \(x) bulk_postcode_lookup(list(postcodes = x)))

bulk_postcode_lookup(list(postcodes = postcode_list[[1]]))

postcode_result <- lis(postcode_result)

map_chr(postcode_result, \(x){
       msoa <- pluck(x, "result", "codes", "msoa")
       ifelse(is.null(msoa), NA, msoa)
       })
