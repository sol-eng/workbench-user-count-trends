# workbench-user-count-trends
An R script to create a plot to get insights into the user count evolution on Posit Workbench

## Instructions

### Prerequisites

* a recent version of R with the `renv` package preinstalled as prerequisite. 
* a copy of the `r-sessions.csv` file from the [session auditing](https://support.posit.co/hc/en-us/articles/231612428-Session-Auditing-in-RStudio-Workbench-RStudio-Server-Pro) stored in the `data` sub folder
* set the working directory within the R session to the same location you cloned this Github repo into.  

### Set up the `renv` environment

You will need to run within the R console 

```
renv::restore()
```

which will install all needed R package in a virtual environment. 

### Create the output plot.

Once this is done, you can run the actual script `run.R` via 

```
source("run.R")
```

Alternatively you can run the script via `Rscript run.R` outside of the R console on the command line as well. 

The script will read `r-sessions.csv` and create a `png` file called `plot.png` which contains your desired user statistics.
