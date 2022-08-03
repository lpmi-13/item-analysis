# Item analysis for simple assessments

This is an attempt to make it easy for instructors or materials designers to run item analysis on the assessment instruments they create.

Ideally it would be a fully integrated web service that would be available via a RESTful endpoint to take in data and spit back out item analysis, but that's a long ways off for the moment.

## current running process

```
docker build -t r-server .
```

then

```
docker run -it --rm -p 8787:8787 -e PASSWORD=DEFAULT_PASSWORD r-server
```

> the password you pass through above is the password you'll need to log into rstudio

You should now be able to access the rstudio instance at `localhost:8787` with the following credentials

username: `rstudio`
password: `DEFAULT_PASSWORD`

Once in the rstudio console, run this in the console and it should open up the ShinyItemAnalysis app in a new browser tab at a URL like `http://localhost:8787/p/61c1cf40/`.

```
ShinyItemAnalysis::startShinyItemAnalysis()
```

## todo

I'm still working on locking down the data format for what we want to run analysis on. It looks like it can be a csv delimited by commas. The supplementary material available from the original paper gives us a clue about what it might look like.

https://journal.r-project.org/archive/2018/RJ-2018-074/index.html

Once the data format can be specified, we can note down in this README what format to use so the analysis can be seen in the browser with the docker container running.

Ideal end state is the user can start the container, with the files from the local file system mounted inside the container, and the version of rstudio running at localhost would be able to provide the analysis either in html or pdf.
