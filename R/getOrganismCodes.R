#' Retrieves organisms available in the Fitness Browser database
#' @param filter (Optional) A string to be used for subsetting the organism list
#'
#' @returns A two-column table with organism/strain names and their corresponding IDs
#' @export
getOrganismCodes <- function(filter = NULL) {

  url <- glue::glue("https://fit.genomics.lbl.gov/cgi-bin/orgAll.cgi")
  html <- rvest::read_html(url) |>
    rvest::html_elements("a")

  table <- tibble::tibble(Organism = rvest::html_text(html),
                          OrgID = rvest::html_attr(html, "href")
  ) |>
    dplyr::filter(stringr::str_detect(Organism, "[aA-zZ]"),
                  stringr::str_detect(OrgID, "\\?orgId=")) |>
    dplyr::mutate(OrgID = stringr::str_extract(OrgID, "(?<=orgId=).+"))

  if(!is.null(filter)) {
    table <- table |> dplyr::filter(stringr::str_detect(Organism, filter))
  }

  return(table)
}
