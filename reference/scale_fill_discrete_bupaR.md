# bupaR color scales

bupaR color scales

## Usage

``` r
scale_fill_discrete_bupaR(
  guide = "legend",
  na.value = "grey50",
  name = waiver()
)

scale_color_discrete_bupaR(
  guide = "legend",
  na.value = "grey50",
  name = waiver()
)

scale_fill_continuous_bupaR(
  guide = "colourbar",
  na.value = "grey50",
  name = waiver(),
  palette = c("green", "orange")
)

scale_color_continuous_bupaR(
  guide = "colourbar",
  na.value = "grey50",
  name = waiver()
)

scale_fill_gradient_bupaR(
  guide = "colourbar",
  na.value = "grey50",
  name = waiver()
)

scale_color_gradient_bupaR(
  guide = "colourbar",
  na.value = "grey50",
  name = waiver()
)

scale_fill_gradient2_bupaR(
  guide = "colourbar",
  na.value = "grey50",
  name = waiver(),
  midpoint = 0
)

scale_color_gradient2_bupaR(
  guide = "colourbar",
  na.value = "grey50",
  name = waiver(),
  midpoint = 0
)
```

## Arguments

- guide:

  Type of legend. Use "colourbar" for continuous colour bar, or "legend"
  for discrete colour legend.

- na.value:

  Colour to use for missing values

- name:

  The name of the scale. Used as the axis or legend title. If waiver(),
  the default, the name of the scale is taken from the first mapping
  used for that aesthetic. If NULL, the legend title will be omitted.

- palette:

  Color palette to be used for scale\_.\_continuous_bupaR. Can be
  "green" (default) or "orange".

- midpoint:

  The midpoint (in data value) of the diverging scale. Defaults to 0.
