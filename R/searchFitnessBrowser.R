#' Searches a gene (or character vector of gene IDs) in the fitness browser
#' @param gene (Required) A string (or a character vector) with gene IDs to be searched in the fitness browser
#'
#' @param OrgID (Required) The ID for the organism of the query
#'
#' @param filter (Optional) a string used to filters the output table based on the conditions column
#'
#'  @returns A data frame with available fitness information for the queried genes
#'
#' @export

searchFitnessBrowser <- function(gene = NULL, OrgID = NULL, filter = NULL) {


  if (is.null(gene)) {
    message("Please, include gene(s) to query in your function call!")
    return(invisible())
  }

  allOrgCodes <- getOrganismCodes() |> dplyr::pull(OrgID)

  if (is.null(OrgID) || ! OrgID %in% allOrgCodes) {
    message("Please, make sure you enter a valid organism ID.\nYou can check a list of available organism IDs by invoking getOrganismCodes()")
    return(invisible())
  }

  output <- NULL

  for (g in gene) {

    message(glue::glue("retrieving fitness data for {g}"))

    url <- glue::glue("https://fit.genomics.lbl.gov/cgi-bin/singleFit.cgi?orgId={OrgID}&locusId={g}&showAll=1")

    html <- rvest::read_html(url)
    table <-  try(rvest::html_table(html), silent = TRUE)

    if(! inherits(table, "try-error") & length(table) > 0) {
      table <- table |>
        purrr::pluck(1) |>
        dplyr::select(group, condition, fitness, `t score`) |>
        dplyr::mutate(gene = g,
                      group = dplyr::if_else(group == "", NA, group)) |>
        tidyr::fill(group)
    } else {
      message(glue::glue("{g} data not found in database"))
      table <- NULL
    }
    output <- dplyr::bind_rows(output, table)
  }

  return(output)
}

