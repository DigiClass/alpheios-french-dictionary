# Workflow

## Pre-requisites

- download the special version of Eulexis for your platform for Windows or MacOS (you should have received the download link by email)
- make sure you have access to the [correction assignment spreadsheet](https://docs.google.com/spreadsheets/d/1b5ZhASSGfPxrvmyaOwH9x513GdBgsw9IsRWmZQ9vEoc/edit#gid=0) (open an issue in this repository if you don't and you'd like to help with the corrections)

## 0. Get a local copy of the data

- Clone the repository <https://github.com/DigiClass/alpheios-french-dictionary>
- Alternatively, you can get a copy of the data via Dropbox

## 1. Check corrections assigned to you

- in the spreadsheet select "Data → Filter views → assigned to \<your initials\>"
- this will allow you to display only the names of files assigned to you for correction

## 2. Correct some files

- Locate the data folder inside your local copy of the repository (`alpheios-french-dictionary/data/`)
- Launch Eulexis (see these instructions to use the correction tool in Eulexis)
- when prompted by Eulexis, navigate to `alpheios-french-dictionary/data/corrections/first-batch/todo/`

- Open one of the files assigned to you as per shared spreadhseet (see previous step), for example `first_011.csv`
- Carry out the corrections as explained [here](./mode_d_emploi.md)

- When finished with corrections do the following:
  - move the file `first_011.csv` from `first-batch/todo/` to `first-batch/done/`
  - in the folder `first-batch/todo/` Eulexis will have created a file called `first_011_revu.csv`: this file contains your corrections and should be moved to `first-batch/verified/`

## 3. Mark corrections as done

- go to the spreadsheet, select the line corresponding to the file you've corrected (e.g. `first_011.csv`) and tick the "done" checkbox

## 4. Share your corrections with the others

It's up to you to decide when to do this: it can be after each file corrected, or once you've corrected them all. Use `git add ...`, `git commit ...` and `git push origin master` to push your changes to the remote GH repository.

Alternatively, you can share your corrections via Dropbox. 