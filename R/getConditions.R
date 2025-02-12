#' Pulls conditions available for a organism
#'
#' @param OrgID A valid fitness browser organism identifier (see getOrganismCodes())
#'
#' @param group (Optional) Show all genes with specific phenotypes for this condition
#'
#' @returns A table with all conditions available for OrgID or a table with all specific phenotypes for a given condition group (if group is not null)
#' @export
getConditions <- function(OrgID = NULL, group = NULL) {


  allOrgCodes <- getOrganismCodes() |> dplyr::pull(OrgID)

  if (is.null(OrgID) || ! OrgID %in% allOrgCodes) {
    message("Please, make sure you enter a valid organism ID.\nYou can check a list of available organism IDs by invoking getOrganismCodes()")
    return(invisible())
  }

  if (is.null(group)) {
    url <- glue::glue("https://fit.genomics.lbl.gov/cgi-bin/org.cgi?orgId={OrgID}")
    html <- rvest::read_html(url)
    table <-  try(rvest::html_table(html), silent = TRUE)

    if(! inherits(table, "try-error") & length(table) > 0) {
      table <- table |>
        purrr::pluck(1)
    } else {
      message(glue::glue("{OrgID} data not found in database. Please check for spelling errors"))
      table <- NULL
    }
    return(table)
  }
  else {
    url <- glue::glue("https://fit.genomics.lbl.gov/cgi-bin/spec.cgi?orgId={OrgID}&expGroup={utils::URLencode(group)}")
    html <- rvest::read_html(url)

    title <- html |> rvest::html_element("h2") |> rvest::html_text()
    text <- html |> rvest::html_element("#text")

    message(title)
    table <-  try(rvest::html_table(html), silent = TRUE)

    if(!inherits(table, "try-error") & length(table) > 0) {

      table <- table |> purrr::pluck(1)

      if (nrow(table) == 0) {
        message(glue::glue("No specific phenotypes for {group}"))
        return(invisible())
      }

      return(table)
    }

  }


}
