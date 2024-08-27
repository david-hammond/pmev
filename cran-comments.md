## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Second Submission

### NOTE 1
CRAN Request: The Title field should be in title case. Current version is:
     'Calculates Earned Value for A Project Schedule'
   In title case that is:
     'Calculates Earned Value for a Project Schedule'
     
Response: This has been corrected.

### NOTE 2

CRAN Request: Is there some reference about the method you can add in the Description
field in the form Authors (year) <doi:10.....>?

Response: This has been added.

## R CMD check results

0 errors | 0 warnings | 0 notes

### Version 0.1.2 Submission

## Test 1: R CMD check

── R CMD check results ───────────────────────────────────────────────────────────────────────────────────────────────────── pmev 0.0.2 ────
Duration: 40.3s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

## Test 2: Spell Check

`devtools::spell_check()` returns no legitimate spelling errors

## Test 3: Goodpractice

I run `goodpractice::gp()` succesfully with the following message

♥ Wow! Glorious package! Keep up the ace work!

## Test 4: Check

On running: `devtools::check(remote = TRUE, manual = TRUE)`

I receive the following notes:

❯ checking HTML version of manual ... NOTE Skipping checking HTML validation: no command 'tidy' found

This note has been suggested not to be an issue. <https://stackoverflow.com/questions/74857062/rhub-cran-check-keeps-giving-html-note-on-fedora-test-no-command-tidy-found>


## Test 5: Windows

On running:

`devtools::check_win_devel()`

I receive the one NOTE on `new submission`. Ignoring as this is a new submission.


## Test 6: Mac

On running:

`devtools::check_mac_release()`

I receive no errors.

## Test 7: Rhub

I run `rhub::rhub_setup()` and `rhub::rhub_doctor()`

After this all `rhub::rhub_check()` are successful except for:

-   `c23` Error: ! error in pak subprocess Caused by error in `file(con, "rb")`: ! cannot open the connection

    -   Ignoring as this seems to be a container issue


-   `rchk` Error: bcheck output file does not exist

    -   Ignoring again as this seems a container issue.
