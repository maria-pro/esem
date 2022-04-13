esem <- function(animal, sound) {
  assertthat::assert_that(
    assertthat::is.string(animal),
    assertthat::is.string(sound)
  )
  paste0("The ", animal, " goes ", sound, "!")
}
