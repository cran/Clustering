#'  This functions below are functions that belongs to the package 'mldr'
#'  developed by F. Charte and D. Charte.
#'
#'  More information about 'mldr' package is found in this article:
#'
#'  F. Charte, D. Charte. Working with Multilabel Datasets in R: The mldr
#'  Package. The R Journal, 2015
#'


#' Extracts all useful data from an ARFF file in
#' R objects
#'
#' @param arff_file Path to the file
#' @return List containing the relation string,
#'  a named vector for attributes and a data.frame
#'  for the data section
#' @noRd
#'

read_arff <- function(arff_file) {
  file_con <- file(arff_file, "rb")

  if (!isOpen(file_con))
    open(file_con, "rb")

  # Read whole file
  file_data <-
    strsplit(
      readChar(
        file_con,
        nchars = file.info(arff_file)$size,
        useBytes = TRUE
      ),
      "\\\r\n|\\\r|\\\n",
      fixed = FALSE,
      useBytes = TRUE
    )[[1]]

  close(file_con)

  # Split into relation, attributes and data
  relation_at <- grep("@relation", file_data, ignore.case = TRUE)
  data_start <- grep("@data", file_data, ignore.case = TRUE)

  if (is.na(relation_at))
    stop("Missing @relation or not unique.")
  if (is.na(data_start))
    stop("Missing @data mark or not unique.")

  relation <- file_data[relation_at]

  # Get attribute vector
  attributes <-
    parse_attributes(file_data[(relation_at + 1):(data_start - 1)])
  num_attrs <- length(attributes)

  # Ignore blank lines before data
  data_start <- data_start + 1
  while (grepl("^\\s*$", file_data[data_start]))
    data_start <- data_start + 1

  # Build data.frame with @data section
  rawdata <- file_data[data_start:length(file_data)]
  dataset <- if (detect_sparsity(rawdata))
    parse_sparse_data(rawdata, num_attrs)
  else
    parse_nonsparse_data(rawdata, num_attrs)

  rm(rawdata)
  #names(dataset) <- names(attributes)

  return(as.matrix(dataset))
}

# Reads the attributes section of an ARFF file
#
# @param arff_attrs Lines containing the attributes
# @return A vector containing, for each
#  attribute, its name and its type
parse_attributes <- function(arff_attrs) {
  # Extract attribute definitions

  rgx <-
    "(?:{[^}\\s]*?(\\s+[^}\\s]*?)+}|(?<!\\\\)'[^'\\\\]*(?:\\\\.[^'\\\\]*)*(?<!\\\\)')(*SKIP)(*F)|\\s+"
  att_list <- strsplit(arff_attrs, rgx, perl = TRUE)

  # Structure by rows
  att_mat <-
    matrix(unlist(att_list[sapply(att_list, function(row) {
      length(row) == 3
    })]),
    ncol = 3, byrow = TRUE)
  rm(att_list)
  # Filter any data that is not an attribute
  att_mat <-
    att_mat[grepl("\\s*@attribute", att_mat[, 1], ignore.case = TRUE), 2:3]
  att_mat <- gsub("\\'", "'", att_mat, fixed = TRUE)
  att_mat <- gsub("^'(.*?)'$", "\\1", att_mat, perl = TRUE)

  # Create the named vector
  att_v <- att_mat[, 2]
  names(att_v) <- att_mat[, 1]

  rm(att_mat)
  return(att_v)
}



# Reads the name and Meka parameters in the header of an
# ARFF file
#
# @param arff_relation "relation" line of the ARFF file
# @return Number of labels in the dataset
read_header <- function(arff_relation) {
  rgx <-
    regexpr("[\\w\\-\\._]+\\s*:\\s*-[Cc]\\s*\\d+",
            arff_relation,
            perl = TRUE)
  hdr <-
    strsplit(regmatches(arff_relation, rgx), "\\s*:\\s*-[Cc]\\s*")

  if (length(hdr) > 0) {
    # Meka header
    return(list(name = hdr[[1]][1],
                toplabel = as.numeric(hdr[[1]][2])))
  } else {
    # Mulan header
    nm <-
      regmatches(arff_relation,
                 regexpr("(?<=\\s)'?[\\w\\-\\._]+'?", arff_relation, perl = TRUE))
    return(list(name = nm))
  }
}

# Detects whether an ARFF file is in sparse format
#
# @param arff_data Content of the data section
# @return Boolean, TRUE when the file is sparse
detect_sparsity <- function(arff_data) {
  grepl("^\\s*\\{", arff_data[1])
}

# Builds a data.frame out of non-sparse ARFF data
#
# @param arff_data Content of the data section
# @return data.frame containing data values
parse_nonsparse_data <- function(arff_data, num_attrs) {
  data.frame(matrix(unlist(strsplit(
    arff_data, ",", fixed = TRUE
  )),
  ncol = num_attrs,
  byrow = TRUE), stringsAsFactors = FALSE)
}

# Builds a data.frame out of sparse ARFF data
#
# @param arff_data Content of the data section
# @return data.frame containing data values
parse_sparse_data <- function(arff_data, num_attrs) {
  # Extract data items
  arff_data <- strsplit(gsub("[\\{\\}]", "", arff_data), ",")
  arff_data <- lapply(arff_data, function(item) {
    unlist(strsplit(gsub("^\\s+|\\s+$", "", item), " "))
  })

  # Build complete matrix with data
  dataset <- sapply(arff_data, function(row) {
    complete <- rep(0, num_attrs)
    complete[as.integer(row[c(TRUE, FALSE)]) + 1] <- row[c(FALSE, TRUE)]
    complete
  })

  # Create and return data.frame
  data.frame(t(dataset), stringsAsFactors = FALSE)
}
