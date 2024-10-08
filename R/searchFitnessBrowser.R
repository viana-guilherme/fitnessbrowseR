#' @export
searchFitnessBrowser <- function(gene = NULL, OrgID = NULL, conditionFilter = NULL) {


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

    url <- glue::glue("https://fit.genomics.lbl.gov/cgi-bin/singleFit.cgi?orgId={OrgID}&locusId={gene}&showAll=1")

    html <- rvest::read_html(url)
    table <-  try(rvest::html_table(html), silent = TRUE)

    if(class(table) != "try-error" & length(table) > 0) {
      table <- table |>
        purrr::pluck(1) |>
        dplyr::select(group, condition, fitness, `t score`) |>
        dplyr::mutate(gene = gene,
                      group = dplyr::if_else(group == "", NA, group)) |>
        tidyr::fill(group)
    } else {
      message(glue::glue("{gene} data not found in database"))
      table <- NULL
    }
    output <- dplyr::bind_rows(output, table)
  }

  return(output)
}

