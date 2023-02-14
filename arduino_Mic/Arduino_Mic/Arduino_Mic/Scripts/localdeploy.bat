@echo off
cls

::::::::::::::::::::::::::::::::::::::::::::::::::::::
::: Launches all deployment scripts
:::
::: %1 Solution Directory
::: %2 Project Directory
::: %3 avrdude path
::: %4 avrdude config
::: %5 ATPROGRAM path
::: %6 library path
::: %7 header path
:::
::: Feel free to add additional parameters to the deploy.bat step to support additional scripts.
:::::::::::::::::::::::::::::::::::::::::::::::::::::::

cd %2
cd scripts
call ld-program.bat %1 %2 %3 %4 %5 %6 %7


