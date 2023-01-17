# Overview

This repo contains code and data to show example use of the gource visualization tool.

## Setup

If you don't have gource available locally follow the installation guide found on the website [https://gource.io](https://gource.io).

The source and documentation is found on GitHub [https://github.com/acaudwell/Gource](https://github.com/acaudwell/Gource)

> Please donate to this project if you use it. It is a great tool.

**Installation**

You can download the executable and extract it into the bin folder in this repo.

Let me set it up for you

~~~powershell

PS > cd ./scripts
PS scripts> New-Setup.ps1
 missing executable, downloading
 Download complete, unzipping files
 Files unzipped. Removing downloaded archive.
PS scripts> _ 
~~~

Once available you can use the executable. There is no need to install the package.

## Direct usage

By default gource.exe will read from the path provided using the `--path` parameter.

If no path is provided it will try and read from the current folder. Provided this is a supported repository it will generate the visualization. If not is will fail.

This is the least involved way of using the tool. Just point it to a repository and start the animation.

## Indirect usage

There might be times where you want to modify the data used by gource for visualization.
To have full creative control over the data use the `--output-custom-log FILE` command line argument to store the output in a plain text file.

If multiple files merged, remember to sort each line by the timestamp before storing the result.

~~~powershell
PS > cat *.txt | sort | Out-File -FilePath all-combined.txt 
~~~

This text file can be targeted using the `--path FILE` argument on the command line later.

This is useful if you want to show the timeline for multiple repos in the same animation.

## Custom data

You can create your data from many data sources. The file format needed by gource to create the visualization is fairly simple.

The command needed to create the needed output for a git repository is this:

~~~powershell
PS > ./bin/gource.exe --log-command git
PS > git log --pretty=format:user:%aN%n%ct --reverse --raw --encoding=UTF-8 --no-renames --no-show-signature

~~~

The output from this command needs to be formatted like this:

~~~csv
timestamp|username|action|path
~~~

`timestamp` is the unix timstamp since epoc

`username` is the registered username in the git log file

`action` is A=add, M=modified, D=deleted

`path` is the full path to the file that is impacted by the action

This is useful as it allows us to modify parts of the logfile as needed.

It is good to know you can create the needed data from any source you can think of. I does not need to be a repository. As long there is a timestamp, an actor, an action and a path (whatever that means) the data can be visualized.

There might be a need to anonymize usernames and paths even.

All these parts will impact the way the visualization is created. It can be very useful to modify parts of the data.

Let's say we want to group multiple repositories by team. This can be done by prefixing each repository with the name of the team that the repository belongs to.

Try and replace the `'|/'` with `'|teamname/'` in the datafile.

## Settings

A short description of the settings that have been tested so far.

### Branch

By default only the current/active branch will be used. Other branches can be targeted by using arguments to the executable.

To target a different branch use the `--branch BRANCHNAME` as an argument

One cool usecase could be to visualize the merges from feature branches of even long lived development branches to the main branch.

The branch name could be part of the prefix or displayed as a seperate repository, When merged and the branch is deleted this could rock the animation :)
