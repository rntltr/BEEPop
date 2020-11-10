#' @import tibble
library(tibble)

#' Create a new instance of Community
#'
#'A community is represented by an object of class ‘beepop_community’.
#' which is composed of objects ‘beepop_population’.
#’ Such instances can be created using that function.
#' @param …             One or multiple objects of class ‘beepop_population’
#' @param label         A character indicating the community name.
#' @param interaction   A matrix gathering interaction rates between populations. If it isn’t
#’                      specified, it becomes an identity matrix with 0 the interaction with
#’                      another species or 1 the interaction with herself
#’
#' @return an instance of ‘beepop_community’
#' @export
#'
#' @examples
#’ new_community (loup = pop1, mouton = pop2, label = "Loups et moutons")
#’ com=new_community(loup = pop1, mouton=pop2, label="Loup-mouton",interaction =
#’ matrix(data=c(1,0,1,0.2) ,nrow = 2, ncol = 2))
#’ @md

new_community <- function(..., label, interaction) {

  pops <- list(...)
  pops <- as_tibble(pops)
  if (missing(interaction)) {
    interaction <- diag(ncol(pops))
  }
  if (missing(label)) {
    label = "community"
  }
  structure(pops,
            label= label,
            interaction = interaction,
            class = c("beepop_community",class(pops)))
}




#' Display the name of the species in the community
#'
#’ A community is created from objects of class ‘beepop_population’, this function
#' return the name of the species in the community
#' @param data     One or multiple objects of class ‘beepop_population’
#'
#' @return the species’ names
#' @export
#'
#' @examples
#' species(new_community)
#’
#’ @md

species.beepop_community <- function(data) {
  cat(sapply(data, species.beepop_population))
}



#' Display the growth rate for each population
#'
#' Extract growth-rate from a ‘beepop_community’ class object
#' @param data    One object of class ‘beepop_community’
#'
#' @return        A row with growth rate for each population
#' @export
#'
#' @examples
#' growth_rate.beepop_community(com)
#’ growth_rate(com)
#'
#’ @md

growth_rate.beepop_community <- function(data) {
  as.numeric(sapply(data, growth_rate.beepop_population))
}


#' Display the interaction matrix of a community
#’
#’ Extract the interaction matrix from an object ‘beepop_community’,
#' using the method “inter_mat”
#'
#' @param data    One object of class ‘beepop_community’
#'
#' @return        the interaction matrix of the community
#' @export
#'
#' @examples
#’ inter_mat ( new_community )
#’
#’ @md

inter_mat <- function(data) {
  UseMethod("inter_mat",data)
}



#' Inter_mat method for class ‘beepop_community'
#'
#’ Creates a method to extract the interaction matrix from a object of ‘beepop_community’
#’ class.
#’
#' @param data an object of class ‘beepop_community’
#'
#' @return the interaction matrix of data
#' @export
#'
#' @examples
#’ com = new_community(loup = pop1, mouton=pop2, label="Loup-mouton",interaction =
#’ matrix(data=c(1,0,1,0.2) ,nrow = 2, ncol = 2))
#’ inter_mat(com)
#’
#’ @md

inter_mat.beepop_community <- function(data) {
  attributes(data)$interaction
}




#' Print method for class `beepop_community`
#'
#' Summarize the parameters of an object of class ‘beepop_community’, return the label of
#' the community, a table of species and their size and the interaction matrix of the
#' community.
#'
#' @param      x an object of class ‘beepop_community’
#' @param ... other parameter, not used in that version;
#'
#' @export display the label, the name and size of species and the matrix of interaction
#' between the species
#'
#' @examples
#' print.beepop_community(com)
#' @md


print.beepop_community <- function (x, ...) {
  cat("Community :", attributes(x)$label, "\n")
  print.table(x)
  cat("Interaction : \n")
  print(inter_mat(x))
}
