# R-shiny-postgres-connect

The connection URI paramteters should be stored in a file called **.env**.

The file should in the same directory as the app.R file.

To read more about the loading of these paramters visit: https://cran.r-project.org/web/packages/dotenv/dotenv.pdf 

# Securing the .env file in the server 

As the root user, type:

```
chmod 600 .env
```

This will restrict any writing, reading and executing of the file in the server.

# Running the shiny app from the command line 

```
Rscript -e 'library(methods); shiny::runApp("app.R", launch.browser = TRUE)'
```