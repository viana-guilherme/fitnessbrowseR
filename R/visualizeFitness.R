#' Visualize fitness values interactively
#'
#' @param dataset A table returned by searchFitnessBrowser()
#'
#' @returns A ggplotly plot with the fitness scores for every gene in the dataset. Since this function uses `ggplotly()` under the hood, setting the interactive argument to TRUE (the default) allows hovering the points to provide more information about them
#'
#' @export

visualizeFitness <- function(dataset, interactive = TRUE) {

  plot <- ggplot2::ggplot(dataset, ggplot2::aes(
                                          y = gene,
                                          x = fitness,
                                          fill = gene,
                                          text = paste(" gene: ", gene, "<br>",
                                                       "condition: ", condition,"<br>",
                                                       "fitness: ", fitness))) +
    ggplot2::geom_point(shape = 21, size = 5, alpha = 0.65, show.legend = FALSE) +
    ggplot2::labs(x="Fitness score", y="") +
    ggplot2::theme_light() +
    ggplot2::theme(
      axis.text = ggplot2::element_text(size = 12, color = "black", family = "sans-serif"),
      axis.title = ggplot2::element_text(size = 14, color = "black", family = "sans-serif"),
      axis.line.x = ggplot2::element_line(linewidth = 1),
      panel.grid.minor = ggplot2::element_blank(),
      panel.border = ggplot2::element_blank(),
      legend.position = "none"
    )

  if(interactive) {
    plot <- plotly::ggplotly(plot, tooltip = c("text"))
  }

  return(plot)

}
