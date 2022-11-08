# DevOps GL BaseCamp IRC168976 Selection Test

## Short description

This repository contains a script named `install-and-run-apache2.bash`, that is created as a response to the question #40 of DevOps GL BaseCamp IRC168976 Selection Test.

The script provides an automated installation of The Apache HTTP Server, creation of a page with the name and surname of the author and publication it on the installed server, testing of the result of the publication.

The script is developed to use in Ubuntu 20.04.5 environment and hasn't been tested in other environments.

Running the script requires elevated privileges.

The script is developed in assumption that The Apache HTTP Server hasn't be installed into the OS yet.

## Usage

### Running the script

The following BASH CLI command can be used to run the script:

```
curl --silent --location https://github.com/poddubetskyi/poddubetskyi-irc168976-selection-test/raw/main/install-and-run-apache2.bash | sudo bash -s
```

The following text is expected to be displayed as a result of successful installation and readiness to visit the published page with a web browser:

```
Installation completed successfully
It can be checked by visiting http://127.0.0.1/ with a web browser
```
