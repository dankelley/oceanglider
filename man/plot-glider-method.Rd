% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/oceanglider.R
\name{plot,glider-method}
\alias{plot,glider-method}
\title{Plot a glider Object}
\usage{
\S4method{plot}{glider}(x, which, type = "o", debug, ...)
}
\arguments{
\item{x}{A \code{glider} object, i.e. one inheriting from \linkS4class{glider}.}

\item{which}{Integer or character value specifying which style is
to be used; see \dQuote{Details}.}

\item{type}{Type of plot, as defined in \code{\link[=par]{par()}}, e.g. \code{"p"} (the
default) for points, \code{"l"} for connected line segments, or \code{"o"}
for an overlay of points and lines, etc. The default is \code{"o"}, which is
perhaps the best for short sequences.}

\item{debug}{an integer specifying whether debugging information is
to be printed during processing. If this is not provided, then
the value of \code{\link{getOption}("gliderDebug",0)} is used.
The printing is done by a call to \code{\link{gliderDebug}}.
Setting \code{debug=0} turns off this form of debugging, while
higher values may yield more information, depending on the
function. If one \code{glider} function calls another, it
passes the value of \code{debug} but decreased by 1, which means
that the value of \code{debug} controls not just the breadth
of debugging, but also the depth.}

\item{...}{ignored.}
}
\description{
This is a limited function that is intended for quick views of a dataset.
More serious analysis is best done by extracting data and using whatever
graphical methods work well for the task at hand.
}
\details{
The form of the plot is set by the \code{which} argument, as follows.

\itemize{

\item \code{which=0} or \code{which="map"}: plot a map of sampling locations. This
can be quite slow with the default plot type, so try e.g.
\code{plot(g, type="l")} to speed things up for a quick look at the data.
In many cases, that quick look might be followed by the drawing of
a larger view, including a coastline, with functions provided for
\code{coastline} objects in the \CRANpkg{oce} package.

\item \code{which=1} or \code{which="p"}: time-series plot
of pressure versus time. This
is done using \code{\link[oce:oce.plot.ts]{oce::oce.plot.ts()}},
which also makes the other time-series plots listed below.

\item \code{which=2} or \code{which="T"}: time-series temperature plot

\item \code{which=3} or \code{which="S"}: time-series salinity plot

\item \code{which=4} or \code{which="TS"}: temperature-salinity diagram,
with dots for data and labels indicating density anomaly; see
\code{\link[oce:plotTS]{oce::plotTS()}} for details.

\item \code{which=5} or \code{which="navState"}: time-series of the
navigation state, stored as the \code{navState} item within
the \code{payload1} element of the \code{data} slot. The meanings
of the \code{navState} values for \code{seaexplorer} data
are:

\itemize{

\item \code{105}: glider is not navigating yet

\item \code{115}: glider is surfacing, with ballast and
centre of gravity being adjusted to put antenna out
of the water

\item \code{116}: glider is at the surface,
acquiring a GPS signal, and communicating

\item \code{110}: ballast and centre of mass are
adjusted to cause glider to inflect downward

\item \code{100}: ballast is in diving position; adjustments
may be made to adjust pitch and heading

\item \code{118}: target depth or altitude has been achieved,
so ballast and centre of mass are adjusted to inflect glider
upwards

\item \code{117}: glider is ascending, with controls being
adjusted for desired pitch and heading

}

Lines and notes in the plot border indicate these states, both
numerically and with phrases, as inferred by
\code{\link[=navStateCodes]{navStateCodes()}}.

}
}
\examples{
library(oceanglider)

## Examples 1: a single yo of low-resolution real-time data
dirRealtime <- system.file("extdata/seaexplorer/sub", package="oceanglider")
g <- read.glider.seaexplorer.realtime(dirRealtime, yo=100)
plot(g, which="p")
plot(g, which="S")
plot(g, which="T")
plot(g, which="TS") # note odd connections between points
plot(g, which="map")
plot(g, which="navState")

# Example 2: navState and pressure history of some delayed-mode yos,
# from a deployment in which sampling was supposed to be
# suppressed during the descending phases of motion.
dirRaw <- system.file("extdata/seaexplorer/raw", package="oceanglider")
g <- read.glider.seaexplorer.delayed(dirRaw)
plot(g, which="navState")

# Note: colormap and drawPalette are oce functions.
cm <- colormap(g[["temperature"]])
# Note the setting of mar, here and in th plot.
par(mar=c(2, 3.5, 2, 4))
drawPalette(colormap=cm)
plot(g, which="p", type="p", cex=1/3, col=cm$zcol, mar=c(2, 3.5, 2, 4))

}
