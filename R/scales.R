


#' bupaR color scales
#'
#' @param guide Type of legend. Use "colourbar" for continuous colour bar, or "legend" for discrete colour legend.
#' @param na.value Colour to use for missing values
#' @param name The name of the scale. Used as the axis or legend title. If waiver(), the default, the name of the scale is taken from the first mapping used for that aesthetic. If NULL, the legend title will be omitted.
#' @param midpoint The midpoint (in data value) of the diverging scale. Defaults to 0.
#' @param palette Color palette to be used for scale_._continuous_bupaR. Can be "green" (default) or "orange". 
#' @export
#'

scale_fill_discrete_bupaR <- function(guide = "legend", na.value = "grey50", name = waiver()) {
  scale_fill_manual(guide = guide, na.value = na.value, name = name, values = col_vector())
}

#' @rdname scale_fill_discrete_bupaR
#' @export
scale_color_discrete_bupaR <- function(guide = "legend", na.value = "grey50", name = waiver()) {
  scale_color_manual(guide = guide, na.value = na.value, name = name, values = col_vector())
}
#' @rdname scale_fill_discrete_bupaR
#' @export
scale_fill_continuous_bupaR <- function(guide = "colourbar", na.value = "grey50", name = waiver(), palette = c("green","orange")) {
  palette = match.arg(palette)
  if(palette == "green") {
    scale_fill_gradient(low = "#70D0CF",
                        high = "#00282A",
                        guide = guide,
                        na.value = na.value,
                        name = name)
  } else if(palette == "orange") {
    scale_fill_gradient(low = "#FF8749",
                        high = "#A93800",
                        guide = guide,
                        na.value = na.value,
                        name = name)
  }
}
#' @rdname scale_fill_discrete_bupaR
#' @export
scale_color_continuous_bupaR <- function(guide = "colourbar", na.value = "grey50", name = waiver()) {
  scale_color_gradient(low = "#70D0CF",
                       high = "#00282A",
                       guide = guide,
                       na.value = na.value,
                       name = name)
}
#' @rdname scale_fill_discrete_bupaR
#' @export
scale_fill_gradient_bupaR <- function(guide = "colourbar", na.value = "grey50", name = waiver()) {
  scale_fill_gradient(low = "#339999",
                      high = "#FF8749",
                      guide = guide,
                      na.value = na.value,
                      name = name)
}
#' @rdname scale_fill_discrete_bupaR
#' @export
scale_color_gradient_bupaR <- function(guide = "colourbar", na.value = "grey50", name = waiver()) {
  scale_color_gradient(low = "#339999",
                       high = "#FF8749",
                       guide = guide,
                       na.value = na.value,
                       name = name)
}
#' @rdname scale_fill_discrete_bupaR
#' @export
scale_fill_gradient2_bupaR <- function(guide = "colourbar", na.value = "grey50", name = waiver(), midpoint = 0) {
  scale_fill_gradient2(low = "#339999",
                       mid = "#95B1B0",
                       high = "#FF8749",
                       midpoint = midpoint,
                       guide = guide,
                       na.value = na.value,
                       name = name)
}
#' @rdname scale_fill_discrete_bupaR
#' @export
scale_color_gradient2_bupaR <- function(guide = "colourbar", na.value = "grey50", name = waiver(), midpoint = 0) {
  scale_color_gradient2(low = "#339999",
                        mid = "#95B1B0",
                        high = "#FF8749",
                        midpoint = midpoint,
                        guide = guide,
                        na.value = na.value,
                        name = name)
}

col_vector <- function() {
  c("#339999", "#8ADA8A","#FF8749","#6C6DAF","#008FAD", "#A44165",
    "#005E5E", "#5DBE7C","#A93800", "#AC76C6", "#70D0CF" , "#935592",
    "#324B4B","#1F884B","#956F5D", "#7E88BC", "#00C9CE","#4A5787",
    "#428E78", "#007851",  "#7F4C35", "#3681B7",
    "#009EC0",
    "#95B1B0",
    "#849237",   "#00282A")
}
