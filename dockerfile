FROM rocker/verse:latest

Run R -e "install.packages('shiny')"
Run R -e "install.packages('shinydashboard')"
Run R -e "install.packages('rsconnect')"
Run R -e "install.packages('profvis')"
Run R -e "install.packages('R.utils')"
Run R -e "install.packages('shinyFiles')"
Run R -e "install.packages('shinyjs')"
Run R -e "install.packages('shinymanager')"
Run R -e "install.packages('reactlog')"
Run R -e "install.packages('styler')"
Run R -e "install.packages('reactR')"
Run R -e "install.packages('listviewer')"
Run R -e "install.packages('rjson')"
Run R -e "install.packages('shinythemes')"

COPY rsconnect.R /home/rstudio/rsconnect.R
Run R -e "source('/home/rstudio/rsconnect.R')"
