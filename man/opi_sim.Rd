% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/opi_sim.R
\name{opi_sim}
\alias{opi_sim}
\title{Simulates the opinion expectation distribution
of a digital text document.}
\usage{
opi_sim(osd_data, nsim=99, metric = 1, fun = NULL, quiet=TRUE)
}
\arguments{
\item{osd_data}{A list (dataframe). An \code{n} x \code{3}
OSD, in which \code{n} represents the length of the
text records that have been successfully classified as
expressing positive, negative or a neutral sentiment.
Column \code{1} of the OSD is the text record ID,
column \code{2} shows the sentiment classes (i.e. positive,
negative, or neutral), while column \code{3} contains two
variables: \code{present} and \code{absent} indicating records that
include and records that do not include any of the specified
theme keywords, respectively.}

\item{nsim}{(an integer) Number of replicas (ESD) to simulate.
Recommended values are: 99, 999, 9999, and so on. Since the run time
is proportional to the number of replicas, a moderate number of
simulation, such as 999, is recommended. Default: \code{99}.}

\item{metric}{(an integer) Specify the metric to utilize for the
calculation of the opinion score. Default: \code{1}. See
details in the documentation of \code{opi_score} function.
The input argument here must correspond to that of \code{opi_score}
function in order to compute a statistical significance value (p-value).}

\item{fun}{A user-defined function given that parameter
\code{metric} is set equal to \code{5}. See details in the
documentation of the \code{opi_score} function.}

\item{quiet}{(TRUE or FALSE) To suppress processing
messages. Default: \code{TRUE}.}
}
\value{
Returns a list of expected opinion scores with length equal
to the number of simulation (\code{nsim}) specified.
}
\description{
This function simulates the expectation distribution of the
observed opinion score (computed using the \code{opi_score} function).
The resulting tidy-format dataframe can be described as the
\verb{expected sentiment document (ESD)} (Adepeju and Jimoh, 2021).
}
\details{
Employs non-parametric randomization testing approach in
order to generate the expectation distribution of the observed
opinion scores (see details in Adepeju and Jimoh 2021).
}
\examples{

#Prepare an osd data from the output
#of `opi_score` function.

score <- opi_score(textdoc = policing_dtd,
                     metric = 1, fun = NULL)
#extract OSD
OSD <- score$OSD
#note that `OSD` is shorter in length
#than `policing_dtd`, meaning that some
#text records were not classified

#Bind a fictitious indicator column
osd_data2 <- data.frame(cbind(OSD,
           keywords = sample(c("present","absent"), nrow(OSD),
           replace=TRUE, c(0.35, 0.65))))

#generate expected distribution
exp_score <- opi_sim(osd_data2, nsim=99, metric = 1,
                                 fun = NULL, quiet=TRUE)
#preview the distribution
hist(exp_score)

}
\references{
(1) Adepeju, M. and Jimoh, F. (2021). An Analytical
Framework for Measuring Inequality in the Public Opinions on
Policing – Assessing the impacts of COVID-19 Pandemic using
Twitter Data. https://doi.org/10.31235/osf.io/c32qh
}
