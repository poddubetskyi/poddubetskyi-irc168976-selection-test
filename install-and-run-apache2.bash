#!/usr/bin/env bash

if ! [ $(id -u) = 0 ] ; then
   printf 'ERROR: This script must be run with root privileges\n'
   exit 1
fi

testIsApacheUpAndRunning () {
  service apache2 status | grep --ignore-case --count --fixed-strings 'active (running)'
}

requiredBinaries='apt curl'

binariesToBeInstalled='apache2'

if ! which ${requiredBinaries} > /dev/null ; then
  printf 'ERROR: Some of the required binaries are not found:\n'
  printf 'the command `which %s` results in\n %s\n' \
         "${requiredBinaries}" \
         "$(which ${requiredBinaries})"
  exit 2
fi

#if which ${binariesToBeInstalled} > /dev/null ; then
#
#  if [ $(apt search '^apache2$' | grep --fixed-strings --) ]
#  printf 'ERROR: Some binaries that must be installed\n'
#  printf 'already exist in the system:\n'
#  printf 'the command `which %s` results in\n %s\n' \
#         "${binariesToBeInstalled}" \
#         "$(which ${binariesToBeInstalled})"
#  exit 3
# fi

apt update --assume-yes

apt install --assume-yes apache2

installationStatus=${?}

if ! [ ${installationStatus} = 0 ] ; then
  printf 'ERROR: The installation process exits with non-zero status: %s\n' ${installationStatus}
  exit 4
fi

if ! which ${binariesToBeInstalled} > /dev/null ; then
  printf 'ERROR: Some of the installed binaries are not found:\n'
  printf 'the command `which %s` results in\n %s\n' \
         "${binariesToBeInstalled}" \
         "$(which ${binariesToBeInstalled})"
  exit 5
fi

if ! [ $(testIsApacheUpAndRunning) -gt 0 ] ; then
  service apache2 start
  if ! [ $(testIsApacheUpAndRunning) -gt 0 ] ; then
    printf 'ERROR: Cannot start Apache HTTP Server:\n'
    exit 6
  fi
fi

mv /var/www/html/index.html /var/www/html/index.html.orig

printf '<html><title>The answer to the 40th question '\
 'of DevOps GL BaseCamp IRC168976 Selection Test</title>'\
 '<body>Volodymyr Poddubetskyi</body></html>' > /var/www/html/index.html

pageCreationStatus=${?}

if ! [ ${pageCreationStatus} = 0 ] ; then
  printf 'ERROR: The page creation process exits with non-zero status: %s\n' ${pageCreationStatus}
  exit 7
fi

chmod =644 /var/www/html/index.html

amIOnThePage=$(curl -s http://127.0.0.1/ | grep --ignore-case --count --fixed-strings 'Volodymyr Poddubetskyi')

if [ ${amIOnThePage} -gt 0 ] ; then
  printf 'Installation completed successfully\nIt can be checked by visiting http://127.0.0.1/ with a web browser\n'
fi
